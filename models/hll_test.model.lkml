connection: "hll_test"

# include all the views
include: "/views/**/*.view"

datagroup: hll_test_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: hll_test_default_datagroup

explore: hll_test01_prc_min_store_id {
  persist_for: "24 hours"
  join: count_by_store {
    type: left_outer
    sql_on: ${hll_test01_prc_min_store_id.store_id}=${count_by_store.store_id} and
    ${hll_test01_prc_min_store_id.prc_date} = ${count_by_store.dt};;
    relationship: many_to_one
  }
}


explore: hll_test_1 {}

explore: csv_import {}

explore: csv_test {}

explore: my_view {}


explore: test_hll {}

# explore: hll_test{}

explore: events_all {
  sql_always_where: ${events_all__properties.key}='theme_name' ;;
  join: events_all__properties {
    view_label: "Events All: Properties"
    sql: LEFT JOIN UNNEST(${events_all.properties}) as events_all__properties ;;
    relationship: one_to_many
  }
}

explore: demo_for_tongbin {
  join:demo_for_tongbin_2{
    from:demo_for_tongbin
    sql_on: ${demo_for_tongbin.client_hll} = ${demo_for_tongbin_2.client_hll};;
    relationship: one_to_one
  }
}

# explore: 7days_sign_paid_expired_stores {}

# explore: _latest2day_for_gmv_tongbin {}

# explore: _latest2day_leftjoin_tongbin {}

# explore: _latest2day_leftjoin_tongbin_selectall_ceshi {}

# explore: admin_transaction_7day {}

# explore: admin_transaction_domain_forkam_1015_yesterday {}

# explore: amy01_38729 {}

# explore: calculate_dispute_rate_batch {}

# explore: connection_reg_r3 {}

# explore: cube_7day_test {}

# explore: cube_count_ceshi {}

# explore: disputes_date_storeid_0916_yesterday {}

# explore: disputes_dateframe_storeid_0916_yesterday {}

# explore: disputes_dateframe_usd_merchant_storeid_0916_yesterday {}

# explore: disputes_dateframe_usd_storeid_0916_yesterday {}

# explore: fx_mubiaobiao0901_yesterday_notfilter_count_c_theme_tongbin {}

# explore: fx_mubiaobiao0901_yesterday_notfilter_count_c_tongbin {}

# explore: fx_mubiaobiao0901_yesterday_notfilter_count_cc_theme_tongbin {}

# explore: fx_mubiaobiao0901_yesterday_notfilter_count_cc_tongbin {}

# explore: fx_mubiaobiao0901_yesterday_notfilter_count_cco_theme_tongbin {}

# explore: fx_mubiaobiao0901_yesterday_notfilter_count_cco_tongbin {}

# explore: fx_mubiaobiao0901_yesterday_notfilter_count_cco_tongbin_google {}

# explore: hll_test01_store_id {}

# explore: hll_test02_store_id {}

# explore: ip_info_utc8_0929_1028 {}

# explore: latest2day_stella_1014_tongbin {}

# explore: latest_nday_for_gmv_tongbin {}

# explore: latest_nday_leftjoin_tongbin {}

# explore: mubiaobiao_0901_yesterday_notfilter_forpp_tongbin {}

# explore: mubiaobiao_0901_yesterday_notfilter_tongbin {}

# explore: mubiaobiao_0901_yesterday_notfilter_tongbin_google {}

# explore: mubiaobiao_october_forchenzhuoxin_notfilte_for_gmv_tongbin {}

# explore: mubiaobiao_october_forchenzhuoxin_notfilter_tongbin {}

# explore: new_disputes {}

# explore: october_forchenzhuoxin_notfilte_for_gmv_tongbin {}

# explore: october_forchenzhuoxin_notfilter_tongbin {}

# explore: para_ceshi {}

# explore: para_ceshi2 {}

# explore: pay_pal_express_day {}

# explore: pay_pal_express_day_xiaoyang {}

# explore: pay_pal_express_day_yuemin {}

# explore: sa_latest2day_notfilter_tongbin {}

# explore: store {}

# explore: stroeid_4metric_tongbin {}

# explore: stroeid_metric_october_tongbin {}
