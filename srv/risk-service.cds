
using {riskmanagement_schema as rm_schema} from '../db/schema';

@path: 'service/risk'
service RiskService @(requires: 'authenticated-user') {
    entity Risks @(restrict: [
        {
            grant: 'READ',
            to   : 'RiskViewer'
        },
        {
            grant: [
                'READ',
                'WRITE',
                'UPDATE',
                'UPSERT',
                'DELETE'
            ], // Allowing CDS events by explicitly mentioning them
            to   : 'RiskManager'
        }
    ])                      as projection on rm_schema.Risks;

    annotate Risks with @odata.draft.enabled;

    entity Mitigations @(restrict: [
        {
            grant: 'READ',
            to   : 'RiskViewer'
        },
        {
            grant: '*', // Allow everything using wildcard
            to   : 'RiskManager'
        }
    ])                      as projection on rm_schema.Mitigations;

    annotate Mitigations with @odata.draft.enabled;

    // BusinessPartner
    @readonly
    entity BusinessPartners as projection on rm_schema.BusinessPartners;
}
