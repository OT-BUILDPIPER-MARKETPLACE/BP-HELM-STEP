FROM alpine/helm
RUN apk add --no-cache --upgrade bash
RUN apk add jq
COPY build.sh .

ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/

ENV INSTRUCTION update
ENV BASE_PATH ""
ENV CHART_YAML Chart.yaml
ENV VALUE_YAML values.yaml
ENV SOFTWARE ""
ENV SLEEP_DURATION 5s
ENV ACTIVITY_SUB_TASK_CODE HELM
ENV VALIDATION_FAILURE_ACTION WARNING

ENTRYPOINT [ "./build.sh" ]