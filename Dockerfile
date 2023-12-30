FROM alpine/helm
RUN apk add --no-cache --upgrade bash
RUN apk add jq
COPY build.sh .

ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/

ENV INSTRUCTION update
ENV BASE_PATH ""
#either it will be chart url or a directory location
ENV LOCAL_CHART_REF ""
ENV PUBLIC_CHART_REPO ""
ENV PUBLIC_CHART_NAME ""
ENV VALUE_YAML values.yaml
ENV RELEASE_NAME ""
ENV NAMESPACE default
ENV SLEEP_DURATION 5s
ENV ACTIVITY_SUB_TASK_CODE HELM
ENV VALIDATION_FAILURE_ACTION WARNING

ENTRYPOINT [ "./build.sh" ]