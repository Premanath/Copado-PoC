{
    "dataPackId": "",
    "dataPacks": [
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [],\n    \"dataSource\": {\n        \"contextVariables\": [\n            {\n                \"name\": \"params.id\",\n                \"val\": \"0015000001AubTV\"\n            }\n        ],\n        \"type\": \"Query\",\n        \"value\": {\n            \"query\": \"SELECT Id, Name, Description, Phone, PhotoUrl, Type, BillingAddress, ShippingAddress, Website, %vlocity_namespace%__CustomerValue__c FROM Account WHERE Id = '{{params.id}}'\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"mobile-highlight-card\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "mobile-account-highlight",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-account-highlight/%vlocity_namespace%__VlocityUILayout__c/mobile-account-highlight"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-account-highlight",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-account-highlight",
            "VlocityDataPackName": "mobile-account-highlight",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [\n        \"Mobile Actions\"\n    ],\n    \"dataSource\": {\n        \"type\": \"Custom\",\n        \"value\": {\n            \"body\": \"{\\\"result\\\":[]}\",\n            \"resultVar\": \"result\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"card-canvas-1x-simple-slds\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "mobile-action-grid",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-action-grid/%vlocity_namespace%__VlocityUILayout__c/mobile-action-grid"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid",
            "VlocityDataPackName": "mobile-action-grid",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [\n        \"Mobile Actions\"\n    ],\n    \"dataSource\": {\n        \"type\": \"Custom\",\n        \"value\": {\n            \"body\": \"{\\\"result\\\":[]}\",\n            \"resultVar\": \"result\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"card-canvas-1x-simple-slds\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "mobile-action-grid-account",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-action-grid-account/%vlocity_namespace%__VlocityUILayout__c/mobile-action-grid-account"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid-account",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid-account",
            "VlocityDataPackName": "mobile-action-grid-account",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [\n        \"Mobile Actions\"\n    ],\n    \"dataSource\": {\n        \"type\": \"Custom\",\n        \"value\": {\n            \"body\": \"{\\\"result\\\":[]}\",\n            \"resultVar\": \"result\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"card-canvas-1x-simple-slds\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "mobile-action-grid-contact",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-action-grid-contact/%vlocity_namespace%__VlocityUILayout__c/mobile-action-grid-contact"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid-contact",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid-contact",
            "VlocityDataPackName": "mobile-action-grid-contact",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [\n        \"Mobile Actions\"\n    ],\n    \"dataSource\": {\n        \"type\": \"Custom\",\n        \"value\": {\n            \"body\": \"{\\\"result\\\":[]}\",\n            \"resultVar\": \"result\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"card-canvas-1x-simple-slds\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "mobile-action-grid-home",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-action-grid-home/%vlocity_namespace%__VlocityUILayout__c/mobile-action-grid-home"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid-home",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid-home",
            "VlocityDataPackName": "mobile-action-grid-home",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [\n        \"Mobile Actions\"\n    ],\n    \"dataSource\": {\n        \"type\": \"Custom\",\n        \"value\": {\n            \"body\": \"{\\\"result\\\":[]}\",\n            \"resultVar\": \"result\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"card-canvas-1x-simple-slds\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "mobile-action-grid-lead",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-action-grid-lead/%vlocity_namespace%__VlocityUILayout__c/mobile-action-grid-lead"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid-lead",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-action-grid-lead",
            "VlocityDataPackName": "mobile-action-grid-lead",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [],\n    \"dataSource\": {\n        \"contextVariables\": [\n            {\n                \"name\": \"params.id\",\n                \"val\": \"0035000002hUcp4\"\n            }\n        ],\n        \"type\": \"Query\",\n        \"value\": {\n            \"query\": \"SELECT Id, Name, Title, MobilePhone, Email, PhotoUrl,  MailingAddress, OtherAddress, Account.Name, %vlocity_namespace%__CustomerSentiment__c FROM CONTACT WHERE Id = '{{params.id}}'\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"mobile-highlight-card\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "mobile-contact-highlight",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-contact-highlight/%vlocity_namespace%__VlocityUILayout__c/mobile-contact-highlight"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-contact-highlight",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-contact-highlight",
            "VlocityDataPackName": "mobile-contact-highlight",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [\n        \"Event Story\",\n        \"Task Story\"\n    ],\n    \"dataSource\": {\n        \"contextVariables\": [],\n        \"type\": \"Inherit\",\n        \"value\": {\n            \"resultVar\": \"Stories\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"mobile-home-screen-story-card-canvas\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 2,
                        "Name": "mobile-home-list",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-home-list/%vlocity_namespace%__VlocityUILayout__c/mobile-home-list"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-home-list",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-home-list",
            "VlocityDataPackName": "mobile-home-list",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [],\n    \"dataSource\": {\n        \"contextVariables\": [\n            {\n                \"name\": \"params.id\",\n                \"val\": \"00Q50000016w0qf\"\n            }\n        ],\n        \"type\": \"Query\",\n        \"value\": {\n            \"query\": \"SELECT Id,Name,Company,Email,MobilePhone,Phone,PhotoUrl, Address,City,Country,PostalCode,State,Street ,Title,Website FROM Lead WHERE Id = '{{params.id}}'\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"mobile-highlight-card\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "mobile-lead-highlight",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-lead-highlight/%vlocity_namespace%__VlocityUILayout__c/mobile-lead-highlight"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-lead-highlight",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-lead-highlight",
            "VlocityDataPackName": "mobile-lead-highlight",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackAllRelationships": null,
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Definition__c": "{\n    \"Cards\": [\n        \"Policy Summary\",\n        \"Whole Life Mobile Policy\",\n        \"Term Life Mobile Policy\",\n        \"Permanent Life Mobile Policy\",\n        \"Variable Annuity Mobile Policy\"\n    ],\n    \"dataSource\": {\n        \"contextVariables\": [\n            {\n                \"name\": \"params.id\",\n                \"val\": \"0015000001CnG8I\"\n            }\n        ],\n        \"order\": [\n            \"+order\",\n            \"+obj.%vlocity_namespace%__aggregate_AnnualPremium__c\",\n            \"+obj.%vlocity_namespace%__PolicyStatus__c\"\n        ],\n        \"type\": \"Query\",\n        \"value\": {\n            \"query\": \"SELECT CreatedDate,%vlocity_namespace%__AccountId__c,%vlocity_namespace%__AccumulationValue__c,%vlocity_namespace%__AgencyCommission__c,%vlocity_namespace%__AnnualPremium__c,%vlocity_namespace%__ApplicationSubmitDate__c,%vlocity_namespace%__AutomaticRebalancing__c,%vlocity_namespace%__BenefitPlanId__c,%vlocity_namespace%__BillingMethod__c,%vlocity_namespace%__CashSurrenderValue__c,%vlocity_namespace%__CashValue__c,%vlocity_namespace%__ContractDeathBenefit__c,%vlocity_namespace%__ContractLivingBenefit__c,%vlocity_namespace%__CostBasis__c,%vlocity_namespace%__DaysToExpire__c,%vlocity_namespace%__DeathBenefit__c,%vlocity_namespace%__EffectiveDate__c,%vlocity_namespace%__EffectiveTerm__c,%vlocity_namespace%__ExpirationDate__c,%vlocity_namespace%__FaceAmount__c,%vlocity_namespace%__GuaranteedDeathBenefit__c,%vlocity_namespace%__GuaranteePeriod__c,%vlocity_namespace%__InceptionDate__c,%vlocity_namespace%__InitialDeposit__c,%vlocity_namespace%__InsurerId__c,%vlocity_namespace%__LineofBusiness__c,%vlocity_namespace%__LOBDeveloperName__c,%vlocity_namespace%__OpenClaimCount__c,%vlocity_namespace%__ParentPolicyId__c,%vlocity_namespace%__PolicyJurisdiction__c,%vlocity_namespace%__PolicyStatus__c,%vlocity_namespace%__PolicyType__c,%vlocity_namespace%__PrimaryBrokerId__c,%vlocity_namespace%__ProductId__c,%vlocity_namespace%__QualifiedType__c,%vlocity_namespace%__RatePlan__c,%vlocity_namespace%__RateState__c,%vlocity_namespace%__ReportGroup__c,%vlocity_namespace%__ReportInsurerId__c,%vlocity_namespace%__SourceOfFunds__c,%vlocity_namespace%__Term__c,%vlocity_namespace%__TotalPremiumForTerm__c,%vlocity_namespace%__UnitofFaceAmount__c,%vlocity_namespace%__ValuePerUnit__c,Id,LastActivityDate,LastModifiedById,LastModifiedDate,Name FROM %vlocity_namespace%__Policy__c WHERE %vlocity_namespace%__AccountId__c = '{{params.id}}'\"\n        }\n    },\n    \"templates\": {\n        \"0\": {\n            \"templateUrl\": \"card-canvas-1x-simple-slds\"\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "mobile-policy-summary",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/mobile-policy-summary/%vlocity_namespace%__VlocityUILayout__c/mobile-policy-summary"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/mobile-policy-summary",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/mobile-policy-summary",
            "VlocityDataPackName": "mobile-policy-summary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        }
    ],
    "name": "Vlocity Mobile Cards + Layouts",
    "primaryDataPackKey": "VlocityDeploy",
    "processMultiple": true,
    "status": "Complete",
    "version": 1
}