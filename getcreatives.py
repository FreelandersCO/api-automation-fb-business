# Import system necesary library
import datetime , sys, json, os, argparse, logging, time
import requests as rq

#Import Helpers
from helpers import getDates, periodToDays , check_limit, superSerialize

from datab import DatabaseOperation

# Import all the facebook mumbo jumbo
from facebook_business.api import FacebookAdsApi
from facebook_business.adobjects.adsinsights import AdsInsights
from facebook_business.adobjects.adaccount import AdAccount
from facebook_business.adobjects.business import Business
from facebook_business.adobjects.adcreative import AdCreative
from facebook_business.adobjects.ad import Ad


class AdsCreativites(object):
    def __init__(self,task_data,account_id):
        super(AdsCreativites).__init__()
        print('Runnig creatives')
        self.database = DatabaseOperation()
        my_app_id = task_data.app_id
        my_app_secret = task_data.app_secret
        my_access_token = task_data.access_token
        business_id = task_data.business_id
        #Fields for creativities
        fields = [
            'account_id',
            'actor_id',
            'adlabels',
            'applink_treatment',
            'asset_feed_spec',
            'authorization_category',
            'auto_update',
            'body',
            'branded_content_sponsor_page_id',
            'bundle_folder_id',
            'call_to_action_type',
            'categorization_criteria',
            'category_media_source',
            'destination_set_id',
            'dynamic_ad_voice',
            'effective_authorization_category',
            'effective_instagram_story_id',
            'effective_object_story_id',
            'enable_direct_install',
            'enable_launch_instant_app',
            'id',
            'image_crops',
            'image_hash',
            'image_url',
            'instagram_actor_id',
            'instagram_permalink_url',
            'instagram_story_id',
            'interactive_components_spec',
            'link_deep_link_url',
            'link_og_id',
            'link_url',
            'messenger_sponsored_message',
            'name',
            'object_id',
            'object_store_url',
            'object_story_id',
            'object_story_spec',
            'object_type',
            'object_url',
            'place_page_set_id',
            'platform_customizations',
            'playable_asset_id',
            'portrait_customizations',
            'product_set_id',
            'recommender_settings',
            'status',
            'template_url',
            'template_url_spec',
            'thumbnail_url',
            'title',
            'url_tags',
            'use_page_actor_override',
            'video_id',
            'image_file',
            'is_dco_internal'
        ]

                #Get ads by task
        ads = self.database.select('ad','read', 'N')
        # print(ads)

        # To keep track of rows added to file
        rows = 0

        for adid in ads:
            creatives = AdAccount(adid['ad_id']).get_ad_creatives(
                fields=fields,
            )
            
            for creative in creatives:
                # print(creative)
                account_id=""
                actor_id=""
                adlabels=""
                applink_treatment=""
                asset_feed_spec=""
                authorization_category=""
                auto_update=""
                body=""
                branded_content_sponsor_page_id=""
                bundle_folder_id=""
                call_to_action_type=""
                categorization_criteria=""
                category_media_source=""
                destination_set_id=""
                dynamic_ad_voice=""
                effective_authorization_category=""
                effective_instagram_story_id=""
                effective_object_story_id=""
                enable_direct_install=""
                enable_launch_instant_app=""
                creative_id=""
                image_crops=""
                image_hash=""
                image_url=""
                instagram_actor_id=""
                instagram_permalink_url=""
                instagram_story_id=""
                interactive_components_spec=""
                link_deep_link_url=""
                link_og_id=""
                link_url=""
                messenger_sponsored_message=""
                name=""
                object_id=""
                object_store_url=""
                object_story_id=""
                object_story_spec=""
                object_type=""
                object_url=""
                place_page_set_id=""
                platform_customizations=""
                playable_asset_id=""
                portrait_customizations=""
                product_set_id=""
                recommender_settings=""
                status=""
                template_url=""
                template_url_spec=""
                thumbnail_url=""
                title=""
                url_tags=""
                use_page_actor_override=""
                video_id=""
                image_file=""
                is_dco_internal=""
                url_post=""

                if 'account_id' in creative:
                    account_id = creative[AdCreative.Field.account_id]
                if 'actor_id' in creative:
                    actor_id=creative[AdCreative.Field.actor_id]
                if 'adlabels' in creative:
                    adlabels=creative[AdCreative.Field.adlabels]
                if 'applink_treatment' in creative:
                    applink_treatment=creative[AdCreative.Field.applink_treatment]
                if 'asset_feed_spec' in creative:
                    asset_feed_spec=creative[AdCreative.Field.asset_feed_spec]
                if 'authorization_category' in creative:
                    authorization_category=creative[AdCreative.Field.authorization_category]
                if 'auto_update' in creative:
                    auto_update=creative[AdCreative.Field.auto_update]
                if 'body' in creative:
                    body=creative[AdCreative.Field.body]
                if 'branded_content_sponsor_page_id' in creative:
                    branded_content_sponsor_page_id=creative[AdCreative.Field.branded_content_sponsor_page_id]
                if 'bundle_folder_id' in creative:
                    bundle_folder_id=creative[AdCreative.Field.bundle_folder_id]
                if 'call_to_action_type' in creative:
                    call_to_action_type=creative[AdCreative.Field.call_to_action_type]
                if 'categorization_criteria' in creative:
                    categorization_criteria=creative[AdCreative.Field.categorization_criteria]
                if 'category_media_source' in creative:
                    category_media_source=creative[AdCreative.Field.category_media_source]
                if 'destination_set_id' in creative:
                    destination_set_id=creative[AdCreative.Field.destination_set_id]
                if 'dynamic_ad_voice' in creative:
                    dynamic_ad_voice=creative[AdCreative.Field.dynamic_ad_voice]
                if 'effective_authorization_category' in creative:
                    effective_authorization_category=creative[AdCreative.Field.effective_authorization_category]
                if 'effective_instagram_story_id' in creative:
                    effective_instagram_story_id=creative[AdCreative.Field.effective_instagram_story_id]
                if 'effective_object_story_id' in creative:
                    effective_object_story_id=creative[AdCreative.Field.effective_object_story_id]
                if 'enable_direct_install' in creative:
                    enable_direct_install=creative[AdCreative.Field.enable_direct_install]
                if 'enable_launch_instant_app' in creative:
                    enable_launch_instant_app=creative[AdCreative.Field.enable_launch_instant_app]
                if 'id' in creative:
                    creative_id=creative[AdCreative.Field.id]
                if 'image_crops' in creative:
                    image_crops=creative[AdCreative.Field.image_crops]
                if 'image_hash' in creative:
                    image_hash=creative[AdCreative.Field.image_hash]
                if 'image_url' in creative:
                    image_url=creative[AdCreative.Field.image_url]
                if 'instagram_actor_id' in creative:
                    instagram_actor_id=creative[AdCreative.Field.instagram_actor_id]
                if 'instagram_permalink_url' in creative:
                    instagram_permalink_url=creative[AdCreative.Field.instagram_permalink_url]
                if 'instagram_story_id' in creative:
                    instagram_story_id=creative[AdCreative.Field.instagram_story_id]
                if 'interactive_components_spec' in creative:
                    interactive_components_spec=creative[AdCreative.Field.interactive_components_spec]
                if 'link_deep_link_url' in creative:
                    link_deep_link_url=creative[AdCreative.Field.link_deep_link_url]
                if 'link_og_id' in creative:
                    link_og_id=creative[AdCreative.Field.link_og_id]
                if 'link_url' in creative:
                    link_url=creative[AdCreative.Field.link_url]
                if 'messenger_sponsored_message' in creative:
                    messenger_sponsored_message=creative[AdCreative.Field.messenger_sponsored_message]
                if 'name' in creative:
                    name=creative[AdCreative.Field.name]
                if 'object_id' in creative:
                    object_id=creative[AdCreative.Field.object_id]
                if 'object_store_url' in creative:
                    object_store_url=creative[AdCreative.Field.object_store_url]
                if 'object_story_id' in creative:
                    object_story_id=creative[AdCreative.Field.object_story_id]
                    object_id_split=object_story_id.split('_')
                    url_post="https://www.facebook.com/"+object_id_split[0]+"/posts/"+object_id_split[1]
                if 'object_story_spec' in creative:
                    object_story_spec=creative[AdCreative.Field.object_story_spec]
                if 'object_type' in creative:
                    object_type=creative[AdCreative.Field.object_type]
                if 'object_url' in creative:
                    object_url=creative[AdCreative.Field.object_url]
                if 'place_page_set_id' in creative:
                    place_page_set_id=creative[AdCreative.Field.place_page_set_id]
                if 'platform_customizations' in creative:
                    platform_customizations=creative[AdCreative.Field.platform_customizations]
                if 'playable_asset_id' in creative:
                    playable_asset_id=creative[AdCreative.Field.playable_asset_id]
                if 'portrait_customizations' in creative:
                    portrait_customizations=creative[AdCreative.Field.portrait_customizations]
                if 'product_set_id' in creative:
                    product_set_id=creative[AdCreative.Field.product_set_id]
                if 'recommender_settings' in creative:
                    recommender_settings=creative[AdCreative.Field.recommender_settings]
                if 'status' in creative:
                    status=creative[AdCreative.Field.status]
                if 'template_url' in creative:
                    template_url=creative[AdCreative.Field.template_url]
                if 'template_url_spec' in creative:
                    template_url_spec=creative[AdCreative.Field.template_url_spec]
                if 'thumbnail_url' in creative:
                    thumbnail_url=creative[AdCreative.Field.thumbnail_url]
                if 'title' in creative:
                    title=creative[AdCreative.Field.title]
                if 'url_tags' in creative:
                    url_tags=creative[AdCreative.Field.url_tags]
                if 'use_page_actor_override' in creative:
                    use_page_actor_override=creative[AdCreative.Field.use_page_actor_override]
                if 'video_id' in creative:
                    video_id=creative[AdCreative.Field.video_id]
                if 'image_file' in creative:
                    image_file=creative[AdCreative.Field.image_file]
                
                creative_data = {
                    'id_ad' : adid['id'],
                    'ad_id' : adid['ad_id'],
                    'actor_id': str(actor_id),
                    'adlabels': str(adlabels),
                    'applink_treatment': str(applink_treatment),
                    'asset_feed_spec': str(asset_feed_spec),
                    'authorization_category': str(authorization_category),
                    'auto_update': str(auto_update),
                    'body':str(body),
                    'branded_content_sponsor_page_id': str(branded_content_sponsor_page_id),
                    'bundle_folder_id': str(bundle_folder_id),
                    'call_to_action_type': str(call_to_action_type),
                    'categorization_criteria': str(categorization_criteria),
                    'category_media_source': str(category_media_source),
                    'destination_set_id': str(destination_set_id),
                    'dynamic_ad_voice': str(dynamic_ad_voice),
                    'effective_authorization_category': str(effective_authorization_category),
                    'effective_instagram_story_id': str(effective_instagram_story_id),
                    'effective_object_story_id': str(effective_object_story_id),
                    'enable_direct_install': str(enable_direct_install),
                    'enable_launch_instant_app': str(enable_launch_instant_app),
                    'creative_id': str(creative_id),
                    'image_crops': str(image_crops),
                    'image_hash': str(image_hash),
                    'image_url': str(image_url),
                    'instagram_actor_id': str(instagram_actor_id),
                    'instagram_permalink_url': str(instagram_permalink_url),
                    'instagram_story_id': str(instagram_story_id),
                    'interactive_components_spec': str(interactive_components_spec),
                    'link_deep_link_url': str(link_deep_link_url),
                    'link_og_id': str(link_og_id),
                    'link_url': str(link_url),
                    'messenger_sponsored_message': str(messenger_sponsored_message),
                    'name':str(name),
                    'object_id': str(object_id),
                    'object_store_url': str(object_store_url),
                    'object_story_id': str(object_story_id),
                    'object_story_spec': str(object_story_spec),
                    'object_type': str(object_type),
                    'object_url': str(object_url),
                    'place_page_set_id': str(place_page_set_id),
                    'platform_customizations': str(platform_customizations),
                    'playable_asset_id': str(playable_asset_id),
                    'portrait_customizations': str(portrait_customizations),
                    'product_set_id': str(product_set_id),
                    'recommender_settings': str(recommender_settings),
                    'status': str(status),
                    'template_url': str(template_url),
                    'template_url_spec': str(template_url_spec),
                    'thumbnail_url': str(thumbnail_url),
                    'title':str(title),
                    'url_tags': str(url_tags),
                    'use_page_actor_override': str(use_page_actor_override),
                    'video_id': str(video_id),
                    'image_file': str(image_file),
                    'is_dco_internal': str(is_dco_internal),
                    'url_post':url_post,
                    'created_time':datetime.datetime.now().strftime('%Y-%m-%d %X')
                }
                
                # convert to string
                #creative_data = json.dumps(creative_data)

                self.database.insert('creative',creative_data)
                self.database.update('ad','ad_id',adid['ad_id'],{'read':'Y'})
                rows += 1
                #Check if you reached 75% of the limit, if yes then back-off for 5 minutes (put this chunk in your 'for ad is ads' loop, every 100-200 iterations)
                if (check_limit(account_id,my_access_token)>75):
                    print('75% Rate Limit Reached. Cooling Time 5 Minutes. '+ account_id)
                    logging.debug('75% Rate Limit Reached. Cooling Time 5 Minutes.')
                    time.sleep(300)
                    print('Cooling finish.'+ account_id)
                
                del actor_id
                del adlabels
                del applink_treatment
                del asset_feed_spec
                del authorization_category
                del auto_update
                del body
                del branded_content_sponsor_page_id
                del bundle_folder_id
                del call_to_action_type
                del categorization_criteria
                del category_media_source
                del destination_set_id
                del dynamic_ad_voice
                del effective_authorization_category
                del effective_instagram_story_id
                del effective_object_story_id
                del enable_direct_install
                del enable_launch_instant_app
                del creative_id
                del image_crops
                del image_hash
                del image_url
                del instagram_actor_id
                del instagram_permalink_url
                del instagram_story_id
                del interactive_components_spec
                del link_deep_link_url
                del link_og_id
                del link_url
                del messenger_sponsored_message
                del name
                del object_id
                del object_store_url
                del object_story_id
                del object_story_spec
                del object_type
                del object_url
                del place_page_set_id
                del platform_customizations
                del playable_asset_id
                del portrait_customizations
                del product_set_id
                del recommender_settings
                del status
                del template_url
                del template_url_spec
                del thumbnail_url
                del title
                del url_tags
                del use_page_actor_override
                del video_id
                del image_file
                del is_dco_internal
                del url_post

            # Print report
            print (str(rows) + " rows added to the file ")