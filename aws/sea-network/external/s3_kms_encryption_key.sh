#!/bin/bash

# Paramètres de la commande
ARGS+=( --config-rule-names ASEA-S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED )

ARGS+=( --query 'RemediationConfigurations[0].Parameters.KMSMasterKey.StaticValue.Values[0]' )

if [ "${1}" ]; then
    ARGS+=( --profile "${1}" )
fi

#Execution
VALUE=$(aws configservice describe-remediation-configurations "${ARGS[@]}")

EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; 
then
    printf "Erreur à la récupération de la clé KMS SEA pour bucket S3. Voir Message précédent ^.  \n" >&2
else
    printf "{\"arn\":%s}\n" "${VALUE}"
fi

exit $EXIT_CODE
