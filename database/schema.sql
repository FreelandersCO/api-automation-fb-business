--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: active_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.active_status AS ENUM (
    'Y',
    'N'
);


--
-- Name: task_period; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.task_period AS ENUM (
    'last_7d',
    'last_14d',
    'last_28d',
    'last_30d',
    'last_3d',
    'last_90d',
    'last_month',
    'last_quarter',
    'last_week_mon_sun',
    'last_week_sun_sat',
    'last_year',
    'this_month',
    'this_quarter',
    'this_week_mon_today',
    'this_week_sun_today',
    'this_year',
    'today',
    'yesterday',
    'lifetime'
);


--
-- Name: task_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.task_status AS ENUM (
    'P',
    'R',
    'F'
);


--
-- Name: account_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.account_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.account (
    id integer DEFAULT nextval('public.account_seq'::regclass) NOT NULL,
    account_id text NOT NULL,
    account_status text NOT NULL,
    age text NOT NULL,
    amount_spent text NOT NULL,
    fb_id text NOT NULL,
    name text NOT NULL,
    active public.active_status
);


--
-- Name: ad_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ad (
    id integer DEFAULT nextval('public.ad_seq'::regclass) NOT NULL,
    account_id text,
    ad_id text,
    ad_name text,
    adset_id text,
    read public.active_status,
    created_time text,
    date_consult timestamp(6) with time zone DEFAULT now(),
    id_platform integer
);


--
-- Name: adset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adset (
    account_id text,
    adlabels text,
    id text NOT NULL,
    adset_schedule json,
    asset_feed_id text,
    attribution_spec json,
    best_creative text,
    bid_adjustments text,
    bid_amount text,
    bid_constraints text,
    bid_info json,
    billing_event text,
    budget_remaining text,
    campaign_id text,
    campaign_spec text,
    configured_status text,
    created_time text,
    creative_sequence text,
    daily_budget text,
    daily_min_spend_target text,
    daily_spend_cap text,
    date_format text,
    destination_type text,
    effective_status text,
    end_time text,
    execution_options text,
    frequency_control_specs json,
    instagram_actor_id text,
    is_dynamic_creative text,
    issues_info text,
    lifetime_budget text,
    lifetime_imps text,
    lifetime_min_spend_target text,
    lifetime_spend_cap text,
    name text,
    optimization_goal text,
    optimization_sub_event text,
    pacing_type json,
    promoted_object json,
    rb_prediction_id text,
    recommendations json,
    recurring_budget_semantics text,
    review_feedback text,
    rf_prediction_id text,
    source_adset json,
    source_adset_id text,
    start_time text,
    status text,
    targeting json,
    time_based_ad_rotation_id_blocks text,
    time_based_ad_rotation_intervals text,
    time_start text,
    time_stop text,
    updated_time text,
    upstream_events text,
    use_new_app_click text,
    date_consult timestamp without time zone DEFAULT now(),
    id_platform integer
);


--
-- Name: adset_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.adset_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: breakdown_configuration_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.breakdown_configuration_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: breakdown_configuration; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.breakdown_configuration (
    id_breakdown_configuration integer DEFAULT nextval('public.breakdown_configuration_seq'::regclass) NOT NULL,
    name text NOT NULL,
    active public.active_status,
    date_created timestamp(6) without time zone DEFAULT now()
);


--
-- Name: campaing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campaing (
    id text NOT NULL,
    id_platform integer,
    account_id text,
    adbatch text,
    adlabels text,
    bid_strategy text,
    boosted_object_id text,
    brand_lift_studies text,
    budget_rebalance_flag text,
    budget_remaining text,
    buying_type text,
    can_create_brand_lift_study text,
    can_use_spend_cap text,
    configured_status text,
    created_time text,
    daily_budget text,
    effective_status text,
    execution_options text,
    fb_id text,
    issues_info text,
    iterative_split_test_configs text,
    last_budget_toggling_time text,
    lifetime_budget text,
    name text,
    objective text,
    promoted_object text,
    recommendations json,
    spend_cap text,
    start_time text,
    status text,
    stop_time text,
    topline_id text,
    updated_time text,
    upstream_events text,
    pacing_type text,
    source_campaign_id text,
    source_campaign text[],
    date_consult timestamp without time zone DEFAULT now()
);


--
-- Name: campaing_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campaing_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: creative_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.creative_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: creative; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creative (
    id integer DEFAULT nextval('public.creative_seq'::regclass) NOT NULL,
    ad_id text,
    account_id text,
    actor_id text,
    adlabels text,
    applink_treatment text,
    asset_feed_spec text,
    authorization_category text,
    auto_update text,
    body text,
    branded_content_sponsor_page_id text,
    bundle_folder_id text,
    call_to_action_type text,
    categorization_criteria text,
    category_media_source text,
    destination_set_id text,
    dynamic_ad_voice text,
    effective_authorization_category text,
    effective_instagram_story_id text,
    effective_object_story_id text,
    enable_direct_install text,
    enable_launch_instant_app text,
    creative_id text,
    image_crops text,
    image_hash text,
    image_url text,
    instagram_actor_id text,
    instagram_permalink_url text,
    instagram_story_id text,
    interactive_components_spec text,
    link_deep_link_url text,
    link_og_id text,
    link_url text,
    messenger_sponsored_message text,
    name text,
    object_id text,
    object_store_url text,
    object_story_id text,
    object_story_spec text,
    object_type text,
    object_url text,
    place_page_set_id text,
    platform_customizations text,
    playable_asset_id text,
    portrait_customizations text,
    product_set_id text,
    recommender_settings text,
    status text,
    template_url text,
    template_url_spec text,
    thumbnail_url text,
    title text,
    url_tags text,
    use_page_actor_override text,
    video_id text,
    image_file text,
    is_dco_internal text,
    url_post text,
    created_time text,
    id_ad integer,
    date_consult timestamp(6) with time zone
);


--
-- Name: field_configuration_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.field_configuration_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: field_configuration; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.field_configuration (
    id_field_configuration integer DEFAULT nextval('public.field_configuration_seq'::regclass) NOT NULL,
    id_platform integer NOT NULL,
    type_configuration text NOT NULL,
    name_field text NOT NULL,
    active public.active_status,
    serialize public.active_status,
    date_created timestamp without time zone DEFAULT now()
);


--
-- Name: insight_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.insight_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: insight; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.insight (
    id_insight integer DEFAULT nextval('public.insight_seq'::regclass) NOT NULL,
    level_insight text NOT NULL,
    account_currency text,
    account_id text,
    account_name text,
    action_values json,
    actions json,
    activity_recency text,
    ad_click_actions text,
    ad_format_asset json,
    ad_id text,
    ad_impression_actions text,
    ad_name text,
    adset_id text,
    adset_name text,
    age text,
    age_targeting text,
    auction_bid text,
    auction_competitiveness text,
    auction_max_competitor_bid text,
    body_asset json,
    buying_type text,
    call_to_action_asset json,
    campaign_id text,
    campaign_name text,
    canvas_avg_view_percent text,
    canvas_avg_view_time text,
    clicks text,
    conversion_values text,
    conversions text,
    cost_per_10_sec_video_view json,
    cost_per_15_sec_video_view json,
    cost_per_2_sec_continuous_video_view json,
    cost_per_action_type json,
    cost_per_ad_click text,
    cost_per_conversion text,
    cost_per_dda_countby_convs text,
    cost_per_estimated_ad_recallers text,
    cost_per_inline_link_click text,
    cost_per_inline_post_engagement text,
    cost_per_one_thousand_ad_impression text,
    cost_per_outbound_click json,
    cost_per_thruplay json,
    cost_per_unique_action_type json,
    cost_per_unique_click text,
    cost_per_unique_inline_link_click json,
    cost_per_unique_outbound_click json,
    country text,
    cpc text,
    cpm text,
    cpp text,
    created_time text,
    ctr text,
    date_start text,
    date_stop text,
    dda_countby_convs text,
    description_asset json,
    device_platform text,
    dma json,
    estimated_ad_recall_rate text,
    estimated_ad_recall_rate_lower_bound text,
    estimated_ad_recall_rate_upper_bound text,
    estimated_ad_recallers text,
    estimated_ad_recallers_lower_bound text,
    estimated_ad_recallers_upper_bound text,
    frequency text,
    frequency_value json,
    gender text,
    gender_targeting text,
    hourly_stats_aggregated_by_advertiser_time_zone json,
    hourly_stats_aggregated_by_audience_time_zone json,
    image_asset json,
    impression_device json,
    impressions text,
    inline_link_click_ctr text,
    inline_link_clicks text,
    inline_post_engagement text,
    link_url_asset json,
    location_data text,
    mobile_app_purchase_roas text,
    objective text,
    outbound_clicks json,
    outbound_clicks_ctr json,
    place_page_id json,
    place_page_name text,
    product_id json,
    publisher_platform json,
    purchase_roas text,
    reach text,
    region text,
    relevance_score json,
    reporting_ends text,
    reporting_starts text,
    social_spend text,
    spend text,
    title_asset json,
    unique_actions json,
    unique_clicks text,
    unique_ctr text,
    unique_inline_link_click_ctr text,
    unique_inline_link_clicks text,
    unique_link_clicks_ctr text,
    unique_outbound_clicks json,
    unique_outbound_clicks_ctr json,
    unique_video_continuous_2_sec_watched_actions json,
    unique_video_view_10_sec json,
    unique_video_view_15_sec json,
    updated_time text,
    video_10_sec_watched_actions json,
    video_15_sec_watched_actions json,
    video_30_sec_watched_actions json,
    video_asset json,
    video_avg_percent_watched_actions json,
    video_avg_time_watched_actions json,
    video_continuous_2_sec_watched_actions json,
    video_p100_watched_actions json,
    video_p25_watched_actions json,
    video_p50_watched_actions json,
    video_p75_watched_actions json,
    video_p95_watched_actions json,
    video_play_actions json,
    video_play_curve_actions json,
    video_play_retention_0_to_15s_actions text,
    video_play_retention_20_to_60s_actions text,
    video_play_retention_graph_actions text,
    video_thruplay_watched_actions json,
    video_time_watched_actions text,
    website_ctr json,
    website_purchase_roas text,
    wish_bid text,
    date_consult timestamp without time zone DEFAULT now(),
    time_increment text
);


--
-- Name: platform_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.platform_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: platform; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.platform (
    id_platform integer DEFAULT nextval('public.platform_seq'::regclass) NOT NULL,
    platform text,
    platform_short text,
    platform_status public.active_status,
    date timestamp(6) with time zone
);


--
-- Name: task_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.task_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: token_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.token_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.token (
    id_token integer DEFAULT nextval('public.token_seq'::regclass) NOT NULL,
    app_id text NOT NULL,
    app_secret text NOT NULL,
    access_token text NOT NULL,
    token_name text NOT NULL,
    business_id text NOT NULL,
    date_created timestamp(6) without time zone DEFAULT now(),
    date_expiration timestamp(6) without time zone,
    since date,
    until date,
    period text,
    breakdown public.active_status,
    increment text
);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ad; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: adset; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: breakdown_configuration; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.breakdown_configuration (id_breakdown_configuration, name, active, date_created) VALUES (28, 'region', 'N', '2019-06-21 00:54:07.332766');
INSERT INTO public.breakdown_configuration (id_breakdown_configuration, name, active, date_created) VALUES (37, 'device_platform', 'N', '2019-06-21 00:54:07.332766');
INSERT INTO public.breakdown_configuration (id_breakdown_configuration, name, active, date_created) VALUES (21, 'country', 'Y', '2019-06-21 00:54:07.332766');
INSERT INTO public.breakdown_configuration (id_breakdown_configuration, name, active, date_created) VALUES (23, 'gender', 'N', '2019-06-21 00:54:07.332766');
INSERT INTO public.breakdown_configuration (id_breakdown_configuration, name, active, date_created) VALUES (18, 'age', 'N', '2019-06-21 00:54:07.332766');


--
-- Data for Name: campaing; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: creative; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: field_configuration; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (361, 1, 'campaing', 'account_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (362, 1, 'campaing', 'adlabels', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (363, 1, 'campaing', 'bid_strategy', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (364, 1, 'campaing', 'boosted_object_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (365, 1, 'campaing', 'brand_lift_studies', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (366, 1, 'campaing', 'budget_rebalance_flag', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (367, 1, 'campaing', 'budget_remaining', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (368, 1, 'campaing', 'buying_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (369, 1, 'campaing', 'can_create_brand_lift_study', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (370, 1, 'campaing', 'can_use_spend_cap', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (371, 1, 'campaing', 'configured_status', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (372, 1, 'campaing', 'created_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (373, 1, 'campaing', 'daily_budget', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (374, 1, 'campaing', 'effective_status', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (375, 1, 'campaing', 'issues_info', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (376, 1, 'campaing', 'last_budget_toggling_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (377, 1, 'campaing', 'lifetime_budget', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (378, 1, 'campaing', 'name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (379, 1, 'campaing', 'objective', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (380, 1, 'campaing', 'pacing_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (381, 1, 'campaing', 'promoted_object', 'Y', 'Y', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (382, 1, 'campaing', 'recommendations', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (383, 1, 'campaing', 'source_campaign', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (384, 1, 'campaing', 'source_campaign_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (385, 1, 'campaing', 'spend_cap', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (386, 1, 'campaing', 'start_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (387, 1, 'campaing', 'status', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (388, 1, 'campaing', 'stop_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (389, 1, 'campaing', 'topline_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (390, 1, 'campaing', 'updated_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (391, 1, 'campaing', 'adbatch', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (392, 1, 'campaing', 'execution_options', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (393, 1, 'campaing', 'iterative_split_test_configs', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (394, 1, 'campaing', 'upstream_events', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (395, 1, 'adset', 'account_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (396, 1, 'adset', 'adlabels', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (397, 1, 'adset-insight', 'outbound_clicks_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (398, 1, 'adset-insight', 'place_page_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (399, 1, 'adset', 'bid_amount', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (400, 1, 'adset', 'bid_info', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (401, 1, 'adset-insight', 'purchase_roas', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (402, 1, 'adset', 'campaign_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (403, 1, 'adset', 'configured_status', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (404, 1, 'adset', 'created_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (405, 1, 'adset-insight', 'reach', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (407, 1, 'adset-insight', 'social_spend', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (408, 1, 'adset', 'effective_status', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (409, 1, 'adset-insight', 'spend', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (411, 1, 'adset-insight', 'unique_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (412, 1, 'adset-insight', 'unique_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (413, 1, 'adset', 'issues_info', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (414, 1, 'adset-insight', 'unique_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (415, 1, 'adset-insight', 'unique_inline_link_click_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (416, 1, 'adset-insight', 'unique_inline_link_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (417, 1, 'adset', 'name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (418, 1, 'adset-insight', 'unique_link_clicks_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (419, 1, 'adset-insight', 'unique_outbound_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (420, 1, 'adset-insight', 'unique_outbound_clicks_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (421, 1, 'adset-insight', 'unique_video_continuous_2_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (422, 1, 'adset', 'recommendations', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (423, 1, 'adset-insight', 'unique_video_view_10_sec', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (424, 1, 'adset-insight', 'unique_video_view_15_sec', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (425, 1, 'adset-insight', 'updated_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (426, 1, 'adset-insight', 'video_10_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (427, 1, 'adset-insight', 'video_15_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (428, 1, 'adset-insight', 'video_30_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (429, 1, 'adset', 'status', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (430, 1, 'adset', 'targeting', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (431, 1, 'adset', 'updated_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (432, 1, 'adset-insight', 'video_avg_time_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (433, 1, 'adset', 'date_format', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (434, 1, 'adset', 'execution_options', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (435, 1, 'ad-insight', 'account_currency', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (436, 1, 'ad-insight', 'account_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (437, 1, 'ad-insight', 'account_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (438, 1, 'ad-insight', 'action_values', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (439, 1, 'ad-insight', 'actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (440, 1, 'ad-insight', 'ad_click_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (441, 1, 'ad-insight', 'ad_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (442, 1, 'ad-insight', 'ad_impression_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (443, 1, 'ad-insight', 'ad_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (444, 1, 'ad-insight', 'adset_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (445, 1, 'ad-insight', 'adset_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (446, 1, 'ad-insight', 'age_targeting', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (447, 1, 'ad-insight', 'auction_bid', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (448, 1, 'ad-insight', 'auction_competitiveness', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (449, 1, 'ad-insight', 'auction_max_competitor_bid', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (450, 1, 'ad-insight', 'buying_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (451, 1, 'ad-insight', 'campaign_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (452, 1, 'ad-insight', 'campaign_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (453, 1, 'ad-insight', 'canvas_avg_view_percent', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (454, 1, 'ad-insight', 'canvas_avg_view_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (455, 1, 'ad-insight', 'clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (456, 1, 'ad-insight', 'conversion_values', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (457, 1, 'ad-insight', 'conversions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (458, 1, 'ad-insight', 'cost_per_10_sec_video_view', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (459, 1, 'ad-insight', 'cost_per_15_sec_video_view', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (460, 1, 'ad-insight', 'cost_per_2_sec_continuous_video_view', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (461, 1, 'ad-insight', 'cost_per_action_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (462, 1, 'ad-insight', 'cost_per_ad_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (463, 1, 'ad-insight', 'cost_per_conversion', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (464, 1, 'ad-insight', 'cost_per_dda_countby_convs', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (465, 1, 'ad-insight', 'cost_per_estimated_ad_recallers', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (466, 1, 'ad-insight', 'cost_per_inline_link_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (467, 1, 'ad-insight', 'cost_per_inline_post_engagement', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (468, 1, 'ad-insight', 'cost_per_one_thousand_ad_impression', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (469, 1, 'ad-insight', 'cost_per_outbound_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (470, 1, 'ad-insight', 'cost_per_thruplay', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (471, 1, 'ad-insight', 'cost_per_unique_action_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (472, 1, 'ad-insight', 'cost_per_unique_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (473, 1, 'ad-insight', 'cpc', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (474, 1, 'ad-insight', 'cpm', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (475, 1, 'ad-insight', 'cpp', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (476, 1, 'ad-insight', 'created_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (477, 1, 'ad-insight', 'ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (478, 1, 'ad-insight', 'date_start', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (479, 1, 'ad-insight', 'date_stop', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (480, 1, 'ad-insight', 'dda_countby_convs', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (481, 1, 'ad-insight', 'estimated_ad_recall_rate', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (482, 1, 'ad-insight', 'estimated_ad_recall_rate_lower_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (483, 1, 'ad-insight', 'estimated_ad_recall_rate_upper_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (484, 1, 'ad-insight', 'estimated_ad_recallers', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (485, 1, 'ad-insight', 'estimated_ad_recallers_lower_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (486, 1, 'ad-insight', 'estimated_ad_recallers_upper_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (487, 1, 'ad-insight', 'frequency', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (488, 1, 'ad-insight', 'gender_targeting', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (489, 1, 'ad-insight', 'impressions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (490, 1, 'ad-insight', 'inline_link_click_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (491, 1, 'ad-insight', 'inline_link_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (492, 1, 'ad-insight', 'inline_post_engagement', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (493, 1, 'ad-insight', 'location', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (494, 1, 'ad-insight', 'mobile_app_purchase_roas', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (495, 1, 'ad-insight', 'objective', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (496, 1, 'ad-insight', 'outbound_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (497, 1, 'ad-insight', 'outbound_clicks_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (498, 1, 'ad-insight', 'place_page_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (499, 1, 'ad-insight', 'purchase_roas', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (500, 1, 'ad-insight', 'reach', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (502, 1, 'ad-insight', 'social_spend', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (503, 1, 'ad-insight', 'spend', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (504, 1, 'ad-insight', 'unique_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (505, 1, 'ad-insight', 'unique_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (506, 1, 'ad-insight', 'unique_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (507, 1, 'ad-insight', 'unique_inline_link_click_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (508, 1, 'ad-insight', 'unique_inline_link_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (509, 1, 'ad-insight', 'unique_link_clicks_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (510, 1, 'ad-insight', 'unique_outbound_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (511, 1, 'ad-insight', 'unique_outbound_clicks_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (512, 1, 'ad-insight', 'unique_video_continuous_2_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (513, 1, 'ad-insight', 'unique_video_view_10_sec', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (514, 1, 'ad-insight', 'unique_video_view_15_sec', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (515, 1, 'ad-insight', 'updated_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (516, 1, 'ad-insight', 'video_10_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (517, 1, 'ad-insight', 'video_15_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (518, 1, 'ad-insight', 'video_30_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (519, 1, 'ad-insight', 'video_avg_time_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (520, 1, 'ad-insight', 'video_continuous_2_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (521, 1, 'ad-insight', 'video_p100_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (522, 1, 'ad-insight', 'video_p25_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (523, 1, 'ad-insight', 'video_p50_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (524, 1, 'ad-insight', 'video_p75_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (525, 1, 'ad-insight', 'video_play_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (526, 1, 'ad-insight', 'video_play_curve_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (527, 1, 'ad-insight', 'video_play_retention_0_to_15s_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (528, 1, 'ad-insight', 'video_play_retention_20_to_60s_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (529, 1, 'ad-insight', 'video_play_retention_graph_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (530, 1, 'ad-insight', 'video_thruplay_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (531, 1, 'ad-insight', 'video_time_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (532, 1, 'ad-insight', 'website_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (533, 1, 'ad-insight', 'website_purchase_roas', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (534, 1, 'ad-insight', 'wish_bid', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (535, 1, 'ad', 'account_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (536, 1, 'ad', 'created_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (537, 1, 'ad', 'ad_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (539, 1, 'campaing-insight', 'account_currency', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (540, 1, 'campaing-insight', 'account_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (541, 1, 'campaing-insight', 'account_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (542, 1, 'campaing-insight', 'action_values', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (543, 1, 'campaing-insight', 'actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (545, 1, 'campaing-insight', 'ad_click_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (546, 1, 'adset-insight', 'video_continuous_2_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (547, 1, 'campaing-insight', 'ad_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (548, 1, 'campaing-insight', 'ad_impression_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (549, 1, 'campaing-insight', 'ad_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (550, 1, 'campaing-insight', 'adset_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (551, 1, 'campaing-insight', 'adset_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (552, 1, 'campaing-insight', 'age_targeting', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (538, 1, 'ad', 'ad_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (553, 1, 'campaing-insight', 'auction_bid', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (554, 1, 'campaing-insight', 'auction_competitiveness', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (555, 1, 'campaing-insight', 'auction_max_competitor_bid', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (556, 1, 'campaing-insight', 'buying_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (557, 1, 'campaing-insight', 'campaign_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (558, 1, 'campaing-insight', 'campaign_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (559, 1, 'campaing-insight', 'canvas_avg_view_percent', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (560, 1, 'campaing-insight', 'canvas_avg_view_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (561, 1, 'campaing-insight', 'clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (562, 1, 'campaing-insight', 'conversion_values', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (563, 1, 'campaing-insight', 'conversions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (564, 1, 'campaing-insight', 'cost_per_10_sec_video_view', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (565, 1, 'campaing-insight', 'cost_per_15_sec_video_view', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (566, 1, 'campaing-insight', 'cost_per_2_sec_continuous_video_view', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (567, 1, 'campaing-insight', 'cost_per_action_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (568, 1, 'campaing-insight', 'cost_per_ad_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (569, 1, 'campaing-insight', 'cost_per_conversion', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (570, 1, 'campaing-insight', 'cost_per_dda_countby_convs', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (571, 1, 'campaing-insight', 'cost_per_estimated_ad_recallers', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (572, 1, 'campaing-insight', 'cost_per_inline_link_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (573, 1, 'campaing-insight', 'cost_per_inline_post_engagement', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (574, 1, 'campaing-insight', 'cost_per_one_thousand_ad_impression', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (575, 1, 'campaing-insight', 'cost_per_outbound_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (576, 1, 'campaing-insight', 'cost_per_thruplay', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (577, 1, 'campaing-insight', 'cost_per_unique_action_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (578, 1, 'campaing-insight', 'cost_per_unique_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (579, 1, 'campaing-insight', 'cost_per_unique_inline_link_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (580, 1, 'campaing-insight', 'cost_per_unique_outbound_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (581, 1, 'adset-insight', 'account_currency', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (582, 1, 'campaing-insight', 'cpc', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (583, 1, 'campaing-insight', 'cpm', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (584, 1, 'campaing-insight', 'cpp', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (585, 1, 'campaing-insight', 'created_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (586, 1, 'adset-insight', 'account_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (587, 1, 'campaing-insight', 'ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (588, 1, 'campaing-insight', 'date_start', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (589, 1, 'campaing-insight', 'date_stop', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (590, 1, 'campaing-insight', 'dda_countby_convs', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (591, 1, 'adset-insight', 'account_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (592, 1, 'adset-insight', 'action_values', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (593, 1, 'adset-insight', 'actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (594, 1, 'campaing-insight', 'estimated_ad_recall_rate', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (595, 1, 'campaing-insight', 'estimated_ad_recall_rate_lower_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (596, 1, 'campaing-insight', 'estimated_ad_recall_rate_upper_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (597, 1, 'campaing-insight', 'estimated_ad_recallers', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (598, 1, 'campaing-insight', 'estimated_ad_recallers_lower_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (599, 1, 'campaing-insight', 'estimated_ad_recallers_upper_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (600, 1, 'campaing-insight', 'frequency', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (601, 1, 'adset-insight', 'ad_click_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (602, 1, 'campaing-insight', 'gender_targeting', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (603, 1, 'adset-insight', 'ad_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (604, 1, 'adset-insight', 'ad_impression_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (605, 1, 'adset-insight', 'ad_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (606, 1, 'campaing-insight', 'impressions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (607, 1, 'campaing-insight', 'inline_link_click_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (608, 1, 'campaing-insight', 'inline_link_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (609, 1, 'campaing-insight', 'inline_post_engagement', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (610, 1, 'campaing-insight', 'labels', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (611, 1, 'adset-insight', 'adset_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (612, 1, 'campaing-insight', 'location', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (613, 1, 'adset-insight', 'adset_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (614, 1, 'campaing-insight', 'mobile_app_purchase_roas', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (615, 1, 'campaing-insight', 'objective', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (616, 1, 'campaing-insight', 'outbound_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (617, 1, 'campaing-insight', 'outbound_clicks_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (618, 1, 'campaing-insight', 'place_page_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (619, 1, 'adset-insight', 'age_targeting', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (620, 1, 'campaing-insight', 'purchase_roas', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (621, 1, 'campaing-insight', 'reach', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (623, 1, 'adset-insight', 'buying_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (624, 1, 'campaing-insight', 'social_spend', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (625, 1, 'campaing-insight', 'spend', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (626, 1, 'campaing-insight', 'unique_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (627, 1, 'campaing-insight', 'unique_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (628, 1, 'campaing-insight', 'unique_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (629, 1, 'campaing-insight', 'unique_inline_link_click_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (630, 1, 'adset-insight', 'campaign_id', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (631, 1, 'campaing-insight', 'unique_inline_link_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (632, 1, 'campaing-insight', 'unique_link_clicks_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (633, 1, 'campaing-insight', 'unique_outbound_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (634, 1, 'campaing-insight', 'unique_outbound_clicks_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (635, 1, 'campaing-insight', 'unique_video_continuous_2_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (636, 1, 'campaing-insight', 'unique_video_view_10_sec', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (637, 1, 'campaing-insight', 'unique_video_view_15_sec', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (638, 1, 'campaing-insight', 'updated_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (639, 1, 'campaing-insight', 'video_10_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (640, 1, 'campaing-insight', 'video_15_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (641, 1, 'campaing-insight', 'video_30_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (642, 1, 'adset-insight', 'campaign_name', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (643, 1, 'campaing-insight', 'video_avg_time_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (644, 1, 'campaing-insight', 'video_continuous_2_sec_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (645, 1, 'campaing-insight', 'video_p100_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (646, 1, 'campaing-insight', 'video_p25_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (647, 1, 'campaing-insight', 'video_p50_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (648, 1, 'campaing-insight', 'video_p75_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (649, 1, 'campaing-insight', 'video_play_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (650, 1, 'campaing-insight', 'video_play_curve_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (651, 1, 'campaing-insight', 'video_play_retention_0_to_15s_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (652, 1, 'campaing-insight', 'video_play_retention_20_to_60s_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (653, 1, 'campaing-insight', 'video_play_retention_graph_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (654, 1, 'campaing-insight', 'video_thruplay_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (655, 1, 'campaing-insight', 'video_time_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (656, 1, 'campaing-insight', 'website_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (657, 1, 'campaing-insight', 'website_purchase_roas', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (658, 1, 'campaing-insight', 'wish_bid', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (659, 1, 'adset-insight', 'canvas_avg_view_percent', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (660, 1, 'adset-insight', 'canvas_avg_view_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (661, 1, 'adset-insight', 'clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (662, 1, 'adset-insight', 'conversion_values', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (663, 1, 'adset-insight', 'conversions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (664, 1, 'adset-insight', 'cost_per_10_sec_video_view', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (665, 1, 'adset-insight', 'cost_per_15_sec_video_view', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (666, 1, 'adset-insight', 'cost_per_2_sec_continuous_video_view', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (667, 1, 'adset-insight', 'cost_per_action_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (668, 1, 'adset-insight', 'cost_per_ad_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (669, 1, 'adset-insight', 'cost_per_conversion', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (670, 1, 'adset-insight', 'cost_per_dda_countby_convs', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (671, 1, 'adset-insight', 'cost_per_estimated_ad_recallers', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (672, 1, 'adset-insight', 'cost_per_inline_link_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (673, 1, 'adset-insight', 'cost_per_inline_post_engagement', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (674, 1, 'adset-insight', 'cost_per_one_thousand_ad_impression', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (675, 1, 'adset-insight', 'cost_per_outbound_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (676, 1, 'adset-insight', 'cost_per_thruplay', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (677, 1, 'adset-insight', 'cost_per_unique_action_type', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (678, 1, 'adset-insight', 'cost_per_unique_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (679, 1, 'adset-insight', 'cost_per_unique_inline_link_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (680, 1, 'adset-insight', 'cost_per_unique_outbound_click', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (681, 1, 'adset-insight', 'cpc', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (682, 1, 'adset-insight', 'cpm', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (683, 1, 'adset-insight', 'cpp', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (684, 1, 'adset-insight', 'created_time', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (685, 1, 'adset-insight', 'ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (686, 1, 'adset-insight', 'date_start', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (687, 1, 'adset-insight', 'date_stop', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (688, 1, 'adset-insight', 'dda_countby_convs', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (689, 1, 'adset-insight', 'estimated_ad_recall_rate', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (690, 1, 'adset-insight', 'estimated_ad_recall_rate_lower_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (691, 1, 'adset-insight', 'estimated_ad_recall_rate_upper_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (692, 1, 'adset-insight', 'estimated_ad_recallers', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (693, 1, 'adset-insight', 'estimated_ad_recallers_lower_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (694, 1, 'adset-insight', 'estimated_ad_recallers_upper_bound', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (695, 1, 'adset-insight', 'frequency', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (696, 1, 'adset-insight', 'gender_targeting', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (697, 1, 'adset-insight', 'impressions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (698, 1, 'adset-insight', 'inline_link_click_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (699, 1, 'adset-insight', 'inline_link_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (700, 1, 'adset-insight', 'inline_post_engagement', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (701, 1, 'adset-insight', 'labels', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (702, 1, 'adset-insight', 'location', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (703, 1, 'adset-insight', 'mobile_app_purchase_roas', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (704, 1, 'adset-insight', 'objective', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (705, 1, 'adset-insight', 'outbound_clicks', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (706, 1, 'adset-insight', 'video_p100_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (707, 1, 'adset-insight', 'video_p25_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (708, 1, 'adset-insight', 'video_p50_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (709, 1, 'adset-insight', 'video_p75_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (710, 1, 'adset-insight', 'video_play_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (711, 1, 'adset-insight', 'video_play_curve_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (712, 1, 'adset-insight', 'video_play_retention_0_to_15s_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (713, 1, 'adset-insight', 'video_play_retention_20_to_60s_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (714, 1, 'adset-insight', 'video_play_retention_graph_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (715, 1, 'adset-insight', 'video_thruplay_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (716, 1, 'adset-insight', 'video_time_watched_actions', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (717, 1, 'adset-insight', 'website_ctr', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (718, 1, 'adset-insight', 'website_purchase_roas', 'Y', 'N', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (406, 1, 'adset-insight', 'relevance_score', 'Y', 'Y', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (501, 1, 'ad-insight', 'relevance_score', 'Y', 'Y', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (622, 1, 'campaing-insight', 'relevance_score', 'Y', 'Y', '2019-09-25 16:53:18.830828');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (410, 1, 'adset', 'id', 'Y', 'N', '2019-09-25 18:12:20.7004');
INSERT INTO public.field_configuration (id_field_configuration, id_platform, type_configuration, name_field, active, serialize, date_created) VALUES (544, 1, 'campaing', 'id', 'Y', 'N', '2019-09-25 17:40:19.439626');


--
-- Data for Name: insight; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: platform; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.platform (id_platform, platform, platform_short, platform_status, date) VALUES (1, 'BUSINESS MANAGER', 'FBM', 'Y', '2019-09-15 18:42:05-05');


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.token (id_token, app_id, app_secret, access_token, token_name, business_id, date_created, date_expiration, since, until, period, breakdown, increment) VALUES (1, '314693332729550', 'a1ef00d12efc1e3a12fa01803980b645', 'EAAEeNkBPfs4BAAWcJN5qhV7p0xnZA5S7XiP1C2ciGR9llI4K9TXLqlHjZCZCkPZAZBZCRxCgMkhyZAoK1ZCVKfOA8LXw2xHLLCgvZB627ZC5XcdYloIgEZAjf3kNfMSQCeXFwIlAqekkZB2wcRkkfTvgJALiEAkRNA0v4tawJq1W4ZAvopQZDZD', 'default', '275139826019364', '2019-06-20 00:47:31.644228', NULL, '2019-09-01', '2019-09-19', 'lifetime', 'N', 'all_days');


--
-- Name: account_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.account_seq', 2193, true);


--
-- Name: ad_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ad_seq', 445, true);


--
-- Name: adset_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.adset_seq', 725, true);


--
-- Name: breakdown_configuration_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.breakdown_configuration_seq', 2, false);


--
-- Name: campaing_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.campaing_seq', 287, true);


--
-- Name: creative_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.creative_seq', 79, true);


--
-- Name: field_configuration_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.field_configuration_seq', 718, true);


--
-- Name: insight_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.insight_seq', 1259, true);


--
-- Name: platform_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.platform_seq', 2, true);


--
-- Name: task_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.task_seq', 2, false);


--
-- Name: token_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.token_seq', 2, false);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: ad ad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ad
    ADD CONSTRAINT ad_pkey PRIMARY KEY (id);


--
-- Name: adset adset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adset
    ADD CONSTRAINT adset_pkey PRIMARY KEY (id);


--
-- Name: breakdown_configuration breakdown_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.breakdown_configuration
    ADD CONSTRAINT breakdown_configuration_pkey PRIMARY KEY (id_breakdown_configuration);


--
-- Name: campaing campaing_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaing
    ADD CONSTRAINT campaing_pkey PRIMARY KEY (id);


--
-- Name: creative creative_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creative
    ADD CONSTRAINT creative_pkey PRIMARY KEY (id);


--
-- Name: platform platform_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_pkey PRIMARY KEY (id_platform);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id_token);


--
-- Name: ad unique_ad_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ad
    ADD CONSTRAINT unique_ad_id UNIQUE (ad_id);


--
-- Name: field_configuration platform_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.field_configuration
    ADD CONSTRAINT platform_id FOREIGN KEY (id_platform) REFERENCES public.platform(id_platform);


--
-- Name: campaing platform_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaing
    ADD CONSTRAINT platform_id FOREIGN KEY (id_platform) REFERENCES public.platform(id_platform);


--
-- PostgreSQL database dump complete
--

