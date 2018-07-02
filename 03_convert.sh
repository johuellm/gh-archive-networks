
# filter
for filename in *.json; do   
    
  echo $filename
  # DEPRECATED:
  # echo $filename "$(basename "$filename" .json)".csv

  # filter demo repositories
  sed -i '/"name":"tensorflow\/tensorflow"\|"name":"twbs\/bootstrap"\|"name":"github\/gitignore"\|"name":"barryclark\/jekyll-now"\|"name":"tensorflow\/models"\|"name":"vuejs\/vue"\|"name":"facebook\/react"\|"name":"jlord\/patchwork"\|"name":"spring-projects\/spring-boot"\|"name":"torvalds\/linux"\|"name":"Microsoft\/vscode"\|"name":"facebook\/react-native"\|"name":"npm\/npm"\|"name":"angular\/angular-cli"\|"name":"FortAwesome\/Font-Awesome"\|"name":"angular\/angular"\|"name":"docker\/docker"\|"name":"ansible\/ansible"\|"name":"DefinitelyTyped\/DefinitelyTyped"\|"name":"kubernetes\/kubernetes"\|"name":"Homebrew\/homebrew-core"\|"name":"nodejs\/node"\|"name":"NixOS\/nixpkgs"\|"name":"apache\/spark"\|"name":"rust-lang\/rust"\|"name":"symfony\/symfony"\|"name":"openshift\/origin"\|"name":"cms-sw\/cmssw"\|"name":"dotnet\/corefx"\|"name":"tgstation\/tgstation"\|"name":"servo\/servo"\|"name":"danistefanovic\/build"\|"name":"xingshaocheng\/architect"\|"name":"davideuler\/architecture"\|"name":"iamkun\/dayjs"\|"name":"RelaxedJS\/ReLaXed"\|"name":"trekhleb\/javascript"\|"name":"google\/gvisor"\|"name":"nhnent\/tui"\|"name":"linkedin\/css"\|"name":"CyC2018\/Interview"\|"name":"kusti8\/proton"\|"name":"klauscfhq\/signale"\|"name":"jwasham\/coding"\|"name":"olistic\/warriorjs"\|"name":"anordal\/shellharden"\|"name":"git\/isomorphic"\|"name":"flutter\/flutter"\|"name":"hendricius\/the"\|"name":"sharkdp\/bat"\|"name":"binhnguyennus\/awesome"\|"name":"mimecorg\/vuido"\|"name":"vincentriemer\/react"\|"name":"tensorflow\/easy"\|"name":"GetStream\/Winds"\|"name":"andlabs\/libui"\|"name":"hyperapp\/hyperapp"\|"name":"Tencent\/TSW"\|"name":"eleme\/UETool"\|"name":"Sisyphe\/youCanCodeAGif"\|"name":"veggiemonk\/awesome"\|"name":"org\/material"\|"name":"sym233\/core"\|"name":"krasimir\/react"\|"name":"facebook\/create"\|"name":"js\/mdx"\|"name":"axios\/axios"\|"name":"GoogleChrome\/puppeteer"\|"name":"vuejs\/vuepress"\|"name":"tmcw\/big"\|"name":"Dianping\/mpvue"\|"name":"Tencent\/wepy"\|"name":"vinta\/awesome"\|"name":"Embedding\/Chinese"\|"name":"team\/keras"\|"name":"chrissimpkins\/Crunch"\|"name":"pallets\/flask"\|"name":"cchen156\/Learning"\|"name":"toddmotto\/public"\|"name":"guardicore\/monkey"\|"name":"rg3\/youtube"\|"name":"pypa\/pipenv"\|"name":"django\/django"\|"name":"donnemartin\/system"\|"name":"rootm0s\/WinPwnage"\|"name":"learn\/scikit"\|"name":"mara\/data"\|"name":"edgedb\/edgedb"\|"name":"facebookresearch\/Detectron"\|"name":"python\/cpython"\|"name":"tw\/Detectron"\|"name":"requests\/requests"\|"name":"net\/XX"\|"name":"github\/gh"\|"name":"golang\/go"\|"name":"iikira\/BaiduPCS"\|"name":"ethereum\/go"\|"name":"francoispqt\/gojay"\|"name":"avelino\/awesome"\|"name":"gitea\/gitea"\|"name":"snail007\/goproxy"\|"name":"io\/terratest"\|"name":"getlantern\/lantern"\|"name":"gonic\/gin"\|"name":"fatedier\/frp"\|"name":"gohugoio\/hugo"\|"name":"agent\/opa"\|"name":"istio\/istio"\|"name":"astaxie\/build"\|"name":"radondb\/radon"\|"name":"gogits\/gogs"\|"name":"iotexproject\/iotex"\|"name":"containous\/traefik"\|"name":"gocolly\/colly"\|"name":"b3log\/baidu"\|"name":"prometheus\/prometheus"\|"name":"rdpeng\/ProgrammingAssignment2"\|"name":"rstudio\/r2d3"\|"name":"hadley\/stats337"\|"name":"tidyverse\/ggplot2"\|"name":"hadley\/r4ds"\|"name":"lib\/conflicted"\|"name":"rstudio\/reticulate"\|"name":"DavisVaughan\/furrr"\|"name":"tidyverse\/dplyr"\|"name":"rstudio\/shiny"\|"name":"lib\/bench"\|"name":"dev\/greta"\|"name":"rstudio\/bookdown"\|"name":"dev\/stan"\|"name":"ropensci\/drake"\|"name":"ropenscilabs\/roomba"\|"name":"Robinlovelace\/geocompr"\|"name":"pbiecek\/DALEX"\|"name":"rstudio\/rmarkdown"\|"name":"ropenscilabs\/trackmd"\|"name":"dselivanov\/text2vec"\|"name":"jdblischak\/workflowr"\|"name":"ColinFay\/fryingpane"\|"name":"org\/mlr"\|"name":"spatial\/sf"/!d' "$filename"

  # filter all backslashes and whitespaces 
  # for excel (there are some duplicate ones)
  sed -i 's/\\\\\\\\\\.//g' "$filename"
  sed -i 's/\\\\\\\\.//g' "$filename"
  sed -i 's/\\\\\\.//g' "$filename"
  sed -i 's/\\\\.//g' "$filename"
  sed -i 's/\\.//g' "$filename"

  # DEPRECATED: convert to csv
  # DEPRECATED: now performed in Python scripts
  # in2csv -f ndjson "$filename" -v > "$(basename "$filename" .json).csv"

done
