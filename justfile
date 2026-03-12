alias i := install
alias r := run

install:
    ansible-galaxy install -r requirements.yml

run:
    ansible-playbook deploy.yml --ask-become-pass
