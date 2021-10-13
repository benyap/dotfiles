function _tide_item_python_env
    test $VIRTUAL_ENV && _tide_print_item python_env $tide_python_env_icon' ' (python --version | string trim --chars=v)
end
