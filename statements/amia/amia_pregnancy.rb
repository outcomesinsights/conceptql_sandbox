#AMIA Example: Pregnancy
#Large list of ICD-9 codes from CCS Single Level #180-#186, #192.
{:let=>[{:define=>["CCS 180 Ectopic pregnancy", {:icd9=>["633.0", "633.00", "633.01", "633.1", "633.10", "633.11", "633.2", "633.20", "633.21", "633.8", "633.80", "633.81", "633.9", "633.90", "633.91"]}]}, {:define=>["CCS 181  Other complications of pregnancy", {:icd9=>["630", "631", "631.0", "631.8", "632", "643.00", "643.01", "643.03", "643.10", "643.11", "643.13", "643.20", "643.21", "643.23", "643.80", "643.81", "643.83", "643.90", "643.91", "643.93", "646.00", "646.01", "646.03", "646.10", "646.11", "646.12", "646.13", "646.14", "646.20", "646.21", "646.22", "646.23", "646.24", "646.30", "646.31", "646.33", "646.40", "646.41", "646.42", "646.43", "646.44", "646.50", "646.51", "646.52", "646.53", "646.54", "646.60", "646.61", "646.62", "646.63", "646.64", "646.70", "646.71", "646.73", "646.80", "646.81", "646.82", "646.83", "646.84", "646.90", "646.91", "646.93", "647.00", "647.01", "647.02", "647.03", "647.04", "647.10", "647.11", "647.12", "647.13", "647.14", "647.20", "647.21", "647.22", "647.23", "647.24", "647.30", "647.31", "647.32", "647.33", "647.34", "647.40", "647.41", "647.42", "647.43", "647.44", "647.50", "647.51", "647.52", "647.53", "647.54", "647.60", "647.61", "647.62", "647.63", "647.64", "647.80", "647.81", "647.82", "647.83", "647.84", "647.90", "647.91", "647.92", "647.93", "647.94", "648.10", "648.11", "648.12", "648.13", "648.14", "648.20", "648.21", "648.22", "648.23", "648.24", "648.50", "648.51", "648.52", "648.53", "648.54", "648.60", "648.61", "648.62", "648.63", "648.64", "648.70", "648.71", "648.72", "648.73", "648.74", "648.90", "648.91", "648.92", "648.93", "648.94", "649.00", "649.01", "649.02", "649.03", "649.04", "649.10", "649.11", "649.12", "649.13", "649.14", "649.20", "649.21", "649.22", "649.23", "649.24", "649.30", "649.31", "649.32", "649.33", "649.34", "649.40", "649.41", "649.42", "649.43", "649.44", "649.50", "649.51", "649.53", "649.60", "649.61", "649.62", "649.63", "649.64", "V23.42", "V23.87", "V27.1", "V27.2", "V27.3", "V27.4", "V27.5", "V27.6", "V27.7", "V27.9"]}]}, {:define=>["CCS 182  Hemorrhage during pregnancy; abruptio placenta; placenta previa", {:icd9=>["640.00", "640.01", "640.03", "640.80", "640.81", "640.83", "640.90", "640.91", "640.93", "641.00", "641.01", "641.03", "641.10", "641.11", "641.13", "641.20", "641.21", "641.23", "641.30", "641.31", "641.33", "641.80", "641.81", "641.83", "641.90", "641.91", "641.93"]}]}, {:define=>["CCS 183  Hypertension complicating pregnancy; childbirth and the puerperium", {:icd9=>["642.00", "642.01", "642.02", "642.03", "642.04", "642.10", "642.11", "642.12", "642.13", "642.14", "642.20", "642.21", "642.22", "642.23", "642.24", "642.30", "642.31", "642.32", "642.33", "642.34", "642.40", "642.41", "642.42", "642.43", "642.44", "642.50", "642.51", "642.52", "642.53", "642.54", "642.60", "642.61", "642.62", "642.63", "642.64", "642.70", "642.71", "642.72", "642.73", "642.74", "642.90", "642.91", "642.92", "642.93", "642.94"]}]}, {:define=>["CCS 184  Early or threatened labor", {:icd9=>["644.00", "644.03", "644.10", "644.13", "644.20", "644.21"]}]}, {:define=>["CCS 185  Prolonged pregnancy", {:icd9=>["645.00", "645.01", "645.03", "645.10", "645.11", "645.13", "645.20", "645.21", "645.23"]}]}, {:define=>["CCS 186  Diabetes or abnormal glucose tolerance complicating pregnancy; childbirth; or the puerperium", {:icd9=>["648.00", "648.01", "648.02", "648.03", "648.04", "648.80", "648.81", "648.82", "648.83", "648.84"]}]}, {:define=>["CCS 196 Normal pregnancy and/or delivery", {:icd9=>["650", "651.00", "651.01", "651.10", "651.11", "651.20", "651.21", "651.70", "651.71", "651.73", "651.80", "651.81", "651.90", "651.91", "V22.0", "V22.1", "V22.2", "V24.0", "V24.1", "V24.2", "V27.0", "V72.4", "V72.42", "V91.00", "V91.01", "V91.02", "V91.03", "V91.09", "V91.10", "V91.11", "V91.12", "V91.19", "V91.20", "V91.21", "V91.22", "V91.29", "V91.90", "V91.91", "V91.92", "V91.99"]}]}, {:union=>[{:recall=>"CCS 180 Ectopic pregnancy"}, {:recall=>"CCS 181  Other complications of pregnancy"}, {:recall=>"CCS 182  Hemorrhage during pregnancy; abruptio placenta; placenta previa"}, {:recall=>"CCS 183  Hypertension complicating pregnancy; childbirth and the puerperium"}, {:recall=>"CCS 184  Early or threatened labor"}, {:recall=>"CCS 185  Prolonged pregnancy"}, {:recall=>"CCS 186  Diabetes or abnormal glucose tolerance complicating pregnancy; childbirth; or the puerperium"}, {:recall=>"CCS 196 Normal pregnancy and/or delivery"}]}]}
