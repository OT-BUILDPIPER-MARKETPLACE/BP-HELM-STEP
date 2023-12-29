#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/str-functions.sh
source /opt/buildpiper/shell-functions/file-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh

TASK_STATUS=0

HELM_CODE_LOCATION="${WORKSPACE}"/"${CODEBASE_DIR}/${BASE_PATH}"
logInfoMessage "I'll do helm processing at [$HELM_CODE_LOCATION]"
sleep $SLEEP_DURATION
cd  "${HELM_CODE_LOCATION}"

TASK_STATUS=0

case ${INSTRUCTION} in
  update)
    helm dependency update
    ;;
  install)
    helm upgrade --install -f ${VALUE_YAML} ${RELEASE_NAME} ${CHART_YAML_DIR} -n ${NAMESPACE}
    ;;
  *)
    logWarningMessage "Please check incompatible scanner passed!!!"
    generateOutput ${ACTIVITY_SUB_TASK_CODE} true "Please check incompatible scanner passed!!!"
    ;;
esac

saveTaskStatus ${TASK_STATUS} ${ACTIVITY_SUB_TASK_CODE}