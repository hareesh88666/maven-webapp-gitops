{{/*
Expand the name of the chart.
*/}}
{{- define "maven-webapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a fully qualified app name.
We override default Helm behavior so that
Release.Name is NOT used in resource names.
This is required for Blue-Green deployments.
*/}}
{{- define "maven-webapp.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "maven-webapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "maven-webapp.labels" -}}
helm.sh/chart: {{ include "maven-webapp.chart" . }}
{{ include "maven-webapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "maven-webapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "maven-webapp.name" . }}
app.kubernetes.io/instance: {{ include "maven-webapp.fullname" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "maven-webapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "maven-webapp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

