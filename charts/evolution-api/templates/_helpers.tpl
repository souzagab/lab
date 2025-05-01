{{/*
Expand the name of the chart.
*/}}
{{- define "evolution-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "evolution-api.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "evolution-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "evolution-api.labels" -}}
helm.sh/chart: {{ include "evolution-api.chart" . }}
{{ include "evolution-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "evolution-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "evolution-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "evolution-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "evolution-api.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{/*
Return the postgresql host
*/}}
{{- define "evolution-api.postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
    {{- if .Values.postgresql.fullnameOverride -}}
        {{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
    {{- else if .Values.postgresql.nameOverride -}}
        {{- printf "%s-postgresql" .Values.postgresql.nameOverride | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- printf "%s-postgresql" .Release.Name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{- required "Custom postgresql host required if postgresql.enabled is false" .Values.postgresql.externalHost -}}
{{- end -}}
{{- end -}}

{{/*
Return the postgresql port
*/}}
{{- define "evolution-api.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
    {{- printf "5432" -}}
{{- else -}}
    {{- required "Custom postgresql port required if postgresql.enabled is false" .Values.postgresql.externalPort -}}
{{- end -}}
{{- end -}}

{{/*
Return the postgresql secret name
*/}}
{{- define "evolution-api.postgresql.secretName" -}}
{{- if .Values.postgresql.auth.existingSecret -}}
    {{- printf "%s" .Values.postgresql.auth.existingSecret -}}
{{- else -}}
    {{- if .Values.postgresql.fullnameOverride -}}
        {{- printf "%s" .Values.postgresql.fullnameOverride -}}
    {{- else if .Values.postgresql.nameOverride -}}
        {{- printf "%s" .Values.postgresql.nameOverride -}}
    {{- else -}}
        {{- printf "%s-postgresql" .Release.Name -}}
    {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Return the postgresql secret key
*/}}
{{- define "evolution-api.postgresql.secretKey" -}}
{{- if .Values.postgresql.auth.existingSecret -}}
    {{- printf "%s" (default "postgresql-password" .Values.postgresql.auth.secretKeys.adminPasswordKey) -}}
{{- else -}}
    {{- printf "password" -}}
{{- end -}}
{{- end -}}

{{/*
Return the redis host
*/}}
{{- define "evolution-api.redis.host" -}}
{{- if .Values.redis.enabled -}}
    {{- if .Values.redis.fullnameOverride -}}
        {{- printf "%s-master" .Values.redis.fullnameOverride | trunc 63 | trimSuffix "-" -}}
    {{- else if .Values.redis.nameOverride -}}
        {{- printf "%s-redis-master" .Values.redis.nameOverride | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- printf "%s-redis-master" .Release.Name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{- required "Custom redis host required if redis.enabled is false" .Values.redis.externalHost -}}
{{- end -}}
{{- end -}}

{{/*
Return the redis port
*/}}
{{- define "evolution-api.redis.port" -}}
{{- if .Values.redis.enabled -}}
    {{- printf "6379" -}}
{{- else -}}
    {{- required "Custom redis port required if redis.enabled is false" .Values.redis.externalPort -}}
{{- end -}}
{{- end -}} 