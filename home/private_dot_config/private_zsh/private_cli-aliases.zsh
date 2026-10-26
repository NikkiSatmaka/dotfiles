# Command aliases/functions retained from Oh My Zsh, without completion generators.
# Upstream: https://github.com/ohmyzsh/ohmyzsh at d2b7f557cceaddb16ba89bbf8200d8a8df35c4d8
# Refresh completions separately with shell/refresh-completions.sh.
#
# MIT License
# 
# Copyright (c) 2009-2026 Robby Russell and contributors (https://github.com/ohmyzsh/ohmyzsh/contributors)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# docker
alias dbl='docker build'
alias dcin='docker container inspect'
alias dcls='docker container ls'
alias dclsa='docker container ls -a'
alias dcprune='docker container prune'
alias dib='docker image build'
alias dii='docker image inspect'
alias dils='docker image ls'
alias dipu='docker image push'
alias dipru='docker image prune -a'
alias dirm='docker image rm'
alias dit='docker image tag'
alias dlo='docker container logs'
alias dnc='docker network create'
alias dncn='docker network connect'
alias dndcn='docker network disconnect'
alias dni='docker network inspect'
alias dnls='docker network ls'
alias dnprune='docker network prune'
alias dnrm='docker network rm'
alias dpo='docker container port'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dpu='docker pull'
alias dr='docker container run'
alias drit='docker container run -it'
alias drm='docker container rm'
alias 'drm!'='docker container rm -f'
alias dsprune='docker system prune'
alias dst='docker container start'
alias drs='docker container restart'
alias dsta='docker stop $(docker ps -q)'
alias dstp='docker container stop'
alias dsts='docker stats'
alias dtop='docker top'
alias dvi='docker volume inspect'
alias dvls='docker volume ls'
alias dvprune='docker volume prune'
alias dxc='docker container exec'
alias dxcit='docker container exec -it'


# kubectl
if (( $+commands[kubectl] )); then
alias k=kubectl

# Execute a kubectl command against all namespaces
alias kca='_kca(){ kubectl "$@" --all-namespaces;  unset -f _kca; }; _kca'

# Apply a YML file
alias kaf='kubectl apply -f'

# Apply a kustomization directory
alias kapk='kubectl apply -k'

# Drop into an interactive terminal on a container
alias keti='kubectl exec -t -i'

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='kubectl config use-context'
alias kcsc='kubectl config set-context'
alias kcdc='kubectl config delete-context'
alias kccc='kubectl config current-context'
alias kcrc='kubectl config rename-context'

# List all contexts
alias kcgc='kubectl config get-contexts'

# General aliases
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'
alias kdelk='kubectl delete -k'
alias kge='kubectl get events --sort-by=".lastTimestamp"'
alias kgew='kubectl get events --sort-by=".lastTimestamp" --watch'

# Pod management.
alias kgp='kubectl get pods'
alias kgpl='kgp -l'
alias kgpn='kgp -n'
alias kgpsl='kubectl get pods --show-labels'
alias kgpa='kubectl get pods --all-namespaces'
alias kgpw='kgp --watch'
alias kgpwide='kgp -o wide'
alias kep='kubectl edit pods'
alias kdp='kubectl describe pods'
alias kdelp='kubectl delete pods'
alias kgpall='kubectl get pods --all-namespaces -o wide'

# Service management.
alias kgs='kubectl get svc'
alias kgsa='kubectl get svc --all-namespaces'
alias kgsw='kgs --watch'
alias kgswide='kgs -o wide'
alias kes='kubectl edit svc'
alias kds='kubectl describe svc'
alias kdels='kubectl delete svc'

# Ingress management
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress --all-namespaces'
alias kei='kubectl edit ingress'
alias kdi='kubectl describe ingress'
alias kdeli='kubectl delete ingress'

# Namespace management
alias kgns='kubectl get namespaces'
alias kens='kubectl edit namespace'
alias kdns='kubectl describe namespace'
alias kdelns='kubectl delete namespace'
alias kcn='kubectl config set-context --current --namespace'

# ConfigMap management
alias kgcm='kubectl get configmaps'
alias kgcma='kubectl get configmaps --all-namespaces'
alias kecm='kubectl edit configmap'
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'

# Secret management
alias kgsec='kubectl get secret'
alias kgseca='kubectl get secret --all-namespaces'
alias kesec='kubectl edit secret'
alias kdsec='kubectl describe secret'
alias kdelsec='kubectl delete secret'

# Deployment management.
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias kgdw='kgd --watch'
alias kgdwide='kgd -o wide'
alias ked='kubectl edit deployment'
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ksd='kubectl scale deployment'
alias krsd='kubectl rollout status deployment'
alias krrd='kubectl rollout restart deployment'

function kres(){
  kubectl set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S)
}

# Rollout management.
alias kgrs='kubectl get replicaset'
alias kdrs='kubectl describe replicaset'
alias kers='kubectl edit replicaset'
alias krh='kubectl rollout history'
alias kru='kubectl rollout undo'

# Statefulset management.
alias kgss='kubectl get statefulset'
alias kgssa='kubectl get statefulset --all-namespaces'
alias kgssw='kgss --watch'
alias kgsswide='kgss -o wide'
alias kess='kubectl edit statefulset'
alias kdss='kubectl describe statefulset'
alias kdelss='kubectl delete statefulset'
alias ksss='kubectl scale statefulset'
alias krsss='kubectl rollout status statefulset'
alias krrss='kubectl rollout restart statefulset'

# Port forwarding
alias kpf="kubectl port-forward"

# Tools for accessing all information
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'

# Logs
alias kl='kubectl logs'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klf='kubectl logs -f'
alias klf1h='kubectl logs --since 1h -f'
alias klf1m='kubectl logs --since 1m -f'
alias klf1s='kubectl logs --since 1s -f'

# File copy
alias kcp='kubectl cp'

# Node Management
alias kgno='kubectl get nodes'
alias kgnosl='kubectl get nodes --show-labels'
alias keno='kubectl edit node'
alias kdno='kubectl describe node'
alias kdelno='kubectl delete node'

# PVC management.
alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc --all-namespaces'
alias kgpvcw='kgpvc --watch'
alias kepvc='kubectl edit pvc'
alias kdpvc='kubectl describe pvc'
alias kdelpvc='kubectl delete pvc'

# Service account management.
alias kdsa="kubectl describe sa"
alias kdelsa="kubectl delete sa"

# DaemonSet management.
alias kgds='kubectl get daemonset'
alias kgdsa='kubectl get daemonset --all-namespaces'
alias kgdsw='kgds --watch'
alias keds='kubectl edit daemonset'
alias kdds='kubectl describe daemonset'
alias kdelds='kubectl delete daemonset'

# CronJob management.
alias kgcj='kubectl get cronjob'
alias kecj='kubectl edit cronjob'
alias kdcj='kubectl describe cronjob'
alias kdelcj='kubectl delete cronjob'

# Job management.
alias kgj='kubectl get job'
alias kej='kubectl edit job'
alias kdj='kubectl describe job'
alias kdelj='kubectl delete job'

# Utility print functions (json / yaml)
function _build_kubectl_out_alias {
  setopt localoptions norcexpandparam

  # alias function
  eval "function $1 { $2 }"

  # completion function
  eval "function _$1 {
    words=(kubectl \"\${words[@]:1}\")
    _kubectl
  }"

  compdef _$1 $1
}

_build_kubectl_out_alias "kj"  'kubectl "$@" -o json | jq'
_build_kubectl_out_alias "kjx" 'kubectl "$@" -o json | fx'
_build_kubectl_out_alias "ky"  'kubectl "$@" -o yaml | yh'
unfunction _build_kubectl_out_alias
fi

# podman
if (( $+commands[podman] )); then
alias pbl='podman build'
alias pcin='podman container inspect'
alias pcls='podman container ls'
alias pclsa='podman container ls --all'
alias pib='podman image build'
alias pii='podman image inspect'
alias pils='podman image ls'
alias pipu='podman image push'
alias pirm='podman image rm'
alias pit='podman image tag'
alias pmif='podman machine info'
alias pmit='podman machine init'
alias pmis='podman machine inspect'
alias pml='podman machine list'
alias pmo='podman machine os'
alias pmrm='podman machine rm'
alias pms='podman machine set'
alias pmss='podman machine ssh'
alias pmst='podman machine start'
alias pmsp='podman machine stop'
alias plo='podman container logs'
alias pnc='podman network create'
alias pncn='podman network connect'
alias pndcn='podman network disconnect'
alias pni='podman network inspect'
alias pnls='podman network ls'
alias pnrm='podman network rm'
alias ppo='podman container port'
alias ppu='podman pull'
alias pr='podman container run'
alias prit='podman container run --interactive --tty'
alias prm='podman container rm'
alias 'prm!'='podman container rm --force'
alias pst='podman container start'
alias prs='podman container restart'
alias psta='podman stop $(podman ps --quiet)'
alias pstp='podman container stop'
alias ptop='podman top'
alias pvi='podman volume inspect'
alias pvls='podman volume ls'
alias pvprune='podman volume prune'
alias pxc='podman container exec'
alias pxcit='podman container exec --interactive --tty'
fi

# uv
if (( $+commands[uv] )); then
alias uv="noglob uv"

alias uva='uv add'
alias uvexp='uv export --format requirements-txt --no-hashes --output-file requirements.txt --quiet'
alias uvi='uv init'
alias uvinw='uv init --no-workspace'
alias uvl='uv lock'
alias uvlr='uv lock --refresh'
alias uvlu='uv lock --upgrade'
alias uvp='uv pip'
alias uvpi='uv python install'
alias uvpl='uv python list'
alias uvpu='uv python uninstall'
alias uvpy='uv python'
alias uvpp='uv python pin'
alias uvr='uv run'
alias uvrm='uv remove'
alias uvs='uv sync'
alias uvsr='uv sync --refresh'
alias uvsu='uv sync --upgrade'
alias uvtr='uv tree'
alias uvup='uv self update'
alias uvv='uv venv'

fi
