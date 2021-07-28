#!/bin/bash
#
# Environment configuration for mongodb

# The values for all environment variables will be set in the below order of precedence
# 1. Custom environment variables defined below after Bitnami defaults
# 2. Constants defined in this file (environment variables with no default), i.e. BITNAMI_ROOT_DIR
# 3. Environment variables overridden via external files using *_FILE variables (see below)
# 4. Environment variables set externally (i.e. current Bash context/Dockerfile/userdata)

# Load logging library
. /opt/bitnami/scripts/liblog.sh

export BITNAMI_ROOT_DIR="/opt/bitnami"
export BITNAMI_VOLUME_DIR="/bitnami"

# Logging configuration
export MODULE="${MODULE:-mongodb}"
export BITNAMI_DEBUG="${BITNAMI_DEBUG:-true}"

#numactl configuration
export MONGODB_ENABLE_NUMACTL="${MONGODB_ENABLE_NUMACTL:-false}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
mongodb_env_vars=(
    MONGODB_MOUNTED_CONF_DIR
    MONGODB_MAX_TIMEOUT
    MONGODB_PORT_NUMBER
    MONGODB_ENABLE_MAJORITY_READ
    MONGODB_DEFAULT_ENABLE_MAJORITY_READ
    MONGODB_EXTRA_FLAGS
    MONGODB_CLIENT_EXTRA_FLAGS
    MONGODB_ADVERTISED_HOSTNAME
    MONGODB_DISABLE_JAVASCRIPT
    MONGODB_ENABLE_JOURNAL
    MONGODB_DISABLE_SYSTEM_LOG
    MONGODB_ENABLE_DIRECTORY_PER_DB
    MONGODB_ENABLE_IPV6
    MONGODB_SYSTEM_LOG_VERBOSITY
    MONGODB_ROOT_PASSWORD
    MONGODB_USERNAME
    MONGODB_PASSWORD
    MONGODB_DATABASE
    ALLOW_EMPTY_PASSWORD
    MONGODB_REPLICA_SET_MODE
    MONGODB_REPLICA_SET_NAME
    MONGODB_REPLICA_SET_KEY
    MONGODB_INITIAL_PRIMARY_HOST
    MONGODB_INITIAL_PRIMARY_PORT_NUMBER
    MONGODB_INITIAL_PRIMARY_ROOT_PASSWORD
    MONGODB_INITIAL_PRIMARY_ROOT_USER
    MONGODB_SHARDING_MODE
    MONGODB_CFG_REPLICA_SET_NAME
    MONGODB_CFG_PRIMARY_HOST
    MONGODB_CFG_PRIMARY_PORT_NUMBER
    MONGODB_MONGOS_HOST
    MONGODB_MONGOS_PORT_NUMBER
    MONGODB_PRIMARY_HOST
    MONGODB_PRIMARY_PORT_NUMBER
    MONGODB_PRIMARY_ROOT_PASSWORD
    MONGODB_PRIMARY_ROOT_USER
)
for env_var in "${mongodb_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset mongodb_env_vars

# Paths
export PATH="/opt/bitnami/mongodb/bin:/opt/bitnami/common/bin:$PATH"
export MONGODB_VOLUME_DIR="/bitnami"
export MONGODB_BASE_DIR="/opt/bitnami/mongodb"
export MONGODB_CONF_DIR="$MONGODB_BASE_DIR/conf"
export MONGODB_LOG_DIR="$MONGODB_BASE_DIR/logs"
export MONGODB_DATA_DIR="${MONGODB_VOLUME_DIR}/mongodb/data"
export MONGODB_TMP_DIR="$MONGODB_BASE_DIR/tmp"
export MONGODB_BIN_DIR="$MONGODB_BASE_DIR/bin"
export MONGODB_TEMPLATES_DIR="$MONGODB_BASE_DIR/templates"
export MONGODB_MONGOD_TEMPLATES_FILE="$MONGODB_TEMPLATES_DIR/mongodb.conf.tpl"
export MONGODB_CONF_FILE="$MONGODB_CONF_DIR/mongodb.conf"
export MONGODB_KEY_FILE="$MONGODB_CONF_DIR/keyfile"
export MONGODB_DB_SHELL_FILE="/.dbshell"
export MONGODB_RC_FILE="/.mongorc.js"
export MONGODB_PID_FILE="$MONGODB_TMP_DIR/mongodb.pid"
export MONGODB_LOG_FILE="$MONGODB_LOG_DIR/mongodb.log"
export MONGODB_INITSCRIPTS_DIR="/docker-entrypoint-initdb.d"

# System users (when running with a privileged user)
export MONGODB_DAEMON_USER="mongo"
export MONGODB_DAEMON_GROUP="mongo"

# MongoDB configuration
export MONGODB_MOUNTED_CONF_DIR="${MONGODB_MOUNTED_CONF_DIR:-${MONGODB_VOLUME_DIR}/conf}"
export MONGODB_MAX_TIMEOUT="${MONGODB_MAX_TIMEOUT:-35}"
export MONGODB_DEFAULT_PORT_NUMBER="27017"
export MONGODB_PORT_NUMBER="${MONGODB_PORT_NUMBER:-$MONGODB_DEFAULT_PORT_NUMBER}"
export MONGODB_ENABLE_MAJORITY_READ="${MONGODB_ENABLE_MAJORITY_READ:-true}"
export MONGODB_DEFAULT_ENABLE_MAJORITY_READ="${MONGODB_DEFAULT_ENABLE_MAJORITY_READ:-true}"
export MONGODB_EXTRA_FLAGS="${MONGODB_EXTRA_FLAGS:-}"
export MONGODB_CLIENT_EXTRA_FLAGS="${MONGODB_CLIENT_EXTRA_FLAGS:-}"
export MONGODB_ADVERTISED_HOSTNAME="${MONGODB_ADVERTISED_HOSTNAME:-}"
export MONGODB_DISABLE_JAVASCRIPT="${MONGODB_DISABLE_JAVASCRIPT:-no}"
export MONGODB_ENABLE_JOURNAL="${MONGODB_ENABLE_JOURNAL:-}"
export MONGODB_DEFAULT_ENABLE_JOURNAL="true"
export MONGODB_DISABLE_SYSTEM_LOG="${MONGODB_DISABLE_SYSTEM_LOG:-}"
export MONGODB_DEFAULT_DISABLE_SYSTEM_LOG="false"
export MONGODB_ENABLE_DIRECTORY_PER_DB="${MONGODB_ENABLE_DIRECTORY_PER_DB:-}"
export MONGODB_DEFAULT_ENABLE_DIRECTORY_PER_DB="false"
export MONGODB_ENABLE_IPV6="${MONGODB_ENABLE_IPV6:-}"
export MONGODB_DEFAULT_ENABLE_IPV6="false"
export MONGODB_SYSTEM_LOG_VERBOSITY="${MONGODB_SYSTEM_LOG_VERBOSITY:-}"
export MONGODB_DEFAULT_SYSTEM_LOG_VERBOSITY="0"

# User and database creation settings
export MONGODB_ROOT_PASSWORD="${MONGODB_ROOT_PASSWORD:-}"
export MONGODB_USERNAME="${MONGODB_USERNAME:-}"
export MONGODB_PASSWORD="${MONGODB_PASSWORD:-}"
export MONGODB_DATABASE="${MONGODB_DATABASE:-}"
export ALLOW_EMPTY_PASSWORD="${ALLOW_EMPTY_PASSWORD:-no}"

# MongoDB replica set configuration
export MONGODB_REPLICA_SET_MODE="${MONGODB_REPLICA_SET_MODE:-}"
export MONGODB_DEFAULT_REPLICA_SET_NAME="replicaset"
export MONGODB_REPLICA_SET_NAME="${MONGODB_REPLICA_SET_NAME:-$MONGODB_DEFAULT_REPLICA_SET_NAME}"
export MONGODB_REPLICA_SET_KEY="${MONGODB_REPLICA_SET_KEY:-}"
MONGODB_INITIAL_PRIMARY_HOST="${MONGODB_INITIAL_PRIMARY_HOST:-"${MONGODB_PRIMARY_HOST:-}"}"
export MONGODB_INITIAL_PRIMARY_HOST="${MONGODB_INITIAL_PRIMARY_HOST:-}"
MONGODB_INITIAL_PRIMARY_PORT_NUMBER="${MONGODB_INITIAL_PRIMARY_PORT_NUMBER:-"${MONGODB_PRIMARY_PORT_NUMBER:-}"}"
export MONGODB_INITIAL_PRIMARY_PORT_NUMBER="${MONGODB_INITIAL_PRIMARY_PORT_NUMBER:-27017}"
MONGODB_INITIAL_PRIMARY_ROOT_PASSWORD="${MONGODB_INITIAL_PRIMARY_ROOT_PASSWORD:-"${MONGODB_PRIMARY_ROOT_PASSWORD:-}"}"
export MONGODB_INITIAL_PRIMARY_ROOT_PASSWORD="${MONGODB_INITIAL_PRIMARY_ROOT_PASSWORD:-}"
MONGODB_INITIAL_PRIMARY_ROOT_USER="${MONGODB_INITIAL_PRIMARY_ROOT_USER:-"${MONGODB_PRIMARY_ROOT_USER:-}"}"
export MONGODB_INITIAL_PRIMARY_ROOT_USER="${MONGODB_INITIAL_PRIMARY_ROOT_USER:-root}"

# Sharding settings
export MONGODB_MONGOS_TEMPLATES_FILE="$MONGODB_TEMPLATES_DIR/mongos.conf.tpl"
export MONGODB_SHARDING_MODE="${MONGODB_SHARDING_MODE:-}"
export MONGODB_MONGOS_CONF_FILE="$MONGODB_CONF_DIR/mongos.conf"
export MONGODB_CFG_REPLICA_SET_NAME="${MONGODB_CFG_REPLICA_SET_NAME:-}"
export MONGODB_CFG_PRIMARY_HOST="${MONGODB_CFG_PRIMARY_HOST:-}"
export MONGODB_CFG_PRIMARY_PORT_NUMBER="${MONGODB_CFG_PRIMARY_PORT_NUMBER:-27017}"
export MONGODB_MONGOS_HOST="${MONGODB_MONGOS_HOST:-}"
export MONGODB_MONGOS_PORT_NUMBER="${MONGODB_MONGOS_PORT_NUMBER:-27017}"

# Custom environment variables may be defined below
