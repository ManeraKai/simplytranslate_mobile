generate_pug() {
    lang=$1
    dir=$2

    jq -s '.[0] * {"dir": "'"${dir}"'"}' docs/strings/"${lang}".json > docs/strings/"${lang}".tmp.json

    pug docs/pug/*.pug -O docs/strings/"${lang}".tmp.json -o docs/"${lang}" -P

    if [ $lang == en ]; then
        pug docs/pug/*.pug -O docs/strings/"${lang}".tmp.json -o docs/ -P
    fi

    rm docs/strings/"${lang}".tmp.json
}

generate_pug 'en' 'ltr'
# generate_pug 'ar' 'rtl'
# generate_pug 'fr' 'ltr'
# generate_pug 'nb_NO' 'ltr'
# generate_pug 'pl' 'ltr'
# generate_pug 'tr' 'ltr'

sudo rm -rf /var/www/simplytranslate_mobile/simplytranslate_mobile/*
sudo cp -r docs/* /var/www/simplytranslate_mobile/simplytranslate_mobile/