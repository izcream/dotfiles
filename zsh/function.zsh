
#go to home
function h() {
	cd ~/$1
}

function mdir() {
	mkdir -p $1 && cd $1
}

function dir() {
	DIRNAME=$1
	if [[ -z "$DIRNAME" ]]; then
		DIRNAME=$(gum input --placeholder="Folder name" --header "Create new Folder" --header.margin="1")
	fi
	test -z $DIRNAME && return
	mkdir -p $DIRNAME && cd $DIRNAME
	OPENED=$(gum choose "Yes" "No" --header "Open with VSCode?" --header.margin="1")
	test -z $OPENED && return
	if [[ $OPENED = "Yes" ]]; then
		code .
	fi
}

function godir() {
	DIRNAME=$1
	PKGNAME=$1
	if [[ -z "$DIRNAME" ]]; then
		DIRNAME=$(gum input --placeholder="Folder name" --header "Create new Folder" --header.margin="1")
	fi
	if [[ ! -z $2 ]]; then
		PKGNAME=$2
	fi
	mkdir -p $DIRNAME && cd $DIRNAME && go mod init $PKGNAME
	echo "🚀 Create go module $PKGNAME in $(pwd)"
	OPENED=$(gum choose "Yes" "No" --header "Open with VSCode?" --header.margin="1")
	if [[ $OPENED = "Yes" ]]; then
		code --profile go .
	fi
}


#run dev command by current node package manager tool
function dev() {
	if [[ -f $(pwd)"/yarn.lock" ]]; then
		yarn dev $@
	elif [[ -f $(pwd)"/pnpm-lock.yaml" ]]; then
		pnpm dev $@
	elif [[ -f $(pwd)"/bun.lockb" ]]; then
		bun run dev $@
	else
		npm run dev $@
	fi
}

#run build command by current node package manager tool
function build() {
	if [[ -f $(pwd)"/yarn.lock" ]]; then
		yarn build $@
	elif [[ -f $(pwd)"/pnpm-lock.yaml" ]]; then
		pnpm build $@
	elif [[ -f $(pwd)"/bun.lockb" ]]; then
		bun run build $@
	else
		npm run build $@
	fi
}

#run dev command by current node package manager tool
function start() {
	if [[ -f $(pwd)"/yarn.lock" ]]; then
		yarn start $@
	elif [[ -f $(pwd)"/pnpm-lock.yaml" ]]; then
		pnpm start $@
	else
		npm start $@
	fi
}

#colormap function Thanks: https://github.com/xcad2k/dotfiles
function colormap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}
