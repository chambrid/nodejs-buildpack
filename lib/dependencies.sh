install_node_modules() {
  local build_dir=${1:-}

  if [ -e $build_dir/package.json ]; then
    cd $build_dir
	local cloudbot_url="https://github.com/ibm-cloud-solutions/cloudbot/archive/master.zip"
	curl "$cloudbot_url" --silent --fail --retry 5 --retry-max-time 15 -o /tmp/cloudbot.zip
	echo "Downloaded [$cloudbot_url]"
	unzip /tmp/cloudbot.zip -o -d build_dir

    npm install --unsafe-perm --userconfig $build_dir/.npmrc 2>&1
  else
    echo "Skipping (no package.json)"
  fi
}

rebuild_node_modules() {
  local build_dir=${1:-}

  if [ -e $build_dir/package.json ]; then
    cd $build_dir
    echo "Rebuilding any native modules"
    npm rebuild --nodedir=$build_dir/.heroku/node 2>&1
	local cloudbot_url="https://github.com/ibm-cloud-solutions/cloudbot/archive/master.zip"
	curl "$cloudbot_url" --silent --fail --retry 5 --retry-max-time 15 -o /tmp/cloudbot.zip
	echo "Downloaded [$cloudbot_url]"
	unzip /tmp/cloudbot.zip -o -d build_dir
    npm install --unsafe-perm --userconfig $build_dir/.npmrc 2>&1
  else
    echo "Skipping (no package.json)"
  fi
}
