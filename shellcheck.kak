######################
# Internal utilities #
######################

define-command -hidden -override -docstring "check whether shellcheck is installed" shellcheck-check-installed %{
    evaluate-commands %sh{
        if command -v shellcheck > /dev/null 2>&1; then
            printf "set-option window shellcheck_installed true\n"
        else
            printf "set-option window shellcheck_installed false\n"
        fi
    }
}

define-command -hidden -override -docstring "populate options with shellcheck version information" shellcheck-parse-version %{
    evaluate-commands %sh{
        version="$(shellcheck -V|egrep 'version:'|tr -s ' '|cut -d' ' -f2)"
        printf "set-option window shellcheck_major_version %d\n" "$(echo "$version" | cut -d'.' -f 1)"
        printf "set-option window shellcheck_minor_version %d\n" "$(echo "$version" | cut -d'.' -f 2)"
        printf "set-option window shellcheck_patch_version %d\n" "$(echo "$version" | cut -d'.' -f 3)"
    }
    echo -debug "Using shellcheck v%opt{shellcheck_major_version}.%opt{shellcheck_minor_version}.%opt{shellcheck_patch_version}"
}

define-command -hidden -override -docstring "enable shellcheck in the current window" shellcheck-configure-window %{
    set window lintcmd %sh{
        # format like gcc, check files other than the current buffer if they are 'source'd
        flags="-f gcc -x"
        # if version >= v0.4.7
        if [ "$kak_opt_shellcheck_minor_version" -ge 4 ] && [ "$kak_opt_shellcheck_patch_version" -ge 7 ]; then
            # enable warnings from sourced files
            flags="$flags -a"
        fi
        echo "env --chdir="$(dirname "${kak_buffile}")" shellcheck $flags"
    }
    lint-enable
    hook -group shellcheck window BufWritePre .* %{
        lint
    }
}

###############################
# Externally-visible commands #
###############################

define-command -override -docstring "enable shellcheck in the current window" shellcheck-enable %{
    evaluate-commands %sh{
        if $kak_optshellcheck_installed; then
            echo "shellcheck-parse-version"
            echo "shellcheck-configure-window"
        else
            echo "echo -debug 'Missing shellcheck executable'"
        fi
    }
}
define-command -override -docstring "disable shellcheck in the current window" shellcheck-disable %{
    lint-disable
    remove-hooks window shellcheck
}

##################
# Initialization #
##################

declare-option -hidden int shellcheck_major_version
declare-option -hidden int shellcheck_minor_version
declare-option -hidden int shellcheck_patch_version
declare-option -hidden bool shellcheck_installed

hook global WinSetOption filetype=sh %{
    # check whether binary exists
    shellcheck-check-installed
    shellcheck-enable
}
