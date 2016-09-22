--
-- PostgreSQL database dump
--


SET client_encoding = 'UTF8';


CREATE TABLE cma_2010 (
    gid integer,
    id character varying(6),
    name text,
    type character varying(6),
    geom geometry(MultiPolygon,4326)
);



CREATE TABLE cma_2010_population (
    type text,
    id text,
    name text,
    geom geometry,
    gid integer,
    population integer,
    households integer,
    businesses integer,
    addresses integer
);



CREATE TABLE cma_popdensity (
    cma_id integer,
    cma_name text,
    popden double precision
);



CREATE TABLE curr_cdmacelllocation (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    metric character varying(32) DEFAULT NULL::character varying,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    system_id integer,
    network_id integer,
    ecio integer,
    dbm integer,
    base_station_id integer,
    base_station_latitude integer,
    base_station_longitude integer
);



--
-- Name: curr_cellneighbourtower; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_cellneighbourtower (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    metric character varying(32) DEFAULT NULL::character varying,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    location_area_code integer,
    cell_tower_id integer,
    network_type_code character varying(10) DEFAULT NULL::character varying,
    network_type character varying(10) DEFAULT NULL::character varying,
    umts_psc integer,
    rssi integer
);



--
-- Name: curr_closesttarget; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_closesttarget (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    target character varying(100) DEFAULT NULL::character varying,
    ipaddress character varying(46) DEFAULT NULL::character varying
);



--
-- Name: curr_cpuactivity; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_cpuactivity (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    success smallint DEFAULT 0,
    max_average integer DEFAULT 0,
    read_average integer DEFAULT 0
);



--
-- Name: curr_datacap; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_datacap (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    success smallint
);



--
-- Name: curr_gsmcelllocation; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_gsmcelllocation (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    metric character varying(32) DEFAULT NULL::character varying,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    signal_strength smallint,
    umts_psc integer,
    location_area_code integer,
    cell_tower_id integer
);



--
-- Name: curr_httpget; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_httpget (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    success smallint,
    target character varying(100) DEFAULT NULL::character varying,
    ipaddress character varying(46) DEFAULT NULL::character varying,
    transfer_time integer,
    transfer_bytes integer,
    bytes_sec integer,
    warmup_time integer,
    warmup_bytes integer,
    number_of_threads integer,
    year integer,
    quarter integer,
    period integer,
    submission_type text,
    cma_id text,
    peak boolean,
    lte boolean DEFAULT false NOT NULL,
    android boolean DEFAULT false NOT NULL,
    roam boolean DEFAULT false NOT NULL,
    cell boolean DEFAULT false NOT NULL,
    carrier text
);




--
-- Name: curr_netactivity; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_netactivity (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    success smallint,
    maxbytesout integer,
    maxbytesin integer,
    bytesout integer,
    bytesin integer
);

--
-- Name: curr_netusage; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_netusage (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    duration bigint,
    total_rx_bytes bigint,
    total_tx_bytes bigint,
    mobile_rx_bytes bigint,
    mobile_tx_bytes bigint,
    app_rx_bytes bigint,
    app_tx_bytes bigint
);



--
-- Name: curr_networkdata; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_networkdata (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    metric character varying(32) DEFAULT NULL::character varying,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    connected smallint,
    active_network_type_code character varying(10) DEFAULT NULL::character varying,
    active_network_type character varying(10) DEFAULT NULL::character varying,
    sim_operator_code character varying(6) DEFAULT NULL::character varying,
    sim_operator_name character varying(32) DEFAULT NULL::character varying,
    roaming smallint,
    phone_type_code character varying(10) DEFAULT NULL::character varying,
    phone_type character varying(10) DEFAULT NULL::character varying,
    network_type_code character varying(10) DEFAULT NULL::character varying,
    network_type character varying(32) DEFAULT NULL::character varying,
    network_operator_code character varying(10) DEFAULT NULL::character varying,
    network_operator_name character varying(32) DEFAULT NULL::character varying,
    cell boolean,
    cma_id text,
    carrier text
);


--
-- Name: curr_submission; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_submission (
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    enterprise_id character varying(32) DEFAULT ''::character varying NOT NULL,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    devicedtime character varying(100) NOT NULL,
    schedule_config_version character varying(20) DEFAULT NULL::character varying,
    sim_operator_code character varying(6) DEFAULT NULL::character varying,
    submission_type character varying(20) DEFAULT NULL::character varying,
    timezone double precision,
    received timestamp without time zone,
    source_ip character varying(20) DEFAULT NULL::character varying,
    app_version_code character varying(20) DEFAULT ''::character varying NOT NULL,
    app_version_name character varying(20) DEFAULT ''::character varying NOT NULL,
    tests smallint,
    metrics smallint,
    conditions smallint,
    os_type character varying(20) DEFAULT NULL::character varying,
    os_version character varying(20) DEFAULT NULL::character varying,
    model character varying(20) DEFAULT NULL::character varying,
    manufacturer character varying(20) DEFAULT NULL::character varying,
    imei character varying(16) DEFAULT NULL::character varying,
    imsi character varying(15) DEFAULT NULL::character varying,
    iosapp_id character varying(36) DEFAULT NULL::character varying,
    mobile_location_id integer
);



--
-- Name: curr_udplatency; Type: TABLE; Schema: public; Owner: yositune
--

CREATE TABLE curr_udplatency (
    ix smallint DEFAULT 0 NOT NULL,
    submission_id character(32) DEFAULT ''::bpchar NOT NULL,
    dtime timestamp without time zone NOT NULL,
    localdtime timestamp without time zone NOT NULL,
    success smallint,
    target character varying(100) DEFAULT NULL::character varying,
    ipaddress character varying(46) DEFAULT NULL::character varying,
    rtt_avg integer,
    rtt_min integer,
    rtt_max integer,
    rtt_stddev integer,
    received_packets integer,
    lost_packets integer,
    year integer,
    quarter integer,
    period integer,
    submission_type text,
    peak boolean,
    lte boolean DEFAULT false NOT NULL,
    roam boolean DEFAULT false NOT NULL,
    cell boolean DEFAULT false NOT NULL,
    carrier text
);

