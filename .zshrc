# Configuración de Powerlevel10k para una carga rápida del prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Ruta a la instalación de oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# Configuración del tema de oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# Lista de plugins para cargar con oh-my-zsh
plugins=(command-not-found fzf git history-substring-search sudo tmux zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Alias:

# Group: Fail2Ban
alias jail='sudo fail2ban-client status' # Alias para ver el estado de Fail2Ban
alias unban-nginx='sudo fail2ban-client set nginx unbanip' # Alias para desbanear una IP de nginx
alias unban-postfix='sudo fail2ban-client set postfix unbanip' # Alias para desbanear una IP de postfix
alias unban-ssh='sudo fail2ban-client set sshd unbanip' # Alias para desbanear una IP de sshd

# Group: Gestión de Archivos
alias cpi='cp -i' # Alias para copiar archivos y directorios
alias mvi='mv -i' # Alias para mover archivos y directorios
alias rmi='rm -i' # Alias para eliminar archivos y directorios

# Group: Gestión de Servicios
alias mce='sudo systemctl start minecraft' # Alias para iniciar el servicio de Minecraft
alias mcd='sudo systemctl stop minecraft' # Alias para detener el servicio de Minecraft
alias sfe='sudo systemctl start satisfactory' # Alias para iniciar el servicio de Satisfactory
alias sfd='sudo systemctl stop satisfactory' # Alias para detener el servicio de Satisfactory
alias wbme='sudo systemctl start webmin' # Alias para iniciar el servicio de Webmin
alias wbmd='sudo systemctl stop webmin' # Alias para detener el servicio de Webmin

# Group: Listado de Directorios
alias l='lsd --group-dirs=first' # Alias para listar archivos
alias la='lsd -a --group-dirs=first' # Alias para listar todos los archivos incluyendo ocultos
alias ll='lsd -lh --group-dirs=first' # Alias para listar archivos con detalles
alias lla='lsd -lha --group-dirs=first' # Alias para listar archivos con detalles y archivos ocultos
alias ls='lsd --group-dirs=first' # Alias para listar archivos (sin detalles)

# Group: Mantenimiento del Sistema
alias c='clear' # Alias para limpiar la pantalla
alias del='sudo apt-get purge --auto-remove' # Alias para eliminar paquetes y dependencias no necesarias
alias delh='history -cw' # Alias para limpiar el historial de comandos
alias update='sudo apt-get update && sudo apt upgrade && sudo apt dist-upgrade -y' # Alias para actualizar todos los paquetes

# Group: Red
alias ip='ip a' # Alias para mostrar información de la red
alias ping='ping -c 5' # Alias para hacer ping a una dirección

# Group: Temperaturas
alias resettemps='/home/daleksec/.scripts/reset_temps.sh' # Alias para reiniciar el script de temperaturas
alias temps='watch /home/daleksec/.scripts/temps.sh' # Alias para ejecutar el script de temperaturas

# Group: tmux
alias ta='tmux attach -t' # Alias para adjuntar a una sesión tmux
alias tnew='tmux new -s' # Alias para crear una nueva sesión tmux
alias tls='tmux ls' # Alias para listar sesiones tmux

# Group: Visualización de Archivos
alias cat='/usr/bin/batcat' # Alias para usar batcat en lugar de cat
alias catn='/bin/cat' # Alias para usar cat desde su ruta original

# End Alias

aliash() {
  local in_alias_section=false

  # Colores ANSI
  local BLUE='\033[0;34m'
  local ORANGE='\033[0;33m'
  local GREEN='\033[0;32m'
  local RESET='\033[0m'

  # Leer el archivo línea por línea
  while IFS= read -r line; do
    # Detectar el inicio de la sección de alias
    if [[ "$line" =~ ^#\ Alias: ]]; then
      in_alias_section=true
      continue
    fi

    # Detectar el final de la sección de alias
    if [[ "$line" =~ ^#\ End\ Alias ]]; then
      in_alias_section=false
      continue
    fi

    # Si estamos en una sección de alias
    if $in_alias_section; then
      # Detectar el grupo y mantener el texto completo después de los dos puntos
      if [[ "$line" =~ ^#\ Group:\ (.+) ]]; then
        local group="${line#"# Group: "}"
        echo -e "\n${BLUE}# Group: ${group}${RESET}"
        continue
      fi

      # Si encontramos una línea de alias
      if [[ "$line" =~ ^alias ]]; then
        # Extraer alias y comentario
        local alias_part="${line%%#*}"   # Parte del alias
        local comment_part="${line#*#}"  # Parte del comentario

        # Imprimir alias y comentario con colores, eliminando solo el espacio adicional
        echo -e "${ORANGE}${alias_part}${RESET}${GREEN}#${comment_part}${RESET}"
      fi
    fi
  done < ~/.zshrc
}

# Carga de configuración adicional para Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Configuración del historial
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
