WITH facebook_data AS (
SELECT 
pf.ad_date, pfc.campaign_name, pfa.adset_name, spend, impressions, reach, clicks, leads, value,
'facebook_ads ' AS media_source
FROM public.facebook_ads_basic_daily AS pf
LEFT JOIN public.facebook_adset AS pfa 
ON pfa.adset_id = pf.adset_id 
LEFT JOIN public.facebook_campaign AS pfc
ON pfc.campaign_id = pf.campaign_id 
),

facebook_google  AS ( 
SELECT * 
FROM facebook_data AS fd

UNION ALL 
SELECT 
ad_date, campaign_name, adset_name, spend, impressions, reach, clicks, leads, value,
'google_ads' AS media_source
FROM public.google_ads_basic_daily AS pg
)

SELECT  
ad_date,
media_source,
campaign_name,
adset_name,
sum(impressions) AS total_impressions,
sum(spend) AS total_spend,
sum(clicks) AS total_clicks,
sum(value) AS total_value
FROM facebook_google 
WHERE spend > 0
GROUP BY 1, 2, 3, 4


