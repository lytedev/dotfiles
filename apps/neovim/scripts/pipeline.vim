edit $PIPELINE_IN
split $PIPELINE_TRANSFORM
split $PIPELINE_OUT

let s:refresh_output = {j, d, e -> execute('checktime')}
let s:refresh_output_job = {'spec': ['inotifywait', '-m', '-e', 'close_write,delete', $PIPELINE_OUT], 'opts': {'detach': 1, 'on_stdout': s:refresh_output}}
let s:refresh_output_job_id = jobstart(s:refresh_output_job['spec'], s:refresh_output_job['opts'])

function s:RunPipeline()
	execute "!".g:pipeline_transform
endfunction

let s:refresh_output_job_id = jobstart(s:refresh_output_job['spec'], s:refresh_output_job['opts'])

set updatetime=250
" only autosave the input buffer
autocmd CursorHold,CursorHoldI <buffer> silent write
autocmd FileWritePost silent call s:RunPipeline()
autocmd VimLeavePre call jobstop(s:refresh_output_job_id)
autocmd VimLeavePre call jobstop(s:run_pipeline_job_id)
