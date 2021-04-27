#!/bin/bash
dependency_file="${INPUT_DEPENDENCY_FILE##*/}"
dependency_path="${INPUT_DEPENDENCY_FILE%/*}"
if [ "${dependency_path}" = "${dependency_file}" ]; then
  dependency_path="${GITHUB_WORKSPACE}"
fi

function run_mkdocs(){
  if [ "${dependency_file}" = "poetry.lock" ]; then
    cmd="pipx run poetry run mkdocs"
  else
    cmd="mkdocs"
  fi
  if [ "${INPUT_VERBOSE}" = true ] ; then
    $cmd gh-deploy --force --verbose
  else
    $cmd gh-deploy --force
  fi
}

function main(){
  cd "${dependency_path}"
  if [ "${dependency_file}" = "requirements.txt" ]; then
    pip install -r "${dependency_file}"
  elif [ "${dependency_file}" = "poetry.lock" ]; then
    pipx run poetry install
  fi
  run_mkdocs
}

main