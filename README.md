# Dbeaver
SELECT 
ad_date,  
campaign_id, 
SUM(spend)::numeric AS sum_spend,
SUM(impressions)::numeric AS sum_impressions,
SUM(clicks)::numeric AS sum_clicks,
SUM(value)::numeric AS sum_value,
SUM(spend)::numeric / NULLIF(SUM(clicks)::numeric, 0) AS CPC,
SUM(spend)::numeric / NULLIF(SUM(impressions)::numeric, 0) AS CPM,
SUM(clicks)::numeric / NULLIF(SUM(impressions)::numeric, 0) AS CTR,
SUM(value)::numeric / NULLIF(SUM(spend)::numeric, 0) AS ROMI
FROM public.facebook_ads_basic_daily
GROUP BY 1, 2
HAVING SUM(impressions) > 0 
AND SUM(clicks) > 0 
AND SUM(spend) > 0
AND SUM(spend) > 500000
