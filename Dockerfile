FROM alpine/helm
RUN apk add --no-cache --upgrade bash
RUN apk add jq
COPY build.sh .

ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/

# update,install, install_public
ENV INSTRUCTION install

ENV BASE_PATH ""
# For chart hosted on local dir
ENV CHART_YAML_DIR "."
ENV CHART_VERSION ""

#For publically available chart
ENV PUBLIC_CHART_REPO_NAME ""
ENV PUBLIC_CHART_REPO_URL ""
ENV PUBLIC_CHART ""

ENV VALUE_YAML values.yaml
ENV RELEASE_NAME ""
ENV NAMESPACE default

ENV SLEEP_DURATION 5s
ENV ACTIVITY_SUB_TASK_CODE HELM
ENV VALIDATION_FAILURE_ACTION WARNING

ENTRYPOINT [ "./build.sh" ]