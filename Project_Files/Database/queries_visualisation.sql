--queries were used in Redash for graphs and charts--

--trips per category--
select
r.category as "action:multifilter"
, count(*) as Trips
from voc.persons_contracts pc
inner join voc.ranks r
	on r.rank_id = pc.rank_id
inner join voc.places p
	on p.place_id = pc.place_id
inner join voc.places_standardized ps
	on ps.place_standardized_id = p.place_standardized_id
inner join voc.voyages vo
	on vo.das_voyage_id = pc.outward_voyage_id
inner join voc.sources s
	on s.source_id = pc.source_id
left join voc.voyages vr
	on vr.das_voyage_id = pc.return_voyage_id
left join voc.wage_sample ws
	on ws.vocop_id = pc.vocop_id
inner join voc.raw_data_clustered rdc
	on rdc.vocop_id = pc.vocop_id
group by r.category


--Locations of OTHER--
select
r.rank as "action::multi-filter"
, ps.latitude as latOrigin
, ps.longtitude as lonOrigin
from voc.persons_contracts pc
inner join voc.ranks r
	on r.rank_id = pc.rank_id
inner join voc.places p
	on p.place_id = pc.place_id
inner join voc.places_standardized ps
	on ps.place_standardized_id = p.place_standardized_id
inner join voc.voyages vo
	on vo.das_voyage_id = pc.outward_voyage_id
where r.category = 'OTHER'

--Wave average per category--
select r.category
, avg(r.median_wage) as wage_median
--, avg(ws.monthly_wage) as wage_raw
--, avg(cast(rdc.wagemin as bigint)) as wage_min
--, avg(cast(rdc.wagemax as bigint)) as wage_max
from voc.persons_contracts pc
inner join voc.ranks r
	on r.rank_id = pc.rank_id
inner join voc.places p
	on p.place_id = pc.place_id
inner join voc.places_standardized ps
	on ps.place_standardized_id = p.place_standardized_id
inner join voc.voyages vo
	on vo.das_voyage_id = pc.outward_voyage_id
inner join voc.sources s
	on s.source_id = pc.source_id
left join voc.voyages vr
	on vr.das_voyage_id = pc.return_voyage_id
left join voc.wage_sample ws
	on ws.vocop_id = pc.vocop_id
inner join voc.raw_data_clustered rdc
	on rdc.vocop_id = pc.vocop_id
group by r.category

--Wage averages per rank of OTHER--
select r.rank as "action::multi-filter"
, avg(r.median_wage) as wage_median
--, avg(ws.monthly_wage) as wage_raw
--, avg(cast(rdc.wagemin as bigint)) as wage_min
--, avg(cast(rdc.wagemax as bigint)) as wage_max
from voc.persons_contracts pc
inner join voc.ranks r
	on r.rank_id = pc.rank_id
inner join voc.places p
	on p.place_id = pc.place_id
inner join voc.places_standardized ps
	on ps.place_standardized_id = p.place_standardized_id
inner join voc.voyages vo
	on vo.das_voyage_id = pc.outward_voyage_id
inner join voc.sources s
	on s.source_id = pc.source_id
left join voc.voyages vr
	on vr.das_voyage_id = pc.return_voyage_id
left join voc.wage_sample ws
	on ws.vocop_id = pc.vocop_id
inner join voc.raw_data_clustered rdc
	on rdc.vocop_id = pc.vocop_id
where r.category = 'OTHER'
group by r.rank

--Base data for OTHER--
select pc.full_name
, r.rank as "action::multi-filter"
, r.median_wage as wage_median
, ws.monthly_wage as wage_raw
, rdc.wagemin as wage_min
, rdc.wagemax as wage_max
, ps.place_standardized as place_origin
, vo.ship_name as ship_name_outward
, vo.departure_place as departure_place_outward
, vo.departure_date as departure_date_outward
, vo.ship_name as ship_name_return
, vr.departure_place as departure_place_return
, vr.departure_place as departure_date_return
, 1 as tripcount
from voc.persons_contracts pc
inner join voc.ranks r
	on r.rank_id = pc.rank_id
inner join voc.places p
	on p.place_id = pc.place_id
inner join voc.places_standardized ps
	on ps.place_standardized_id = p.place_standardized_id
inner join voc.voyages vo
	on vo.das_voyage_id = pc.outward_voyage_id
inner join voc.sources s
	on s.source_id = pc.source_id
left join voc.voyages vr
	on vr.das_voyage_id = pc.return_voyage_id
left join voc.wage_sample ws
	on ws.vocop_id = pc.vocop_id
inner join voc.raw_data_clustered rdc
	on rdc.vocop_id = pc.vocop_id
where r.category = 'OTHER'
