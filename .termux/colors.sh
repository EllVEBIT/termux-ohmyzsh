#!/data/data/com.termux/files/usr/bin/bash
DIR=`cd $(dirname $0); pwd`
COLORS_DIR=$DIR/colors
count=0

echo -e "Цветовая тема по умолчанию Tango.\nВы можете выбрать другой из списка";

for colors in "$COLORS_DIR"/*; do
  colors_name[count]=$( echo $colors | awk -F'/' '{print $NF}' )
  echo -e "($count) ${colors_name[count]}";
  count=$(( $count + 1 ));
done;
count=$(( $count - 1 ));

while true; do
  read -p 'Введите номер,оставьте поле пустым,чтобы не менять:' number;
  if [[ -z "$number" ]]; then
    break;
  elif ! [[ $number =~ ^[0-9]+$ ]]; then
    echo "Пожалуйста, введите правильный номер!";
  elif (( $number>=0 && $number<=$count )); then
    eval choice=${colors_name[number]};
    cp -fr "$COLORS_DIR/$choice" "$DIR/colors.properties";
    break;
  else
    echo "Пожалуйста, введите правильный номер!";
  fi
done

termux-reload-settings
