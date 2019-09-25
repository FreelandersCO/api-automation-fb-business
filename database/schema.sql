/*
 Navicat PostgreSQL Data Transfer

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 110004
 Source Host           : localhost:5432
 Source Catalog        : havas_automation
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 110004
 File Encoding         : 65001

 Date: 19/09/2019 23:06:51
*/


-- ----------------------------
-- Type structure for active_status
-- ----------------------------
DROP TYPE IF EXISTS "public"."active_status";
CREATE TYPE "public"."active_status" AS ENUM (
  'Y',
  'N'
);
ALTER TYPE "public"."active_status" OWNER TO "postgres";

-- ----------------------------
-- Type structure for task_period
-- ----------------------------
DROP TYPE IF EXISTS "public"."task_period";
CREATE TYPE "public"."task_period" AS ENUM (
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
ALTER TYPE "public"."task_period" OWNER TO "postgres";

-- ----------------------------
-- Type structure for task_status
-- ----------------------------
DROP TYPE IF EXISTS "public"."task_status";
CREATE TYPE "public"."task_status" AS ENUM (
  'P',
  'R',
  'F'
);
ALTER TYPE "public"."task_status" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for account_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."account_seq";
CREATE SEQUENCE "public"."account_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."account_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for ad_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."ad_seq";
CREATE SEQUENCE "public"."ad_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."ad_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for adset_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."adset_seq";
CREATE SEQUENCE "public"."adset_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."adset_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for breakdown_configuration_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."breakdown_configuration_seq";
CREATE SEQUENCE "public"."breakdown_configuration_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."breakdown_configuration_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for campaing_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."campaing_seq";
CREATE SEQUENCE "public"."campaing_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."campaing_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for creative_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."creative_seq";
CREATE SEQUENCE "public"."creative_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."creative_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for field_configuration_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."field_configuration_seq";
CREATE SEQUENCE "public"."field_configuration_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."field_configuration_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for insight_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."insight_seq";
CREATE SEQUENCE "public"."insight_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."insight_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for platform_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."platform_seq";
CREATE SEQUENCE "public"."platform_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."platform_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for task_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."task_seq";
CREATE SEQUENCE "public"."task_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."task_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for token_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."token_seq";
CREATE SEQUENCE "public"."token_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."token_seq" OWNER TO "postgres";

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS "public"."account";
CREATE TABLE "public"."account" (
  "id" int4 NOT NULL DEFAULT nextval('account_seq'::regclass),
  "account_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "account_status" text COLLATE "pg_catalog"."default" NOT NULL,
  "age" text COLLATE "pg_catalog"."default" NOT NULL,
  "amount_spent" text COLLATE "pg_catalog"."default" NOT NULL,
  "fb_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "active" "public"."active_status"
)
;
ALTER TABLE "public"."account" OWNER TO "postgres";


-- ----------------------------
-- Table structure for ad
-- ----------------------------
DROP TABLE IF EXISTS "public"."ad";
CREATE TABLE "public"."ad" (
  "id" int4 NOT NULL DEFAULT nextval('ad_seq'::regclass),
  "account_id" text COLLATE "pg_catalog"."default",
  "ad_id" text COLLATE "pg_catalog"."default",
  "ad_name" text COLLATE "pg_catalog"."default",
  "adset_id" TEXT,
  "read" "public"."active_status",
  "created_time" text COLLATE "pg_catalog"."default",
  "date_consult" timestamptz(6) DEFAULT NOW(),
  "id_platform" int4
)
;
ALTER TABLE "public"."ad" OWNER TO "postgres";

-- ----------------------------
-- Table structure for adset
-- ----------------------------
DROP TABLE IF EXISTS "public"."adset";
CREATE TABLE "public"."adset" (
  "id" int4 NOT NULL DEFAULT nextval('adset_seq'::regclass),
  "account_id" text COLLATE "pg_catalog"."default",
  "adlabels" text COLLATE "pg_catalog"."default",
  "adset_id" text COLLATE "pg_catalog"."default",
  "adset_schedule" json,
  "asset_feed_id" text COLLATE "pg_catalog"."default",
  "attribution_spec" json,
  "best_creative" text COLLATE "pg_catalog"."default",
  "bid_adjustments" text COLLATE "pg_catalog"."default",
  "bid_amount" text COLLATE "pg_catalog"."default",
  "bid_constraints" text COLLATE "pg_catalog"."default",
  "bid_info" json,
  "billing_event" text COLLATE "pg_catalog"."default",
  "budget_remaining" text COLLATE "pg_catalog"."default",
  "campaign_id" text COLLATE "pg_catalog"."default",
  "campaign_spec" text COLLATE "pg_catalog"."default",
  "configured_status" text COLLATE "pg_catalog"."default",
  "created_time" text COLLATE "pg_catalog"."default",
  "creative_sequence" text COLLATE "pg_catalog"."default",
  "daily_budget" text COLLATE "pg_catalog"."default",
  "daily_min_spend_target" text COLLATE "pg_catalog"."default",
  "daily_spend_cap" text COLLATE "pg_catalog"."default",
  "date_format" text COLLATE "pg_catalog"."default",
  "destination_type" text COLLATE "pg_catalog"."default",
  "effective_status" text COLLATE "pg_catalog"."default",
  "end_time" text COLLATE "pg_catalog"."default",
  "execution_options" text COLLATE "pg_catalog"."default",
  "frequency_control_specs" json,
  "instagram_actor_id" text COLLATE "pg_catalog"."default",
  "is_dynamic_creative" text COLLATE "pg_catalog"."default",
  "issues_info" text COLLATE "pg_catalog"."default",
  "lifetime_budget" text COLLATE "pg_catalog"."default",
  "lifetime_imps" text COLLATE "pg_catalog"."default",
  "lifetime_min_spend_target" text COLLATE "pg_catalog"."default",
  "lifetime_spend_cap" text COLLATE "pg_catalog"."default",
  "name" text COLLATE "pg_catalog"."default",
  "optimization_goal" text COLLATE "pg_catalog"."default",
  "optimization_sub_event" text COLLATE "pg_catalog"."default",
  "pacing_type" json,
  "promoted_object" json,
  "rb_prediction_id" text COLLATE "pg_catalog"."default",
  "recommendations" json,
  "recurring_budget_semantics" text COLLATE "pg_catalog"."default",
  "review_feedback" text COLLATE "pg_catalog"."default",
  "rf_prediction_id" text COLLATE "pg_catalog"."default",
  "source_adset" json,
  "source_adset_id" text COLLATE "pg_catalog"."default",
  "start_time" text COLLATE "pg_catalog"."default",
  "status" text COLLATE "pg_catalog"."default",
  "targeting" json,
  "time_based_ad_rotation_id_blocks" text COLLATE "pg_catalog"."default",
  "time_based_ad_rotation_intervals" text COLLATE "pg_catalog"."default",
  "time_start" text COLLATE "pg_catalog"."default",
  "time_stop" text COLLATE "pg_catalog"."default",
  "updated_time" text COLLATE "pg_catalog"."default",
  "upstream_events" text COLLATE "pg_catalog"."default",
  "use_new_app_click" text COLLATE "pg_catalog"."default",
  "date_consult" timestamptz(6),
  "id_platform" int4
)
;
ALTER TABLE "public"."adset" OWNER TO "postgres";

-- ----------------------------
-- Table structure for breakdown_configuration
-- ----------------------------
DROP TABLE IF EXISTS "public"."breakdown_configuration";
CREATE TABLE "public"."breakdown_configuration" (
  "id_breakdown_configuration" int4 NOT NULL DEFAULT nextval('breakdown_configuration_seq'::regclass),
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "active" "public"."active_status",
  "date_created" timestamp(6) DEFAULT now()
)
;
ALTER TABLE "public"."breakdown_configuration" OWNER TO "postgres";

-- ----------------------------
-- Records of breakdown_configuration
-- ----------------------------
BEGIN;
INSERT INTO "public"."breakdown_configuration" VALUES (21, 'country', 'N', '2019-06-21 00:54:07.332766');
INSERT INTO "public"."breakdown_configuration" VALUES (23, 'gender', 'N', '2019-06-21 00:54:07.332766');
INSERT INTO "public"."breakdown_configuration" VALUES (28, 'region', 'N', '2019-06-21 00:54:07.332766');
INSERT INTO "public"."breakdown_configuration" VALUES (37, 'device_platform', 'Y', '2019-06-21 00:54:07.332766');
INSERT INTO "public"."breakdown_configuration" VALUES (18, 'age', 'N', '2019-06-21 00:54:07.332766');
COMMIT;

-- ----------------------------
-- Table structure for campaing
-- ----------------------------
DROP TABLE IF EXISTS "public"."campaing";
CREATE TABLE "public"."campaing" (
  "id_campaign" int4 NOT NULL DEFAULT nextval('campaing_seq'::regclass),
  "campaing_id" text COLLATE "pg_catalog"."default",
  "account_id" text COLLATE "pg_catalog"."default",
  "adbatch" text COLLATE "pg_catalog"."default",
  "adlabels" text COLLATE "pg_catalog"."default",
  "bid_strategy" text COLLATE "pg_catalog"."default",
  "boosted_object_id" text COLLATE "pg_catalog"."default",
  "brand_lift_studies" text COLLATE "pg_catalog"."default",
  "budget_rebalance_flag" text COLLATE "pg_catalog"."default",
  "budget_remaining" text COLLATE "pg_catalog"."default",
  "buying_type" text COLLATE "pg_catalog"."default",
  "can_create_brand_lift_study" text COLLATE "pg_catalog"."default",
  "can_use_spend_cap" text COLLATE "pg_catalog"."default",
  "configured_status" text COLLATE "pg_catalog"."default",
  "created_time" text COLLATE "pg_catalog"."default",
  "daily_budget" text COLLATE "pg_catalog"."default",
  "effective_status" text COLLATE "pg_catalog"."default",
  "execution_options" text COLLATE "pg_catalog"."default",
  "fb_id" text COLLATE "pg_catalog"."default",
  "issues_info" text COLLATE "pg_catalog"."default",
  "iterative_split_test_configs" text COLLATE "pg_catalog"."default",
  "last_budget_toggling_time" text COLLATE "pg_catalog"."default",
  "lifetime_budget" text COLLATE "pg_catalog"."default",
  "name" text COLLATE "pg_catalog"."default",
  "objective" text COLLATE "pg_catalog"."default",
  "promoted_object" text COLLATE "pg_catalog"."default",
  "recommendations" json,
  "spend_cap" text COLLATE "pg_catalog"."default",
  "start_time" text COLLATE "pg_catalog"."default",
  "status" text COLLATE "pg_catalog"."default",
  "stop_time" text COLLATE "pg_catalog"."default",
  "topline_id" text COLLATE "pg_catalog"."default",
  "updated_time" text COLLATE "pg_catalog"."default",
  "upstream_events" text COLLATE "pg_catalog"."default",
  "pacing_type" text[] COLLATE "pg_catalog"."default",
  "source_campaign_id" text COLLATE "pg_catalog"."default",
  "source_campaign" text[] COLLATE "pg_catalog"."default",
  "date_consult" timestamptz(6),
  "id_platform" int4
)
;
ALTER TABLE "public"."campaing" OWNER TO "postgres";

-- ----------------------------
-- Table structure for creative
-- ----------------------------
DROP TABLE IF EXISTS "public"."creative";
CREATE TABLE "public"."creative" (
  "id" int4 NOT NULL DEFAULT nextval('creative_seq'::regclass),
  "ad_id" text COLLATE "pg_catalog"."default",
  "account_id" text COLLATE "pg_catalog"."default",
  "actor_id" text COLLATE "pg_catalog"."default",
  "adlabels" text COLLATE "pg_catalog"."default",
  "applink_treatment" text COLLATE "pg_catalog"."default",
  "asset_feed_spec" text COLLATE "pg_catalog"."default",
  "authorization_category" text COLLATE "pg_catalog"."default",
  "auto_update" text COLLATE "pg_catalog"."default",
  "body" text COLLATE "pg_catalog"."default",
  "branded_content_sponsor_page_id" text COLLATE "pg_catalog"."default",
  "bundle_folder_id" text COLLATE "pg_catalog"."default",
  "call_to_action_type" text COLLATE "pg_catalog"."default",
  "categorization_criteria" text COLLATE "pg_catalog"."default",
  "category_media_source" text COLLATE "pg_catalog"."default",
  "destination_set_id" text COLLATE "pg_catalog"."default",
  "dynamic_ad_voice" text COLLATE "pg_catalog"."default",
  "effective_authorization_category" text COLLATE "pg_catalog"."default",
  "effective_instagram_story_id" text COLLATE "pg_catalog"."default",
  "effective_object_story_id" text COLLATE "pg_catalog"."default",
  "enable_direct_install" text COLLATE "pg_catalog"."default",
  "enable_launch_instant_app" text COLLATE "pg_catalog"."default",
  "creative_id" text COLLATE "pg_catalog"."default",
  "image_crops" text COLLATE "pg_catalog"."default",
  "image_hash" text COLLATE "pg_catalog"."default",
  "image_url" text COLLATE "pg_catalog"."default",
  "instagram_actor_id" text COLLATE "pg_catalog"."default",
  "instagram_permalink_url" text COLLATE "pg_catalog"."default",
  "instagram_story_id" text COLLATE "pg_catalog"."default",
  "interactive_components_spec" text COLLATE "pg_catalog"."default",
  "link_deep_link_url" text COLLATE "pg_catalog"."default",
  "link_og_id" text COLLATE "pg_catalog"."default",
  "link_url" text COLLATE "pg_catalog"."default",
  "messenger_sponsored_message" text COLLATE "pg_catalog"."default",
  "name" text COLLATE "pg_catalog"."default",
  "object_id" text COLLATE "pg_catalog"."default",
  "object_store_url" text COLLATE "pg_catalog"."default",
  "object_story_id" text COLLATE "pg_catalog"."default",
  "object_story_spec" text COLLATE "pg_catalog"."default",
  "object_type" text COLLATE "pg_catalog"."default",
  "object_url" text COLLATE "pg_catalog"."default",
  "place_page_set_id" text COLLATE "pg_catalog"."default",
  "platform_customizations" text COLLATE "pg_catalog"."default",
  "playable_asset_id" text COLLATE "pg_catalog"."default",
  "portrait_customizations" text COLLATE "pg_catalog"."default",
  "product_set_id" text COLLATE "pg_catalog"."default",
  "recommender_settings" text COLLATE "pg_catalog"."default",
  "status" text COLLATE "pg_catalog"."default",
  "template_url" text COLLATE "pg_catalog"."default",
  "template_url_spec" text COLLATE "pg_catalog"."default",
  "thumbnail_url" text COLLATE "pg_catalog"."default",
  "title" text COLLATE "pg_catalog"."default",
  "url_tags" text COLLATE "pg_catalog"."default",
  "use_page_actor_override" text COLLATE "pg_catalog"."default",
  "video_id" text COLLATE "pg_catalog"."default",
  "image_file" text COLLATE "pg_catalog"."default",
  "is_dco_internal" text COLLATE "pg_catalog"."default",
  "url_post" text COLLATE "pg_catalog"."default",
  "created_time" text COLLATE "pg_catalog"."default",
  "id_ad" int4,
  "date_consult" timestamptz(6)
)
;
ALTER TABLE "public"."creative" OWNER TO "postgres";

-- ----------------------------
-- Table structure for field_configuration
-- ----------------------------
DROP TABLE IF EXISTS "public"."field_configuration";
CREATE TABLE "public"."field_configuration" (
  "id_field_configuration" int4 NOT NULL DEFAULT nextval('field_configuration_seq'::regclass),
  "type_configuration" text COLLATE "pg_catalog"."default" NOT NULL,
  "name_field" text COLLATE "pg_catalog"."default" NOT NULL,
  "active" "public"."active_status",
  "date_created" timestamp(6) DEFAULT now()
)
;
ALTER TABLE "public"."field_configuration" OWNER TO "postgres";

-- ----------------------------
-- Records of field_configuration
-- ----------------------------
BEGIN;
INSERT INTO "public"."field_configuration" VALUES (424, 'campaing', 'account_id', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (425, 'campaing', 'adlabels', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (426, 'campaing', 'bid_strategy', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (427, 'campaing', 'boosted_object_id', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (428, 'campaing', 'brand_lift_studies', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (429, 'campaing', 'budget_rebalance_flag', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (430, 'campaing', 'budget_remaining', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (431, 'campaing', 'buying_type', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (432, 'campaing', 'can_create_brand_lift_study', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (433, 'campaing', 'can_use_spend_cap', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (434, 'campaing', 'configured_status', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (435, 'campaing', 'created_time', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (436, 'campaing', 'daily_budget', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (437, 'campaing', 'effective_status', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (438, 'campaing', 'issues_info', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (439, 'campaing', 'last_budget_toggling_time', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (440, 'campaing', 'lifetime_budget', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (441, 'campaing', 'name', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (442, 'campaing', 'objective', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (443, 'campaing', 'pacing_type', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (444, 'campaing', 'promoted_object', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (445, 'campaing', 'recommendations', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (446, 'campaing', 'source_campaign', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (447, 'campaing', 'source_campaign_id', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (448, 'campaing', 'spend_cap', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (449, 'campaing', 'start_time', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (450, 'campaing', 'status', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (451, 'campaing', 'stop_time', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (452, 'campaing', 'topline_id', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (453, 'campaing', 'updated_time', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (454, 'campaing', 'adbatch', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (455, 'campaing', 'execution_options', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (456, 'campaing', 'iterative_split_test_configs', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (457, 'campaing', 'upstream_events', 'Y', '2019-06-23 22:31:55.578335');
INSERT INTO "public"."field_configuration" VALUES (69, 'adset', 'account_id', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (70, 'adset', 'adlabels', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (544, 'adset-insight', 'outbound_clicks_ctr', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (546, 'adset-insight', 'place_page_name', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (76, 'adset', 'bid_amount', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (78, 'adset', 'bid_info', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (551, 'adset-insight', 'purchase_roas', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (81, 'adset', 'campaign_id', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (82, 'adset', 'configured_status', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (83, 'adset', 'created_time', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (552, 'adset-insight', 'reach', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (554, 'adset-insight', 'relevance_score', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (556, 'adset-insight', 'social_spend', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (89, 'adset', 'effective_status', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (557, 'adset-insight', 'spend', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (92, 'adset', 'id', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (559, 'adset-insight', 'unique_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (560, 'adset-insight', 'unique_clicks', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (95, 'adset', 'issues_info', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (562, 'adset-insight', 'unique_ctr', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (563, 'adset-insight', 'unique_inline_link_click_ctr', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (564, 'adset-insight', 'unique_inline_link_clicks', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (100, 'adset', 'name', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (565, 'adset-insight', 'unique_link_clicks_ctr', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (566, 'adset-insight', 'unique_outbound_clicks', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (567, 'adset-insight', 'unique_outbound_clicks_ctr', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (568, 'adset-insight', 'unique_video_continuous_2_sec_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (105, 'adset', 'recommendations', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (569, 'adset-insight', 'unique_video_view_10_sec', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (570, 'adset-insight', 'unique_video_view_15_sec', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (571, 'adset-insight', 'updated_time', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (572, 'adset-insight', 'video_10_sec_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (573, 'adset-insight', 'video_15_sec_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (574, 'adset-insight', 'video_30_sec_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (112, 'adset', 'status', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (113, 'adset', 'targeting', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (116, 'adset', 'updated_time', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (577, 'adset-insight', 'video_avg_time_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (561, 'adset-insight', 'unique_conversions', 'N', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (119, 'adset', 'date_format', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (120, 'adset', 'execution_options', 'Y', '2019-06-20 23:24:37.763123');
INSERT INTO "public"."field_configuration" VALUES (124, 'ad-insight', 'account_currency', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (125, 'ad-insight', 'account_id', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (126, 'ad-insight', 'account_name', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (127, 'ad-insight', 'action_values', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (128, 'ad-insight', 'actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (129, 'ad-insight', 'ad_click_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (130, 'ad-insight', 'ad_id', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (131, 'ad-insight', 'ad_impression_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (132, 'ad-insight', 'ad_name', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (133, 'ad-insight', 'adset_id', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (134, 'ad-insight', 'adset_name', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (135, 'ad-insight', 'age_targeting', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (136, 'ad-insight', 'auction_bid', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (137, 'ad-insight', 'auction_competitiveness', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (138, 'ad-insight', 'auction_max_competitor_bid', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (139, 'ad-insight', 'buying_type', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (140, 'ad-insight', 'campaign_id', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (141, 'ad-insight', 'campaign_name', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (142, 'ad-insight', 'canvas_avg_view_percent', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (143, 'ad-insight', 'canvas_avg_view_time', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (144, 'ad-insight', 'clicks', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (145, 'ad-insight', 'conversion_values', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (146, 'ad-insight', 'conversions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (147, 'ad-insight', 'cost_per_10_sec_video_view', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (148, 'ad-insight', 'cost_per_15_sec_video_view', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (149, 'ad-insight', 'cost_per_2_sec_continuous_video_view', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (150, 'ad-insight', 'cost_per_action_type', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (151, 'ad-insight', 'cost_per_ad_click', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (152, 'ad-insight', 'cost_per_conversion', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (153, 'ad-insight', 'cost_per_dda_countby_convs', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (154, 'ad-insight', 'cost_per_estimated_ad_recallers', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (155, 'ad-insight', 'cost_per_inline_link_click', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (156, 'ad-insight', 'cost_per_inline_post_engagement', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (157, 'ad-insight', 'cost_per_one_thousand_ad_impression', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (158, 'ad-insight', 'cost_per_outbound_click', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (159, 'ad-insight', 'cost_per_thruplay', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (160, 'ad-insight', 'cost_per_unique_action_type', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (161, 'ad-insight', 'cost_per_unique_click', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (162, 'ad-insight', 'cpc', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (163, 'ad-insight', 'cpm', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (164, 'ad-insight', 'cpp', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (165, 'ad-insight', 'created_time', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (166, 'ad-insight', 'ctr', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (167, 'ad-insight', 'date_start', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (168, 'ad-insight', 'date_stop', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (169, 'ad-insight', 'dda_countby_convs', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (170, 'ad-insight', 'estimated_ad_recall_rate', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (171, 'ad-insight', 'estimated_ad_recall_rate_lower_bound', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (172, 'ad-insight', 'estimated_ad_recall_rate_upper_bound', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (173, 'ad-insight', 'estimated_ad_recallers', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (174, 'ad-insight', 'estimated_ad_recallers_lower_bound', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (175, 'ad-insight', 'estimated_ad_recallers_upper_bound', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (176, 'ad-insight', 'frequency', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (177, 'ad-insight', 'gender_targeting', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (178, 'ad-insight', 'impressions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (179, 'ad-insight', 'inline_link_click_ctr', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (180, 'ad-insight', 'inline_link_clicks', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (181, 'ad-insight', 'inline_post_engagement', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (182, 'ad-insight', 'location', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (183, 'ad-insight', 'mobile_app_purchase_roas', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (184, 'ad-insight', 'objective', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (185, 'ad-insight', 'outbound_clicks', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (186, 'ad-insight', 'outbound_clicks_ctr', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (187, 'ad-insight', 'place_page_name', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (188, 'ad-insight', 'purchase_roas', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (189, 'ad-insight', 'reach', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (190, 'ad-insight', 'relevance_score', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (191, 'ad-insight', 'social_spend', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (192, 'ad-insight', 'spend', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (193, 'ad-insight', 'unique_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (194, 'ad-insight', 'unique_clicks', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (195, 'ad-insight', 'unique_ctr', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (196, 'ad-insight', 'unique_inline_link_click_ctr', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (197, 'ad-insight', 'unique_inline_link_clicks', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (198, 'ad-insight', 'unique_link_clicks_ctr', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (199, 'ad-insight', 'unique_outbound_clicks', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (200, 'ad-insight', 'unique_outbound_clicks_ctr', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (201, 'ad-insight', 'unique_video_continuous_2_sec_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (202, 'ad-insight', 'unique_video_view_10_sec', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (203, 'ad-insight', 'unique_video_view_15_sec', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (204, 'ad-insight', 'updated_time', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (205, 'ad-insight', 'video_10_sec_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (206, 'ad-insight', 'video_15_sec_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (207, 'ad-insight', 'video_30_sec_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (209, 'ad-insight', 'video_avg_time_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (210, 'ad-insight', 'video_continuous_2_sec_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (211, 'ad-insight', 'video_p100_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (212, 'ad-insight', 'video_p25_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (213, 'ad-insight', 'video_p50_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (214, 'ad-insight', 'video_p75_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (216, 'ad-insight', 'video_play_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (217, 'ad-insight', 'video_play_curve_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (218, 'ad-insight', 'video_play_retention_0_to_15s_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (219, 'ad-insight', 'video_play_retention_20_to_60s_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (220, 'ad-insight', 'video_play_retention_graph_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (221, 'ad-insight', 'video_thruplay_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (222, 'ad-insight', 'video_time_watched_actions', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (223, 'ad-insight', 'website_ctr', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (224, 'ad-insight', 'website_purchase_roas', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (225, 'ad-insight', 'wish_bid', 'Y', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (226, 'ad', 'account_id', 'Y', '2019-06-21 01:22:22.786795');
INSERT INTO "public"."field_configuration" VALUES (227, 'ad', 'created_time', 'Y', '2019-06-21 01:22:22.786795');
INSERT INTO "public"."field_configuration" VALUES (228, 'ad', 'id', 'Y', '2019-06-21 01:22:22.786795');
INSERT INTO "public"."field_configuration" VALUES (229, 'ad', 'name', 'Y', '2019-06-21 01:22:22.786795');
INSERT INTO "public"."field_configuration" VALUES (230, 'campaing-insight', 'account_currency', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (231, 'campaing-insight', 'account_id', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (232, 'campaing-insight', 'account_name', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (233, 'campaing-insight', 'action_values', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (234, 'campaing-insight', 'actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (458, 'campaing', 'id', 'Y', '2019-06-23 22:43:08.401603');
INSERT INTO "public"."field_configuration" VALUES (236, 'campaing-insight', 'ad_click_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (578, 'adset-insight', 'video_continuous_2_sec_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (238, 'campaing-insight', 'ad_id', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (239, 'campaing-insight', 'ad_impression_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (240, 'campaing-insight', 'ad_name', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (241, 'campaing-insight', 'adset_id', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (242, 'campaing-insight', 'adset_name', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (273, 'campaing-insight', 'cost_per_unique_conversion', 'N', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (244, 'campaing-insight', 'age_targeting', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (245, 'campaing-insight', 'auction_bid', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (246, 'campaing-insight', 'auction_competitiveness', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (247, 'campaing-insight', 'auction_max_competitor_bid', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (304, 'campaing-insight', 'impressions_dummy', 'N', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (249, 'campaing-insight', 'buying_type', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (332, 'campaing-insight', 'unique_conversions', 'N', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (251, 'campaing-insight', 'campaign_id', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (252, 'campaing-insight', 'campaign_name', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (253, 'campaing-insight', 'canvas_avg_view_percent', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (254, 'campaing-insight', 'canvas_avg_view_time', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (255, 'campaing-insight', 'clicks', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (256, 'campaing-insight', 'conversion_values', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (257, 'campaing-insight', 'conversions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (215, 'ad-insight', 'video_p95_watched_actions', 'N', '2019-06-21 01:03:16.074986');
INSERT INTO "public"."field_configuration" VALUES (258, 'campaing-insight', 'cost_per_10_sec_video_view', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (259, 'campaing-insight', 'cost_per_15_sec_video_view', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (260, 'campaing-insight', 'cost_per_2_sec_continuous_video_view', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (261, 'campaing-insight', 'cost_per_action_type', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (262, 'campaing-insight', 'cost_per_ad_click', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (263, 'campaing-insight', 'cost_per_conversion', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (264, 'campaing-insight', 'cost_per_dda_countby_convs', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (265, 'campaing-insight', 'cost_per_estimated_ad_recallers', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (266, 'campaing-insight', 'cost_per_inline_link_click', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (267, 'campaing-insight', 'cost_per_inline_post_engagement', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (268, 'campaing-insight', 'cost_per_one_thousand_ad_impression', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (269, 'campaing-insight', 'cost_per_outbound_click', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (270, 'campaing-insight', 'cost_per_thruplay', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (271, 'campaing-insight', 'cost_per_unique_action_type', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (272, 'campaing-insight', 'cost_per_unique_click', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (274, 'campaing-insight', 'cost_per_unique_inline_link_click', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (275, 'campaing-insight', 'cost_per_unique_outbound_click', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (459, 'adset-insight', 'account_currency', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (277, 'campaing-insight', 'cpc', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (278, 'campaing-insight', 'cpm', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (279, 'campaing-insight', 'cpp', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (280, 'campaing-insight', 'created_time', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (460, 'adset-insight', 'account_id', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (282, 'campaing-insight', 'ctr', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (283, 'campaing-insight', 'date_start', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (284, 'campaing-insight', 'date_stop', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (285, 'campaing-insight', 'dda_countby_convs', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (461, 'adset-insight', 'account_name', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (462, 'adset-insight', 'action_values', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (463, 'adset-insight', 'actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (289, 'campaing-insight', 'estimated_ad_recall_rate', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (290, 'campaing-insight', 'estimated_ad_recall_rate_lower_bound', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (291, 'campaing-insight', 'estimated_ad_recall_rate_upper_bound', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (292, 'campaing-insight', 'estimated_ad_recallers', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (293, 'campaing-insight', 'estimated_ad_recallers_lower_bound', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (294, 'campaing-insight', 'estimated_ad_recallers_upper_bound', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (295, 'campaing-insight', 'frequency', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (465, 'adset-insight', 'ad_click_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (298, 'campaing-insight', 'gender_targeting', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (467, 'adset-insight', 'ad_id', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (468, 'adset-insight', 'ad_impression_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (469, 'adset-insight', 'ad_name', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (303, 'campaing-insight', 'impressions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (305, 'campaing-insight', 'inline_link_click_ctr', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (306, 'campaing-insight', 'inline_link_clicks', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (307, 'campaing-insight', 'inline_post_engagement', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (308, 'campaing-insight', 'labels', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (470, 'adset-insight', 'adset_id', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (310, 'campaing-insight', 'location', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (471, 'adset-insight', 'adset_name', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (312, 'campaing-insight', 'mobile_app_purchase_roas', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (313, 'campaing-insight', 'objective', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (314, 'campaing-insight', 'outbound_clicks', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (315, 'campaing-insight', 'outbound_clicks_ctr', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (317, 'campaing-insight', 'place_page_name', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (473, 'adset-insight', 'age_targeting', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (322, 'campaing-insight', 'purchase_roas', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (323, 'campaing-insight', 'reach', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (325, 'campaing-insight', 'relevance_score', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (478, 'adset-insight', 'buying_type', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (327, 'campaing-insight', 'social_spend', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (328, 'campaing-insight', 'spend', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (330, 'campaing-insight', 'unique_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (331, 'campaing-insight', 'unique_clicks', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (333, 'campaing-insight', 'unique_ctr', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (334, 'campaing-insight', 'unique_inline_link_click_ctr', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (480, 'adset-insight', 'campaign_id', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (335, 'campaing-insight', 'unique_inline_link_clicks', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (336, 'campaing-insight', 'unique_link_clicks_ctr', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (337, 'campaing-insight', 'unique_outbound_clicks', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (338, 'campaing-insight', 'unique_outbound_clicks_ctr', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (339, 'campaing-insight', 'unique_video_continuous_2_sec_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (340, 'campaing-insight', 'unique_video_view_10_sec', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (341, 'campaing-insight', 'unique_video_view_15_sec', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (342, 'campaing-insight', 'updated_time', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (343, 'campaing-insight', 'video_10_sec_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (344, 'campaing-insight', 'video_15_sec_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (345, 'campaing-insight', 'video_30_sec_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (481, 'adset-insight', 'campaign_name', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (348, 'campaing-insight', 'video_avg_time_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (349, 'campaing-insight', 'video_continuous_2_sec_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (350, 'campaing-insight', 'video_p100_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (351, 'campaing-insight', 'video_p25_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (352, 'campaing-insight', 'video_p50_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (353, 'campaing-insight', 'video_p75_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (355, 'campaing-insight', 'video_play_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (356, 'campaing-insight', 'video_play_curve_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (357, 'campaing-insight', 'video_play_retention_0_to_15s_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (358, 'campaing-insight', 'video_play_retention_20_to_60s_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (359, 'campaing-insight', 'video_play_retention_graph_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (360, 'campaing-insight', 'video_thruplay_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (361, 'campaing-insight', 'video_time_watched_actions', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (362, 'campaing-insight', 'website_ctr', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (363, 'campaing-insight', 'website_purchase_roas', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (347, 'campaing-insight', 'video_avg_percent_watched_actions', 'N', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (364, 'campaing-insight', 'wish_bid', 'Y', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (482, 'adset-insight', 'canvas_avg_view_percent', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (483, 'adset-insight', 'canvas_avg_view_time', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (484, 'adset-insight', 'clicks', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (485, 'adset-insight', 'conversion_values', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (486, 'adset-insight', 'conversions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (487, 'adset-insight', 'cost_per_10_sec_video_view', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (488, 'adset-insight', 'cost_per_15_sec_video_view', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (489, 'adset-insight', 'cost_per_2_sec_continuous_video_view', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (490, 'adset-insight', 'cost_per_action_type', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (491, 'adset-insight', 'cost_per_ad_click', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (492, 'adset-insight', 'cost_per_conversion', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (493, 'adset-insight', 'cost_per_dda_countby_convs', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (494, 'adset-insight', 'cost_per_estimated_ad_recallers', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (495, 'adset-insight', 'cost_per_inline_link_click', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (496, 'adset-insight', 'cost_per_inline_post_engagement', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (497, 'adset-insight', 'cost_per_one_thousand_ad_impression', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (498, 'adset-insight', 'cost_per_outbound_click', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (499, 'adset-insight', 'cost_per_thruplay', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (500, 'adset-insight', 'cost_per_unique_action_type', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (501, 'adset-insight', 'cost_per_unique_click', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (503, 'adset-insight', 'cost_per_unique_inline_link_click', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (504, 'adset-insight', 'cost_per_unique_outbound_click', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (506, 'adset-insight', 'cpc', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (507, 'adset-insight', 'cpm', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (508, 'adset-insight', 'cpp', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (509, 'adset-insight', 'created_time', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (511, 'adset-insight', 'ctr', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (512, 'adset-insight', 'date_start', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (513, 'adset-insight', 'date_stop', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (514, 'adset-insight', 'dda_countby_convs', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (518, 'adset-insight', 'estimated_ad_recall_rate', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (519, 'adset-insight', 'estimated_ad_recall_rate_lower_bound', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (520, 'adset-insight', 'estimated_ad_recall_rate_upper_bound', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (521, 'adset-insight', 'estimated_ad_recallers', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (522, 'adset-insight', 'estimated_ad_recallers_lower_bound', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (523, 'adset-insight', 'estimated_ad_recallers_upper_bound', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (524, 'adset-insight', 'frequency', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (527, 'adset-insight', 'gender_targeting', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (532, 'adset-insight', 'impressions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (534, 'adset-insight', 'inline_link_click_ctr', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (535, 'adset-insight', 'inline_link_clicks', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (536, 'adset-insight', 'inline_post_engagement', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (537, 'adset-insight', 'labels', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (539, 'adset-insight', 'location', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (541, 'adset-insight', 'mobile_app_purchase_roas', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (542, 'adset-insight', 'objective', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (543, 'adset-insight', 'outbound_clicks', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (502, 'adset-insight', 'cost_per_unique_conversion', 'N', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (533, 'adset-insight', 'impressions_dummy', 'N', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (579, 'adset-insight', 'video_p100_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (580, 'adset-insight', 'video_p25_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (581, 'adset-insight', 'video_p50_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (582, 'adset-insight', 'video_p75_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (584, 'adset-insight', 'video_play_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (585, 'adset-insight', 'video_play_curve_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (586, 'adset-insight', 'video_play_retention_0_to_15s_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (587, 'adset-insight', 'video_play_retention_20_to_60s_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (588, 'adset-insight', 'video_play_retention_graph_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (589, 'adset-insight', 'video_thruplay_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (590, 'adset-insight', 'video_time_watched_actions', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (591, 'adset-insight', 'website_ctr', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (592, 'adset-insight', 'website_purchase_roas', 'Y', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (576, 'adset-insight', 'video_avg_percent_watched_actions', 'N', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (354, 'campaing-insight', 'video_p95_watched_actions', 'N', '2019-06-23 22:06:45.268335');
INSERT INTO "public"."field_configuration" VALUES (583, 'adset-insight', 'video_p95_watched_actions', 'N', '2019-06-25 19:57:34.193263');
INSERT INTO "public"."field_configuration" VALUES (208, 'ad-insight', 'video_avg_percent_watched_actions', 'N', '2019-06-21 01:03:16.074986');
COMMIT;

-- ----------------------------
-- Table structure for insight
-- ----------------------------
DROP TABLE IF EXISTS "public"."insight";
CREATE TABLE "public"."insight" (
  "id_insight" int4 NOT NULL DEFAULT nextval('insight_seq'::regclass),
  "id_breakdown_configuration" int4,
  "breakdown_name" text COLLATE "pg_catalog"."default",
  "breakdown_value" text COLLATE "pg_catalog"."default",
  "level_insight" text COLLATE "pg_catalog"."default" NOT NULL,
  "account_currency" text COLLATE "pg_catalog"."default",
  "account_id" text COLLATE "pg_catalog"."default",
  "account_name" text COLLATE "pg_catalog"."default",
  "action_values" json,
  "actions" json,
  "activity_recency" text COLLATE "pg_catalog"."default",
  "ad_click_actions" text COLLATE "pg_catalog"."default",
  "ad_format_asset" json,
  "ad_id" text COLLATE "pg_catalog"."default",
  "ad_impression_actions" text COLLATE "pg_catalog"."default",
  "ad_name" text COLLATE "pg_catalog"."default",
  "adset_id" text COLLATE "pg_catalog"."default",
  "adset_name" text COLLATE "pg_catalog"."default",
  "age" json,
  "age_targeting" text COLLATE "pg_catalog"."default",
  "auction_bid" text COLLATE "pg_catalog"."default",
  "auction_competitiveness" text COLLATE "pg_catalog"."default",
  "auction_max_competitor_bid" text COLLATE "pg_catalog"."default",
  "body_asset" json,
  "buying_type" text COLLATE "pg_catalog"."default",
  "call_to_action_asset" json,
  "campaign_id" text COLLATE "pg_catalog"."default",
  "campaign_name" text COLLATE "pg_catalog"."default",
  "canvas_avg_view_percent" text COLLATE "pg_catalog"."default",
  "canvas_avg_view_time" text COLLATE "pg_catalog"."default",
  "clicks" text COLLATE "pg_catalog"."default",
  "conversion_values" text COLLATE "pg_catalog"."default",
  "conversions" text COLLATE "pg_catalog"."default",
  "cost_per_10_sec_video_view" json,
  "cost_per_15_sec_video_view" json,
  "cost_per_2_sec_continuous_video_view" json,
  "cost_per_action_type" json,
  "cost_per_ad_click" text COLLATE "pg_catalog"."default",
  "cost_per_conversion" text COLLATE "pg_catalog"."default",
  "cost_per_dda_countby_convs" text COLLATE "pg_catalog"."default",
  "cost_per_estimated_ad_recallers" text COLLATE "pg_catalog"."default",
  "cost_per_inline_link_click" text COLLATE "pg_catalog"."default",
  "cost_per_inline_post_engagement" text COLLATE "pg_catalog"."default",
  "cost_per_one_thousand_ad_impression" text COLLATE "pg_catalog"."default",
  "cost_per_outbound_click" json,
  "cost_per_thruplay" json,
  "cost_per_unique_action_type" json,
  "cost_per_unique_click" text COLLATE "pg_catalog"."default",
  "country" json,
  "cpc" text COLLATE "pg_catalog"."default",
  "cpm" text COLLATE "pg_catalog"."default",
  "cpp" text COLLATE "pg_catalog"."default",
  "created_time" text COLLATE "pg_catalog"."default",
  "ctr" text COLLATE "pg_catalog"."default",
  "date_start" text COLLATE "pg_catalog"."default",
  "date_stop" text COLLATE "pg_catalog"."default",
  "dda_countby_convs" text COLLATE "pg_catalog"."default",
  "description_asset" json,
  "device_platform" json,
  "dma" json,
  "estimated_ad_recall_rate" text COLLATE "pg_catalog"."default",
  "estimated_ad_recall_rate_lower_bound" text COLLATE "pg_catalog"."default",
  "estimated_ad_recall_rate_upper_bound" text COLLATE "pg_catalog"."default",
  "estimated_ad_recallers" text COLLATE "pg_catalog"."default",
  "estimated_ad_recallers_lower_bound" text COLLATE "pg_catalog"."default",
  "estimated_ad_recallers_upper_bound" text COLLATE "pg_catalog"."default",
  "frequency" text COLLATE "pg_catalog"."default",
  "frequency_value" json,
  "gender" json,
  "gender_targeting" text COLLATE "pg_catalog"."default",
  "hourly_stats_aggregated_by_advertiser_time_zone" json,
  "hourly_stats_aggregated_by_audience_time_zone" json,
  "image_asset" json,
  "impression_device" json,
  "impressions" text COLLATE "pg_catalog"."default",
  "inline_link_click_ctr" text COLLATE "pg_catalog"."default",
  "inline_link_clicks" text COLLATE "pg_catalog"."default",
  "inline_post_engagement" text COLLATE "pg_catalog"."default",
  "link_url_asset" json,
  "location_data" text COLLATE "pg_catalog"."default",
  "mobile_app_purchase_roas" text COLLATE "pg_catalog"."default",
  "objective" text COLLATE "pg_catalog"."default",
  "outbound_clicks" json,
  "outbound_clicks_ctr" json,
  "place_page_id" json,
  "place_page_name" text COLLATE "pg_catalog"."default",
  "product_id" json,
  "publisher_platform" json,
  "purchase_roas" text COLLATE "pg_catalog"."default",
  "reach" text COLLATE "pg_catalog"."default",
  "region" json,
  "relevance_score" json,
  "reporting_ends" text COLLATE "pg_catalog"."default",
  "reporting_starts" text COLLATE "pg_catalog"."default",
  "social_spend" text COLLATE "pg_catalog"."default",
  "spend" text COLLATE "pg_catalog"."default",
  "title_asset" json,
  "unique_actions" json,
  "unique_clicks" text COLLATE "pg_catalog"."default",
  "unique_ctr" text COLLATE "pg_catalog"."default",
  "unique_inline_link_click_ctr" text COLLATE "pg_catalog"."default",
  "unique_inline_link_clicks" text COLLATE "pg_catalog"."default",
  "unique_link_clicks_ctr" text COLLATE "pg_catalog"."default",
  "unique_outbound_clicks" json,
  "unique_outbound_clicks_ctr" json,
  "unique_video_continuous_2_sec_watched_actions" json,
  "unique_video_view_10_sec" json,
  "unique_video_view_15_sec" json,
  "updated_time" text COLLATE "pg_catalog"."default",
  "video_10_sec_watched_actions" json,
  "video_15_sec_watched_actions" json,
  "video_30_sec_watched_actions" json,
  "video_asset" json,
  "video_avg_percent_watched_actions" json,
  "video_avg_time_watched_actions" json,
  "video_continuous_2_sec_watched_actions" json,
  "video_p100_watched_actions" json,
  "video_p25_watched_actions" json,
  "video_p50_watched_actions" json,
  "video_p75_watched_actions" json,
  "video_p95_watched_actions" json,
  "video_play_actions" json,
  "video_play_curve_actions" json,
  "video_play_retention_0_to_15s_actions" text COLLATE "pg_catalog"."default",
  "video_play_retention_20_to_60s_actions" text COLLATE "pg_catalog"."default",
  "video_play_retention_graph_actions" text COLLATE "pg_catalog"."default",
  "video_thruplay_watched_actions" json,
  "video_time_watched_actions" text COLLATE "pg_catalog"."default",
  "website_ctr" json,
  "website_purchase_roas" text COLLATE "pg_catalog"."default",
  "wish_bid" text COLLATE "pg_catalog"."default",
  "campaing_id" text COLLATE "pg_catalog"."default",
  "cost_per_unique_inline_link_click" json,
  "cost_per_unique_outbound_click" json,
  "date_consult" timestamptz(6),
  "time_increment" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."insight" OWNER TO "postgres";

-- ----------------------------
-- Table structure for platform
-- ----------------------------
DROP TABLE IF EXISTS "public"."platform";
CREATE TABLE "public"."platform" (
  "id_platform" int4 NOT NULL DEFAULT nextval('platform_seq'::regclass),
  "platform" text COLLATE "pg_catalog"."default",
  "platform_short" text COLLATE "pg_catalog"."default",
  "platform_status" "public"."active_status",
  "date" timestamptz(6)
)
;
ALTER TABLE "public"."platform" OWNER TO "postgres";

-- ----------------------------
-- Records of platform
-- ----------------------------
BEGIN;
INSERT INTO "public"."platform" VALUES (1, 'BUSINESS MANAGER', 'FBM', 'Y', '2019-09-15 18:42:05-05');
COMMIT;

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS "public"."token";
CREATE TABLE "public"."token" (
  "id_token" int4 NOT NULL DEFAULT nextval('token_seq'::regclass),
  "app_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "app_secret" text COLLATE "pg_catalog"."default" NOT NULL,
  "access_token" text COLLATE "pg_catalog"."default" NOT NULL,
  "token_name" text COLLATE "pg_catalog"."default" NOT NULL,
  "business_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "date_created" timestamp(6) DEFAULT now(),
  "date_expiration" timestamp(6),
  "since" date,
  "until" date,
  "period" text COLLATE "pg_catalog"."default",
  "breakdown" "public"."active_status",
  "increment" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."token" OWNER TO "postgres";

-- ----------------------------
-- Records of token
-- ----------------------------
BEGIN;
INSERT INTO "public"."token" VALUES (1, '314693332729550', 'a1ef00d12efc1e3a12fa01803980b645', 'EAAEeNkBPfs4BAAWcJN5qhV7p0xnZA5S7XiP1C2ciGR9llI4K9TXLqlHjZCZCkPZAZBZCRxCgMkhyZAoK1ZCVKfOA8LXw2xHLLCgvZB627ZC5XcdYloIgEZAjf3kNfMSQCeXFwIlAqekkZB2wcRkkfTvgJALiEAkRNA0v4tawJq1W4ZAvopQZDZD', 'default', '275139826019364', '2019-06-20 00:47:31.644228', NULL, '2019-09-10', '2019-09-10', NULL, 'N', 'all_days');
COMMIT;

-- ----------------------------
-- View structure for view_campaign
-- ----------------------------
DROP VIEW IF EXISTS "public"."view_campaign";
CREATE VIEW "public"."view_campaign" AS  SELECT platform.platform,
    platform.id_platform,
    campaing.campaing_id,
    campaing.account_id,
    insight.breakdown_name,
    insight.breakdown_value,
    insight.level_insight,
    insight.account_currency,
    insight.account_id AS account_id_0,
    insight.account_name,
    insight.action_values,
    insight.actions,
    insight.activity_recency,
    insight.age,
    insight.age_targeting,
    insight.auction_bid,
    insight.auction_competitiveness,
    insight.auction_max_competitor_bid,
    insight.body_asset,
    insight.buying_type,
    insight.call_to_action_asset,
    insight.campaign_id,
    insight.campaign_name,
    insight.canvas_avg_view_percent,
    insight.canvas_avg_view_time,
    insight.clicks,
    insight.conversion_values,
    insight.conversions,
    insight.cost_per_10_sec_video_view,
    insight.cost_per_15_sec_video_view,
    insight.cost_per_2_sec_continuous_video_view,
    insight.cost_per_action_type,
    insight.cost_per_ad_click,
    insight.cost_per_conversion,
    insight.cost_per_dda_countby_convs,
    insight.cost_per_estimated_ad_recallers,
    insight.cost_per_inline_link_click,
    insight.cost_per_inline_post_engagement,
    insight.cost_per_one_thousand_ad_impression,
    insight.cost_per_outbound_click,
    insight.cost_per_thruplay,
    insight.cost_per_unique_action_type,
    insight.cost_per_unique_click,
    insight.country,
    insight.cpc,
    insight.cpm,
    insight.cpp,
    insight.created_time,
    insight.ctr,
    insight.date_start,
    insight.date_stop,
    insight.dda_countby_convs,
    insight.description_asset,
    insight.device_platform,
    insight.dma,
    insight.estimated_ad_recall_rate,
    insight.estimated_ad_recall_rate_lower_bound,
    insight.estimated_ad_recall_rate_upper_bound,
    insight.estimated_ad_recallers,
    insight.estimated_ad_recallers_lower_bound,
    insight.estimated_ad_recallers_upper_bound,
    insight.frequency,
    insight.frequency_value,
    insight.gender,
    insight.gender_targeting,
    insight.hourly_stats_aggregated_by_advertiser_time_zone,
    insight.hourly_stats_aggregated_by_audience_time_zone,
    insight.image_asset,
    insight.impression_device,
    insight.impressions,
    insight.inline_link_click_ctr,
    insight.inline_link_clicks,
    insight.inline_post_engagement,
    insight.link_url_asset,
    insight.location_data,
    insight.mobile_app_purchase_roas,
    insight.objective,
    insight.outbound_clicks,
    insight.outbound_clicks_ctr,
    insight.place_page_id,
    insight.place_page_name,
    insight.product_id,
    insight.publisher_platform,
    insight.purchase_roas,
    insight.reach,
    insight.region,
    insight.relevance_score,
    insight.reporting_ends,
    insight.reporting_starts,
    insight.social_spend,
    insight.spend,
    insight.title_asset,
    insight.unique_actions,
    insight.unique_clicks,
    insight.unique_ctr,
    insight.unique_inline_link_click_ctr,
    insight.unique_inline_link_clicks,
    insight.unique_link_clicks_ctr,
    insight.unique_outbound_clicks,
    insight.unique_outbound_clicks_ctr,
    insight.unique_video_continuous_2_sec_watched_actions,
    insight.unique_video_view_10_sec,
    insight.unique_video_view_15_sec,
    insight.updated_time,
    insight.video_10_sec_watched_actions,
    insight.video_15_sec_watched_actions,
    insight.video_30_sec_watched_actions,
    insight.video_asset,
    insight.video_avg_percent_watched_actions,
    insight.video_avg_time_watched_actions,
    insight.video_continuous_2_sec_watched_actions,
    insight.video_p100_watched_actions,
    insight.video_p25_watched_actions,
    insight.video_p50_watched_actions,
    insight.video_p75_watched_actions,
    insight.video_p95_watched_actions,
    insight.video_play_actions,
    insight.video_play_curve_actions,
    insight.video_play_retention_0_to_15s_actions,
    insight.video_play_retention_20_to_60s_actions,
    insight.video_play_retention_graph_actions,
    insight.video_thruplay_watched_actions,
    insight.video_time_watched_actions,
    insight.website_ctr,
    insight.website_purchase_roas,
    insight.wish_bid,
    insight.campaing_id AS campaing_id_0,
    insight.cost_per_unique_inline_link_click,
    insight.cost_per_unique_outbound_click,
    insight.date_consult,
    insight.id_insight
   FROM ((platform
     JOIN campaing ON ((platform.id_platform = campaing.id_platform)))
     JOIN insight ON ((campaing.campaing_id = insight.campaign_id)))
  WHERE (insight.level_insight = 'campaign'::text);
ALTER TABLE "public"."view_campaign" OWNER TO "postgres";
COMMENT ON VIEW "public"."view_campaign" IS 'This view has the campaign data';

-- ----------------------------
-- View structure for view_adset
-- ----------------------------
DROP VIEW IF EXISTS "public"."view_adset";
CREATE VIEW "public"."view_adset" AS  SELECT platform.platform,
    adset.name,
    adset.targeting,
    adset.status,
    insight.adset_name,
    insight.age,
    insight.actions,
    insight.account_id,
    insight.account_name,
    insight.action_values,
    insight.level_insight,
    insight.breakdown_value,
    insight.breakdown_name,
    insight.age_targeting,
    insight.auction_bid,
    insight.auction_competitiveness,
    insight.auction_max_competitor_bid,
    insight.body_asset,
    insight.buying_type,
    insight.call_to_action_asset,
    insight.campaign_id,
    insight.campaign_name,
    insight.canvas_avg_view_percent,
    insight.canvas_avg_view_time,
    insight.clicks,
    insight.conversion_values,
    insight.conversions,
    insight.cost_per_10_sec_video_view,
    insight.cost_per_15_sec_video_view,
    insight.cost_per_2_sec_continuous_video_view,
    insight.cost_per_action_type,
    insight.cost_per_ad_click,
    insight.cost_per_conversion,
    insight.cost_per_dda_countby_convs,
    insight.cost_per_estimated_ad_recallers,
    insight.cost_per_inline_link_click,
    insight.cost_per_inline_post_engagement,
    insight.cost_per_one_thousand_ad_impression,
    insight.cost_per_outbound_click,
    insight.cost_per_thruplay,
    insight.cost_per_unique_action_type,
    insight.cost_per_unique_click,
    insight.country,
    insight.cpm,
    insight.cpc,
    insight.cpp,
    insight.created_time,
    insight.ctr,
    insight.date_start,
    insight.date_stop,
    insight.dda_countby_convs,
    insight.description_asset,
    insight.device_platform,
    insight.estimated_ad_recall_rate,
    insight.dma,
    insight.estimated_ad_recall_rate_lower_bound,
    insight.estimated_ad_recall_rate_upper_bound,
    insight.estimated_ad_recallers,
    insight.estimated_ad_recallers_lower_bound,
    insight.estimated_ad_recallers_upper_bound,
    insight.frequency,
    insight.frequency_value,
    insight.gender,
    insight.gender_targeting,
    insight.hourly_stats_aggregated_by_advertiser_time_zone,
    insight.hourly_stats_aggregated_by_audience_time_zone,
    insight.image_asset,
    insight.impression_device,
    insight.impressions,
    insight.inline_link_click_ctr,
    insight.inline_link_clicks,
    insight.inline_post_engagement,
    insight.link_url_asset,
    insight.location_data,
    insight.mobile_app_purchase_roas,
    insight.objective,
    insight.outbound_clicks,
    insight.outbound_clicks_ctr,
    insight.place_page_id,
    insight.place_page_name,
    insight.product_id,
    insight.publisher_platform,
    insight.purchase_roas,
    insight.reach,
    insight.region,
    insight.relevance_score,
    insight.reporting_ends,
    insight.social_spend,
    insight.reporting_starts,
    insight.spend,
    insight.title_asset,
    insight.unique_actions,
    insight.unique_clicks,
    insight.unique_ctr,
    insight.unique_inline_link_click_ctr,
    insight.unique_inline_link_clicks,
    insight.unique_link_clicks_ctr,
    insight.unique_outbound_clicks,
    insight.unique_outbound_clicks_ctr,
    insight.unique_video_continuous_2_sec_watched_actions,
    insight.unique_video_view_10_sec,
    insight.unique_video_view_15_sec,
    insight.updated_time,
    insight.video_10_sec_watched_actions,
    insight.video_30_sec_watched_actions,
    insight.video_15_sec_watched_actions,
    insight.video_asset,
    insight.video_avg_percent_watched_actions,
    insight.video_avg_time_watched_actions,
    insight.video_continuous_2_sec_watched_actions,
    insight.video_p100_watched_actions,
    insight.video_p25_watched_actions,
    insight.video_p50_watched_actions,
    insight.video_p75_watched_actions,
    insight.video_p95_watched_actions,
    insight.video_play_actions,
    insight.video_play_curve_actions,
    insight.video_play_retention_0_to_15s_actions,
    insight.video_play_retention_20_to_60s_actions,
    insight.video_play_retention_graph_actions,
    insight.video_thruplay_watched_actions,
    insight.video_time_watched_actions,
    insight.website_ctr,
    insight.website_purchase_roas,
    insight.wish_bid,
    insight.campaing_id,
    insight.cost_per_unique_inline_link_click,
    insight.cost_per_unique_outbound_click
   FROM ((platform
     JOIN adset ON ((platform.id_platform = adset.id_platform)))
     JOIN insight ON ((adset.adset_id = insight.adset_id)))
  WHERE (insight.level_insight = 'adset'::text);
ALTER TABLE "public"."view_adset" OWNER TO "postgres";

-- ----------------------------
-- View structure for view_ad
-- ----------------------------
DROP VIEW IF EXISTS "public"."view_ad";
CREATE VIEW "public"."view_ad" AS  SELECT platform.platform,
    ad.ad_id,
    ad.name,
    ad.read,
    creative.url_post,
    insight.breakdown_name,
    insight.id_breakdown_configuration,
    insight.level_insight,
    insight.account_currency,
    insight.account_id,
    insight.account_name,
    insight.action_values,
    insight.actions,
    insight.activity_recency,
    insight.ad_click_actions,
    insight.ad_format_asset,
    insight.ad_impression_actions,
    insight.ad_name,
    insight.age,
    insight.age_targeting,
    insight.auction_bid,
    insight.auction_competitiveness,
    insight.auction_max_competitor_bid,
    insight.body_asset,
    insight.buying_type,
    insight.call_to_action_asset,
    insight.campaign_id,
    insight.campaign_name,
    insight.canvas_avg_view_percent,
    insight.canvas_avg_view_time,
    insight.clicks,
    insight.conversion_values,
    insight.conversions,
    insight.cost_per_10_sec_video_view,
    insight.cost_per_15_sec_video_view,
    insight.cost_per_2_sec_continuous_video_view,
    insight.cost_per_action_type,
    insight.cost_per_ad_click,
    insight.cost_per_conversion,
    insight.cost_per_inline_link_click,
    insight.cost_per_estimated_ad_recallers,
    insight.cost_per_dda_countby_convs,
    insight.cost_per_inline_post_engagement,
    insight.cost_per_one_thousand_ad_impression,
    insight.cost_per_outbound_click,
    insight.cost_per_thruplay,
    insight.cost_per_unique_action_type,
    insight.cost_per_unique_click,
    insight.country,
    insight.cpc,
    insight.cpm,
    insight.cpp,
    insight.ctr,
    insight.date_start,
    insight.date_stop,
    insight.description_asset,
    insight.dda_countby_convs,
    insight.device_platform,
    insight.dma,
    insight.estimated_ad_recall_rate_lower_bound,
    insight.estimated_ad_recall_rate,
    insight.estimated_ad_recall_rate_upper_bound,
    insight.estimated_ad_recallers,
    insight.estimated_ad_recallers_lower_bound,
    insight.estimated_ad_recallers_upper_bound,
    insight.frequency,
    insight.frequency_value,
    insight.gender,
    insight.gender_targeting,
    insight.hourly_stats_aggregated_by_audience_time_zone,
    insight.hourly_stats_aggregated_by_advertiser_time_zone,
    insight.image_asset,
    insight.impression_device,
    insight.impressions,
    insight.inline_link_click_ctr,
    insight.inline_link_clicks,
    insight.inline_post_engagement,
    insight.link_url_asset,
    insight.location_data,
    insight.mobile_app_purchase_roas,
    insight.objective,
    insight.outbound_clicks,
    insight.outbound_clicks_ctr,
    insight.place_page_id,
    insight.place_page_name,
    insight.product_id,
    insight.publisher_platform,
    insight.purchase_roas,
    insight.reach,
    insight.region,
    insight.relevance_score,
    insight.reporting_ends,
    insight.reporting_starts,
    insight.social_spend,
    insight.spend,
    insight.title_asset,
    insight.unique_actions,
    insight.unique_clicks,
    insight.unique_inline_link_click_ctr,
    insight.unique_ctr,
    insight.unique_inline_link_clicks,
    insight.unique_link_clicks_ctr,
    insight.unique_outbound_clicks,
    insight.unique_outbound_clicks_ctr,
    insight.unique_video_continuous_2_sec_watched_actions,
    insight.unique_video_view_10_sec,
    insight.unique_video_view_15_sec,
    insight.updated_time,
    insight.video_10_sec_watched_actions,
    insight.video_15_sec_watched_actions,
    insight.video_30_sec_watched_actions,
    insight.video_asset,
    insight.video_avg_percent_watched_actions,
    insight.video_avg_time_watched_actions,
    insight.video_continuous_2_sec_watched_actions,
    insight.video_p100_watched_actions,
    insight.video_p25_watched_actions,
    insight.video_p50_watched_actions,
    insight.video_p75_watched_actions,
    insight.video_p95_watched_actions,
    insight.video_play_actions,
    insight.video_play_curve_actions,
    insight.video_play_retention_0_to_15s_actions,
    insight.video_play_retention_20_to_60s_actions,
    insight.video_play_retention_graph_actions,
    insight.video_thruplay_watched_actions,
    insight.video_time_watched_actions,
    insight.website_ctr,
    insight.website_purchase_roas,
    insight.wish_bid,
    insight.cost_per_unique_inline_link_click,
    insight.cost_per_unique_outbound_click
   FROM (((ad
     JOIN creative ON ((ad.ad_id = creative.ad_id)))
     JOIN platform ON ((platform.id_platform = ad.id_platform)))
     JOIN insight ON ((ad.ad_id = insight.ad_id)))
  WHERE (insight.level_insight = 'ad'::text);
ALTER TABLE "public"."view_ad" OWNER TO "postgres";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."account_seq"', 1, true);
SELECT setval('"public"."ad_seq"', 1, true);
SELECT setval('"public"."adset_seq"', 1, true);
SELECT setval('"public"."breakdown_configuration_seq"', 2, false);
SELECT setval('"public"."campaing_seq"', 1, true);
SELECT setval('"public"."creative_seq"', 1, true);
SELECT setval('"public"."field_configuration_seq"', 2, false);
SELECT setval('"public"."insight_seq"', 1, true);
SELECT setval('"public"."platform_seq"', 2, true);
SELECT setval('"public"."task_seq"', 2, false);
SELECT setval('"public"."token_seq"', 2, false);

-- ----------------------------
-- Primary Key structure for table account
-- ----------------------------
ALTER TABLE "public"."account" ADD CONSTRAINT "account_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ad
-- ----------------------------
ALTER TABLE "public"."ad" ADD CONSTRAINT "ad_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."ad" ADD CONSTRAINT unique_ad_id UNIQUE (ad_id);

-- ----------------------------
-- Primary Key structure for table adset
-- ----------------------------
ALTER TABLE "public"."adset" ADD CONSTRAINT "adset_copy1_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table breakdown_configuration
-- ----------------------------
ALTER TABLE "public"."breakdown_configuration" ADD CONSTRAINT "breakdown_configuration_pkey" PRIMARY KEY ("id_breakdown_configuration");

-- ----------------------------
-- Primary Key structure for table campaing
-- ----------------------------
ALTER TABLE "public"."campaing" ADD CONSTRAINT "campaing_pkey" PRIMARY KEY ("id_campaign");

-- ----------------------------
-- Primary Key structure for table creative
-- ----------------------------
ALTER TABLE "public"."creative" ADD CONSTRAINT "creative_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table field_configuration
-- ----------------------------
ALTER TABLE "public"."field_configuration" ADD CONSTRAINT "field_configuration_pkey" PRIMARY KEY ("id_field_configuration");

-- ----------------------------
-- Indexes structure for table insight
-- ----------------------------
CREATE INDEX "fk_insights_breakdown_configuration1_idx" ON "public"."insight" USING btree (
  "id_breakdown_configuration" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table insight
-- ----------------------------
ALTER TABLE "public"."insight" ADD CONSTRAINT "insight_pkey" PRIMARY KEY ("id_insight");

-- ----------------------------
-- Primary Key structure for table platform
-- ----------------------------
ALTER TABLE "public"."platform" ADD CONSTRAINT "platform_pkey" PRIMARY KEY ("id_platform");

-- ----------------------------
-- Primary Key structure for table token
-- ----------------------------
ALTER TABLE "public"."token" ADD CONSTRAINT "token_pkey" PRIMARY KEY ("id_token");

-- ----------------------------
-- Foreign Keys structure for table ad
-- ----------------------------
ALTER TABLE "public"."ad" ADD CONSTRAINT "platform_id" FOREIGN KEY ("id_platform") REFERENCES "public"."platform" ("id_platform") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table adset
-- ----------------------------
ALTER TABLE "public"."adset" ADD CONSTRAINT "adset_copy1_id_platform_fkey" FOREIGN KEY ("id_platform") REFERENCES "public"."platform" ("id_platform") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table campaing
-- ----------------------------
ALTER TABLE "public"."campaing" ADD CONSTRAINT "platform_id" FOREIGN KEY ("id_platform") REFERENCES "public"."platform" ("id_platform") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table insight
-- ----------------------------
ALTER TABLE "public"."insight" ADD CONSTRAINT "fk_insight_breakdown" FOREIGN KEY ("id_breakdown_configuration") REFERENCES "public"."breakdown_configuration" ("id_breakdown_configuration") ON DELETE NO ACTION ON UPDATE NO ACTION;
