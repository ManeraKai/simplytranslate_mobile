# This script sees the available translations and create pug pages for them.
import os
import json

print("Pug Lang Adder")

rtl_langs = ["ar", "iw", "ku", "fa", "ur"]

template = ""
with open("docs/pug/lang/en/index.pug") as file:
    template = file.read()

for lang in os.listdir("docs/lang_pug/"):
    lang = lang.replace("index.en.pug", "")
    lang_name = lang.replace('.pug', '')
    tmp = template.replace("\"en\"", "\""+lang_name+"\"")
    tmp = tmp.replace("en.pug", lang)

    if lang in rtl_langs:
        tmp = tmp.replace("\"ltr\"", "\"rtl\"")
        tmp = tmp.replace("- var isRtl = false", "- var isRtl = true")

    dir_path = "docs/pug/lang/" + lang.replace('.pug','')

    if not os.path.exists(dir_path):
        os.makedirs(dir_path)
    
    with open(f"{dir_path}/index.{lang}", "w+") as file:
        file.writelines(tmp)

    print("Wrote: docs/pug/lang/"+lang)
