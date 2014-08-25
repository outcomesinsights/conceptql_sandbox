# OMOP HOI: GI Ulcer Hospitalization 2 (5000001002)
# - Occurrence of GI Ulcer diagnostic code
# - Hospitalization at time of diagnostic code
# - At least one diagnostic procedure during same hospitalization
# We use the fact that conditions, observations, and procedures all can be tied to a
# visit_occurrence to find situations where the appropriate conditions, diagnostic procedures, and
# place of service all occur in the same visit_occurrence

{
  union: [
    { place_of_service_code: '21' },
    { visit_occurrence: { icd9: %w(410.0 410.00 410.01 410.02 410.1 410.10 410.11 410.12 410.2 410.20 410.21 410.22 410.3 410.30 410.31 410.32 410.4 410.40 410.41 410.42 410.5 410.50 410.51 410.52 410.6 410.60 410.61 410.62 410.7 410.70 410.71 410.72 410.8 410.80 410.81 410.82 410.9 410.90 410.91 410.92) } },
    {
      visit_occurrence: {
        union: [
          { cpt: [ '0008T', '3142F', '43205', '43236', '76975', '91110', '91111' ] },
          { hcpcs: [ 'B4081', 'B4082' ] },
          { icd9_procedure: [ '42.22', '42.23', '44.13', '45.13', '52.21', '97.01' ] },
          { loinc: [ '16125-7', '17780-8', '40820-3', '50320-1', '5177-1', '7901-2' ] }
        ]
      }
    }
  ]
}
