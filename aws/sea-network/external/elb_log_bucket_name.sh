#!/bin/bash

# Paramètres de la commande
ARGS+=( --config-rule-names ASEA-ELB_LOGGING_ENABLED )

ARGS+=( --query 'ConfigRules[0].InputParameters' )

if [ "${1}" ]; then
    ARGS+=( --profile "${1}" )
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
