#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'minikube-install'
fi

minikube-install() {
    echo "Installing minikube..."
    brew update

    for pkg in docker-machine-driver-xhyve kubernetes-cli Caskroom/cask/minikube kubernetes-helm; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            echo "upgrading: $pkg"
            brew upgrade $pkg 1>/dev/null 2>&1
            brew link --overwrite $pkg 1>/dev/null 2>&1
        else
            echo "installing: $pkg"
            brew install $pkg 1>/dev/null 2>&1
        fi
    done

    echo "Setting ownership of docker-machine-driver-xhyve: you will be prompted for your password..."
    sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
    sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

    echo "Configuring minikube to use xhyve..."
    minikube config set vm-driver xhyve

    echo "Starting minikube..."
    minikube start --insecure-registry localhost:5000

    echo "Installing helm and tiller..."
    helm init

    echo "Using docker environment from minikube..."
    eval $(minikube docker-env)

    echo "Install the docker registry into kubernetes..."
    kubectl apply -f local/kube-registry.yml
}