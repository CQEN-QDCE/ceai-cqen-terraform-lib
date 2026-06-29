#!/bin/bash

# Paramètres de la commande.
# Compatibilité:
# - avec profil:    script.sh <aws_profile> <config_rule_name>
# - sans profil CI: script.sh <config_rule_name>
AWS_PROFILE_ARG="${1:-}"
CONFIG_RULE_NAME="${2:-ASEA-LZA-ELB_LOGGING_ENABLED}"

if [ -z "${2:-}" ] && [ -n "${1:-}" ]; then
    AWS_PROFILE_ARG=""
    CONFIG_RULE_NAME="${1}"
fi

ARGS+=( --config-rule-names "${CONFIG_RULE_NAME}" )

ARGS+=( --query 'ConfigRules[0].InputParameters' )

if [ "${AWS_PROFILE_ARG}" ]; then
    ARGS+=( --profile "${AWS_PROFILE_ARG}" )
fi

#Execution
VALUE=$(aws configservice describe-config-rules "${ARGS[@]}")

EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; 
then
    printf "Erreur à la récupération du bucket S3 où déposer les logs ELB. Voir Message précédent ^.  \n" >&2
else
    #Utilisation de eval pour interprété la valeur "escapé"
    eval printf "%s" "${VALUE}"
    printf "\n"
fi

exit $EXIT_CODE
