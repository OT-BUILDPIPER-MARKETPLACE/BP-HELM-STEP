#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/str-functions.sh
source /opt/buildpiper/shell-functions/file-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh

TASK_STATUS=0

function generateValuesStr() {
  local string="$1"
  local delimiter="$2"
  local valuesStr=""
  # echo "String: [$string]"
  # echo "Delimeter: [$delimiter]"
  if [ -n "$string" ]; then
      local part
      # echo $part
      while read -d "$delimiter" part; do
          valuesStr="-f $part $valuesStr"
      done <<< "$string"
      valuesStr="-f $part $valuesStr"
  fi
  echo $valuesStr
}

HELM_CODE_LOCATION="${WORKSPACE}"/"${CODEBASE_DIR}/${BASE_PATH}"
logInfoMessage "I'll do helm processing at [$HELM_CODE_LOCATION]"
sleep $SLEEP_DURATION
cd  "${HELM_CODE_LOCATION}"

TASK_STATUS=0

case ${INSTRUCTION} in
  update)
    cd ${CHART_YAML_DIR}
    helm dependency update
    ;;
  install)
    valuesStr=`generateValuesStr ${VALUE_YAML} !!`
    logInfoMessage "Running command [helm upgrade --install ${valuesStr} ${RELEASE_NAME} ${CHART_YAML_DIR} -n ${NAMESPACE}]"
    helm upgrade --install ${valuesStr} ${RELEASE_NAME} ${CHART_YAML_DIR} -n ${NAMESPACE}
    ;;
  *)
    logWarningMessage "Please check incompatible scanner passed!!!"
    generateOutput ${ACTIVITY_SUB_TASK_CODE} true "Please check incompatible scanner passed!!!"
    ;;
esac

saveTaskStatus ${TASK_STATUS} ${ACTIVITY_SUB_TASK_CODE}
