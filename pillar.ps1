# pillar.ps1
# Usage: ./pillar.ps1 command container

param( [Parameter(Mandatory=$true)] $command, $container="php80", $project=$null)

function Keys {
    docker container exec -w /root php80 ./keys.sh
    docker container exec -w /root php74 ./keys.sh
    docker container exec -w /root node ./keys.sh

    Write-Output "Updated containers keys"
}

If ($command -eq "rebuild") {
    docker-compose down -v
    docker-compose up -d --build
    Keys
}

If ($command -eq "build") {
    docker-compose up -d --build
    Keys
}

If ($command -eq "remove") {
    docker-compose down -v
}

If ($command -eq "restart") {
    docker-compose down
    docker-compose up -d
    Keys
}

If ($command -eq "stop") {
    docker-compose down
}

If ($command -eq "start") {
    docker-compose up -d
    Keys
}

If ($command -eq "bash") {
    docker container exec -it -w /repos $container bash
}

If ($command -eq "composer-install") {
    If ($project -ne $null) {
        docker container exec -it -w $project $container composer install
    }
}

If ($command -eq "composer-update") {
    If ($project -ne $null) {
        docker container exec -it -w /repos/$project $container composer install
    }
}

If ($command -eq "composer-dump") {
    If ($project -ne $null) {
        docker container exec -it -w /repos/$project $container composer dump-autoload
    }
}