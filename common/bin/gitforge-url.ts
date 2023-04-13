#!/usr/bin/env -S deno run --allow-read --allow-run --allow-net

import * as path from "https://deno.land/std@0.181.0/path/mod.ts";

// output the best guess URL for viewing the file at the current git revision in
// the git forge's web interface

// TODO: --help, -h menu

const file = Deno.args[0];

if (!file) {
  console.error("No file argument provided");
  Deno.exit(1);
}

async function cmdOutput(cmd: string[]) {
  return new TextDecoder().decode(
    await Deno.run({
      cmd: cmd,
      stdout: "piped",
    })
      .output(),
  ).trim();
}

type ForgeType = "gitlab" | "github" | "gitea";

function getForgeType(hostname: string): ForgeType {
  if (hostname == "git.lyte.dev") {
    return "gitea";
  } else if (hostname.endsWith("github.com")) {
    return "github";
  } else {
    return "gitlab";
  }
}

function getUrl(repoRoot: string, remote: string, commit: string) {
  try {
    // try http remote
    console.log(new URL(remote));
    throw new Error("HTTP(S) remotes not implemented");
  } catch {
    const hostname = remote.split("@").slice(-1)[0].split(":")[0];
    const forgeType = getForgeType(hostname);
    let repoPath = remote.split(":")[1];
    if (repoPath.endsWith(".git")) {
      repoPath = repoPath.slice(0, -4);
    }
    let fileRepoPath = path.resolve(file);
    if (fileRepoPath.startsWith(repoRoot)) {
      fileRepoPath = fileRepoPath.slice(repoRoot.length + 1); // for the trailing slash
    } else {
      throw new Error(`File ${fileRepoPath} is not in repo at ${repoRoot}`);
    }
    switch (forgeType) {
      case "gitlab":
        return `https://${hostname}/${repoPath}/-/blob/${commit}/${fileRepoPath}`;
      case "gitea":
        return `https://${hostname}/${repoPath}/src/commit/${commit}/${fileRepoPath}`;
      case "github":
        return `https://${hostname}/${repoPath}/blob/${commit}/${fileRepoPath}`;
    }
  }
}

// TODO: cd to dir
const repoRoot = await cmdOutput(["git", "rev-parse", "--show-toplevel"]);
const remote = await cmdOutput(["git", "remote", "get-url", "origin"]);
const commit = await cmdOutput(["git", "rev-parse", "HEAD"]);
const url = getUrl(repoRoot, remote, commit);
console.log(url);
