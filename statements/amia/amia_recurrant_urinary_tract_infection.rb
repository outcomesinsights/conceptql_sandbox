#AMIA Example: Recurrant UTI
#By using the 'after' temporal comparison node, we find all UTIs that occur 90 days after a previous UTI, implying 'recurrant' UTIs
{:let=>[{:define=>["UTI", {:icd9=>["032.84", "590.00", "590.01", "590.10", "590.11", "590.2", "590.3", "590.80", "590.81", "590.9", "595.0", "595.1", "595.2", "595.3", "595.4", "595.81", "595.82", "595.89", "595.9", "597.0", "597.80", "597.81", "597.89", "598.00", "598.01", "599.0"]}]}, {:after=>{:left=>{:recall=>"UTI"}, :right=>{:first=>{:time_window=>[{:recall=>"UTI"}, {:start=>"90d", :end=>"90d"}]}}}}]}
