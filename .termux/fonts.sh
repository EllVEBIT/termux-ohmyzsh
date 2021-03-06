#!/data/data/com.termux/files/usr/bin/bash
DIR=`cd $(dirname $0) && pwd`
FONTS_DIR=$DIR/fonts
count=0

echo -e "Шрифт по умолчанию - шрифт Ubuntu.\nВы можете выбрать другой из списка ниже.";

for font in $FONTS_DIR/*/{*.ttf,*.otf}; do
	font_file[count]=$font;
	echo "[$count] $( echo ${font_file[count]} | awk -F'/' '{print $NF}' )";
	count=$(( $count + 1));
done;
count=$(( $count - 1 ));

while true; do
	read -p 'Введите номер,оставьте поле пустым,чтобы не менять:' number;

	if [[ -z "$number" ]]; then
		break;
	elif ! [[ $number =~ ^[0-9]+$ ]]; then
		echo "Пожалуйста, введите правильный номер!";
	elif (( $number >= 0 && $number <= $count )); then
		cp -fr "${font_file[number]}" "$DIR/font.ttf";
		break;
	else
		echo "Пожалуйста, введите правильный номер!";
	fi
done;

termux-reload-settings
