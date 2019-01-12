define-command -docstring "enable shellcheck in the current window" shellcheck-enable %{
    set window lintcmd "env --chdir='%sh{dirname ${kak_buffile}}' shellcheck -f gcc -x -a"
    lint-enable
    hook window BufWritePre .* %{
        lint
    }
}
