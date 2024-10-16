--
-- PostgreSQL database dump
--

-- Dumped from database version 13.11 (Debian 13.11-1.pgdg110+1)
-- Dumped by pg_dump version 13.11 (Debian 13.11-1.pgdg110+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adaptor_metadata; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.adaptor_metadata (
    id integer NOT NULL,
    name text NOT NULL,
    type character varying(32) NOT NULL,
    configuration text NOT NULL,
    status integer NOT NULL,
    profile character varying(32) DEFAULT 'SOURCE'::character varying NOT NULL,
    created_by character varying(32) NOT NULL,
    created_on bigint DEFAULT (date_part('second'::text, CURRENT_TIME) * (1000)::double precision) NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_on bigint DEFAULT (date_part('second'::text, CURRENT_TIME) * (1000)::double precision) NOT NULL,
    iscontextual character varying(10) DEFAULT 'false'::character varying
);


ALTER TABLE public.adaptor_metadata OWNER TO sigmastream;

--
-- Name: adaptor_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.adaptor_metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adaptor_metadata_id_seq OWNER TO sigmastream;

--
-- Name: adaptor_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.adaptor_metadata_id_seq OWNED BY public.adaptor_metadata.id;


--
-- Name: appconfig; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.appconfig (
    propertykey text NOT NULL,
    propertyvalue text NOT NULL,
    valuetype text DEFAULT ''::text NOT NULL,
    propertytype text DEFAULT ''::text,
    scope text,
    description text
);


ALTER TABLE public.appconfig OWNER TO sigmastream;

--
-- Name: assets; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    wellid character varying(128),
    rigid integer,
    api character varying(128),
    uwi character varying(128),
    companyuwi character varying(128),
    commonname character varying(128),
    legalname character varying(128),
    field character varying(128),
    lease character varying(128),
    district character varying(100),
    region character varying(100),
    county character varying(100),
    state character varying(100),
    country character varying(100),
    latitude character varying(100),
    longitude character varying(100),
    easting character varying(100),
    northing character varying(100),
    crs character varying(100),
    elevationkb character varying(100),
    elevationground character varying(100),
    spuddate character varying(100),
    completiondate character varying(100),
    created_user_profile character varying(50) DEFAULT 'CLIENT'::character varying NOT NULL,
    delete_status character varying(7),
    active_status character varying(1) DEFAULT 'Y'::character varying,
    welldata_capture character varying(1) DEFAULT 'N'::character varying,
    updatedon character varying(100) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.assets OWNER TO sigmastream;

--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assets_id_seq OWNER TO sigmastream;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: attributerules; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.attributerules (
    id integer NOT NULL,
    attributeid integer NOT NULL,
    ruletype text NOT NULL,
    name text,
    weight integer DEFAULT 0,
    value text,
    timeout integer,
    description text,
    status integer DEFAULT 0
);


ALTER TABLE public.attributerules OWNER TO sigmastream;

--
-- Name: attributerules_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.attributerules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attributerules_id_seq OWNER TO sigmastream;

--
-- Name: attributerules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.attributerules_id_seq OWNED BY public.attributerules.id;


--
-- Name: attributes; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.attributes (
    id integer NOT NULL,
    entityid integer NOT NULL,
    name text NOT NULL,
    editable boolean DEFAULT false,
    isrequired boolean DEFAULT false,
    latestvalue text,
    quorumenable boolean DEFAULT false,
    instantupdate boolean DEFAULT false,
    description text,
    status integer DEFAULT 0
);


ALTER TABLE public.attributes OWNER TO sigmastream;

--
-- Name: attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.attributes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attributes_id_seq OWNER TO sigmastream;

--
-- Name: attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.attributes_id_seq OWNED BY public.attributes.id;


--
-- Name: attributevalues; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.attributevalues (
    id integer NOT NULL,
    attributeid integer NOT NULL,
    sourcename text NOT NULL,
    value text NOT NULL,
    "timestamp" bigint NOT NULL
);


ALTER TABLE public.attributevalues OWNER TO sigmastream;

--
-- Name: attributevalues_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.attributevalues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attributevalues_id_seq OWNER TO sigmastream;

--
-- Name: attributevalues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.attributevalues_id_seq OWNED BY public.attributevalues.id;


--
-- Name: bha_run; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.bha_run (
    bharunid integer NOT NULL,
    sectionid integer NOT NULL,
    bharunnumber integer NOT NULL,
    created_user_profile character varying(50) DEFAULT 'CLIENT'::character varying NOT NULL,
    delete_status character varying(7),
    active_status character varying(1) DEFAULT 'Y'::character varying
);


ALTER TABLE public.bha_run OWNER TO sigmastream;

--
-- Name: bha_run_bharunid_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.bha_run_bharunid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bha_run_bharunid_seq OWNER TO sigmastream;

--
-- Name: bha_run_bharunid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.bha_run_bharunid_seq OWNED BY public.bha_run.bharunid;


--
-- Name: bharun_feed; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.bharun_feed (
    bharun_feed_id integer NOT NULL,
    bharunid bigint NOT NULL,
    feed_id integer NOT NULL,
    delete_status character varying(7),
    created_user_profile character varying(50) DEFAULT 'CLIENT'::character varying NOT NULL
);


ALTER TABLE public.bharun_feed OWNER TO sigmastream;

--
-- Name: bharun_feed_bharun_feed_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.bharun_feed_bharun_feed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bharun_feed_bharun_feed_id_seq OWNER TO sigmastream;

--
-- Name: bharun_feed_bharun_feed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.bharun_feed_bharun_feed_id_seq OWNED BY public.bharun_feed.bharun_feed_id;


--
-- Name: channel_identifier; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.channel_identifier (
    channelidentifierid integer NOT NULL,
    description text,
    longmnemonic text,
    shortmnemonic text,
    itemtype character varying(1),
    itemlength integer,
    metricunits text,
    fpsunits text,
    type character varying(30) DEFAULT 'WITS'::character varying NOT NULL,
    created_user_profile character varying(7),
    issi character varying(1) DEFAULT 'N'::character varying
);


ALTER TABLE public.channel_identifier OWNER TO sigmastream;

--
-- Name: channel_identifier_channelidentifierid_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.channel_identifier_channelidentifierid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.channel_identifier_channelidentifierid_seq OWNER TO sigmastream;

--
-- Name: channel_identifier_channelidentifierid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.channel_identifier_channelidentifierid_seq OWNED BY public.channel_identifier.channelidentifierid;


--
-- Name: chunktransfer; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.chunktransfer (
    id integer NOT NULL,
    chunkprofile character varying(32) NOT NULL,
    asset character varying(128) NOT NULL,
    host character varying(128),
    status integer DEFAULT 0,
    recipient character varying(128) NOT NULL,
    summary text,
    peers integer DEFAULT 10,
    userprofile character varying(50) DEFAULT 'SOURCE'::character varying,
    progress integer DEFAULT 0,
    mongodbname character varying(128) NOT NULL,
    created_on bigint DEFAULT (date_part('second'::text, CURRENT_TIME) * (1000)::double precision) NOT NULL,
    start_time timestamp without time zone,
    filepath text,
    port integer NOT NULL,
    devices text DEFAULT ''::text,
    requesttype character varying(30) DEFAULT 'PUSH'::character varying,
    runcount integer DEFAULT 0,
    tagname character varying(100) DEFAULT ''::character varying
);


ALTER TABLE public.chunktransfer OWNER TO sigmastream;

--
-- Name: chunktransfer_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.chunktransfer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chunktransfer_id_seq OWNER TO sigmastream;

--
-- Name: chunktransfer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.chunktransfer_id_seq OWNED BY public.chunktransfer.id;


--
-- Name: config; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.config (
    config_id integer NOT NULL,
    configuration text NOT NULL,
    created_by character varying(32) DEFAULT NULL::character varying,
    created_on character varying(128) DEFAULT NULL::character varying,
    updated_by character varying(32) DEFAULT NULL::character varying,
    updated_on character varying(128) DEFAULT NULL::character varying
);


ALTER TABLE public.config OWNER TO sigmastream;

--
-- Name: config_config_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.config_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.config_config_id_seq OWNER TO sigmastream;

--
-- Name: config_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.config_config_id_seq OWNED BY public.config.config_id;


--
-- Name: crs; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.crs (
    crs_id integer NOT NULL,
    crs_name text NOT NULL
);


ALTER TABLE public.crs OWNER TO sigmastream;

--
-- Name: crs_crs_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.crs_crs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.crs_crs_id_seq OWNER TO sigmastream;

--
-- Name: crs_crs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.crs_crs_id_seq OWNED BY public.crs.crs_id;


--
-- Name: entity; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.entity (
    id integer NOT NULL,
    name text NOT NULL,
    parentname text,
    status integer DEFAULT 0
);


ALTER TABLE public.entity OWNER TO sigmastream;

--
-- Name: entity_activity; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.entity_activity (
    id integer NOT NULL,
    wellboreid bigint,
    activityname character varying(500) NOT NULL,
    starttime character varying(500) NOT NULL,
    endtime character varying(500) NOT NULL,
    created_by character varying(100) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying,
    entity_name character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.entity_activity OWNER TO sigmastream;

--
-- Name: entity_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.entity_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_activity_id_seq OWNER TO sigmastream;

--
-- Name: entity_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.entity_activity_id_seq OWNED BY public.entity_activity.id;


--
-- Name: entity_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_id_seq OWNER TO sigmastream;

--
-- Name: entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.entity_id_seq OWNED BY public.entity.id;


--
-- Name: entity_metadata; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.entity_metadata (
    id integer NOT NULL,
    entity_id bigint,
    name character varying(500) NOT NULL,
    value character varying(500) NOT NULL,
    created_by character varying(100) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying,
    entity_name character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.entity_metadata OWNER TO sigmastream;

--
-- Name: entity_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.entity_metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_metadata_id_seq OWNER TO sigmastream;

--
-- Name: entity_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.entity_metadata_id_seq OWNED BY public.entity_metadata.id;


--
-- Name: feed; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.feed (
    feed_id integer NOT NULL,
    asset_id character varying(128) NOT NULL,
    sub_asset_id character varying(128) NOT NULL,
    logid character varying(128) NOT NULL,
    feed_type character varying(50) NOT NULL,
    server_address character varying(64),
    source_address character varying(64),
    issecure character varying(50),
    username character varying(64),
    password character varying(64),
    archive_status character varying(10) DEFAULT 'Y'::character varying,
    socketid character varying(50),
    created_user_profile character varying(50) DEFAULT 'CLIENT'::character varying NOT NULL,
    active character varying(1) DEFAULT 'Y'::character varying,
    adaptorconfig text,
    created_by character varying(50) DEFAULT NULL::character varying,
    created_on character varying(64) DEFAULT NULL::character varying,
    updated_by character varying(50) DEFAULT NULL::character varying,
    updated_on character varying(64) DEFAULT NULL::character varying,
    devicename character varying(128),
    frequency double precision,
    delete_status character varying(7),
    dfbit integer,
    device_id character varying(64),
    data_type character varying(10) DEFAULT 'SIMULATED'::character varying,
    manufacturer character varying(56) DEFAULT 'YELLOWHAMMER'::character varying,
    device_type character varying(64),
    model_number character varying(30),
    serial_number character varying(30),
    storagetype character varying(30) DEFAULT 'INDIVIDUAL'::character varying,
    partitionpolicy character varying(30) DEFAULT 'NO-PARTITION'::character varying,
    partitionsize character varying(30) DEFAULT 'DAILY'::character varying,
    timezone character varying(100) DEFAULT 'GMT'::character varying,
    dstenable character varying(30) DEFAULT 'false'::character varying
);


ALTER TABLE public.feed OWNER TO sigmastream;

--
-- Name: feed_config; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.feed_config (
    feed_config_id integer NOT NULL,
    feed_id integer NOT NULL,
    channel_id integer NOT NULL,
    index_id integer NOT NULL,
    channel_uri character varying(300) NOT NULL,
    channel_nm character varying(128) NOT NULL,
    channel_uuid character varying(128) NOT NULL,
    mnemonic character varying(128) NOT NULL,
    data_type character varying(20) NOT NULL,
    uom character varying(128) DEFAULT NULL::character varying,
    start_index character varying(16) DEFAULT NULL::character varying,
    end_index character varying(16) DEFAULT NULL::character varying,
    description character varying(128) DEFAULT NULL::character varying,
    frequencyinhz double precision,
    subscribable character varying(1) DEFAULT 'T'::character varying,
    nullvalue character varying(64),
    status character varying(1) DEFAULT 'ACTIVE'::character varying,
    archive_status text DEFAULT 'Y'::text,
    created_user_profile character varying(128) DEFAULT 'CLIENT'::character varying NOT NULL,
    created_by character varying(100) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying,
    delete_status character varying(7),
    category text DEFAULT 'DATA'::text,
    sourcechannelidentifier character varying(300),
    metadata text
);


ALTER TABLE public.feed_config OWNER TO sigmastream;

--
-- Name: feed_config_feed_config_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.feed_config_feed_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feed_config_feed_config_id_seq OWNER TO sigmastream;

--
-- Name: feed_config_feed_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.feed_config_feed_config_id_seq OWNED BY public.feed_config.feed_config_id;


--
-- Name: feed_feed_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.feed_feed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feed_feed_id_seq OWNER TO sigmastream;

--
-- Name: feed_feed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.feed_feed_id_seq OWNED BY public.feed.feed_id;


--
-- Name: jobrun; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.jobrun (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    status integer NOT NULL,
    modifieddate bigint NOT NULL,
    summary text,
    jsonconfig text DEFAULT ''::text,
    isconfigurable boolean DEFAULT false,
    type character varying(30),
    initialdelay bigint DEFAULT 0,
    "interval" bigint DEFAULT 0
);


ALTER TABLE public.jobrun OWNER TO sigmastream;

--
-- Name: jobrun_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.jobrun_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobrun_id_seq OWNER TO sigmastream;

--
-- Name: jobrun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.jobrun_id_seq OWNED BY public.jobrun.id;


--
-- Name: log; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.log (
    uid character varying(32) NOT NULL,
    uidwell character varying(32) NOT NULL,
    uidwellbore character varying(32) NOT NULL,
    number character varying(32) DEFAULT NULL::character varying,
    suffixapi character varying(32) DEFAULT NULL::character varying,
    indexcurve character varying(32) NOT NULL,
    vw character varying(1) DEFAULT 'T'::character varying,
    upd character varying(1) DEFAULT 'T'::character varying,
    del character varying(1) DEFAULT 'T'::character varying
);


ALTER TABLE public.log OWNER TO sigmastream;

--
-- Name: logcurve; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.logcurve (
    uid character varying(32) NOT NULL,
    mnemonic character varying(32) NOT NULL,
    vw character varying(1) DEFAULT 'T'::character varying,
    upd character varying(1) DEFAULT 'T'::character varying,
    del character varying(1) DEFAULT 'T'::character varying
);


ALTER TABLE public.logcurve OWNER TO sigmastream;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.permissions (
    permission_nm character varying(64) NOT NULL,
    permission_str character varying(128) NOT NULL
);


ALTER TABLE public.permissions OWNER TO sigmastream;

--
-- Name: profile; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.profile (
    profileid integer NOT NULL,
    name character varying(100) NOT NULL,
    asset_id character varying(56) NOT NULL,
    sub_asset_id character varying(56) NOT NULL,
    description character varying(128) NOT NULL,
    created_user_profile character varying(50) NOT NULL,
    delete_status character varying(7) DEFAULT 'N'::character varying,
    active_status character varying(1) DEFAULT 'Y'::character varying,
    created_by character varying(100) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public.profile OWNER TO sigmastream;

--
-- Name: profile_details; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.profile_details (
    profile_detailsid integer NOT NULL,
    profileid integer NOT NULL,
    uri character varying(300) NOT NULL,
    mnemonic character varying(128) NOT NULL,
    created_user_profile character varying(50) NOT NULL,
    delete_status character varying(7) DEFAULT 'N'::character varying,
    active_status character varying(1) DEFAULT 'Y'::character varying,
    created_by character varying(32) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying,
    channel_id integer,
    uom character varying(100) DEFAULT 'UNITLESS'::character varying
);


ALTER TABLE public.profile_details OWNER TO sigmastream;

--
-- Name: profile_details_profile_detailsid_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.profile_details_profile_detailsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_details_profile_detailsid_seq OWNER TO sigmastream;

--
-- Name: profile_details_profile_detailsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.profile_details_profile_detailsid_seq OWNED BY public.profile_details.profile_detailsid;


--
-- Name: profile_profileid_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.profile_profileid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_profileid_seq OWNER TO sigmastream;

--
-- Name: profile_profileid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.profile_profileid_seq OWNED BY public.profile.profileid;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.resources (
    resource_name text NOT NULL,
    label text NOT NULL
);


ALTER TABLE public.resources OWNER TO sigmastream;

--
-- Name: rig; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.rig (
    rigid integer NOT NULL,
    name character varying(50),
    drillingcontractor character varying(50),
    created_user_profile character varying(50) DEFAULT 'CLIENT'::character varying NOT NULL,
    delete_status character varying(7),
    active_status character varying(1) DEFAULT 'Y'::character varying,
    timezone character varying(100) DEFAULT 'GMT'::character varying,
    dstenabled character varying(30) DEFAULT 'false'::character varying,
    display_name character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.rig OWNER TO sigmastream;

--
-- Name: rig_rigid_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.rig_rigid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_rigid_seq OWNER TO sigmastream;

--
-- Name: rig_rigid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.rig_rigid_seq OWNED BY public.rig.rigid;


--
-- Name: role_res_perms; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.role_res_perms (
    role character varying(30) NOT NULL,
    resource character varying(50) NOT NULL,
    perm character varying(30) DEFAULT 'NNNNNNNNNN'::character varying NOT NULL
);


ALTER TABLE public.role_res_perms OWNER TO sigmastream;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.roles (
    role_name character varying(500) NOT NULL,
    description character varying(500) NOT NULL
);


ALTER TABLE public.roles OWNER TO sigmastream;

--
-- Name: roles_permissions; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.roles_permissions (
    roleper character varying(500) NOT NULL,
    role_name character varying(500) NOT NULL,
    permission character varying(500) NOT NULL
);


ALTER TABLE public.roles_permissions OWNER TO sigmastream;

--
-- Name: section; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.section (
    sectionid integer NOT NULL,
    wellboreid bigint,
    type character varying(50),
    top bigint,
    bottom bigint,
    created_user_profile character varying(50) DEFAULT 'CLIENT'::character varying NOT NULL,
    delete_status character varying(7),
    active_status character varying(1) DEFAULT 'Y'::character varying
);


ALTER TABLE public.section OWNER TO sigmastream;

--
-- Name: section_sectionid_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.section_sectionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.section_sectionid_seq OWNER TO sigmastream;

--
-- Name: section_sectionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.section_sectionid_seq OWNED BY public.section.sectionid;


--
-- Name: standard_mnemonic_group; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.standard_mnemonic_group (
    id integer NOT NULL,
    groupname character varying(100),
    grouptype character varying(100),
    indextype character varying(50),
    created_by character varying(100) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public.standard_mnemonic_group OWNER TO sigmastream;

--
-- Name: standard_mnemonic_group_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.standard_mnemonic_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.standard_mnemonic_group_id_seq OWNER TO sigmastream;

--
-- Name: standard_mnemonic_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.standard_mnemonic_group_id_seq OWNED BY public.standard_mnemonic_group.id;


--
-- Name: standard_mnemonic_validation_rule; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.standard_mnemonic_validation_rule (
    id integer NOT NULL,
    standard_mnemonic_id integer,
    rule_type character varying(100),
    rule_expression character varying(500),
    sequence integer,
    created_by character varying(100) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public.standard_mnemonic_validation_rule OWNER TO sigmastream;

--
-- Name: standard_mnemonic_validation_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.standard_mnemonic_validation_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.standard_mnemonic_validation_rule_id_seq OWNER TO sigmastream;

--
-- Name: standard_mnemonic_validation_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.standard_mnemonic_validation_rule_id_seq OWNED BY public.standard_mnemonic_validation_rule.id;


--
-- Name: standard_mnemonics; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.standard_mnemonics (
    id integer NOT NULL,
    standard_mnemonic_group_id integer,
    status character varying(50),
    minindex real,
    maxindex real,
    metricunit character varying(100),
    fpsunit character varying(100),
    mnemonicname character varying(500),
    datatype character varying(50),
    created_by character varying(100) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public.standard_mnemonics OWNER TO sigmastream;

--
-- Name: standard_mnemonics_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.standard_mnemonics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.standard_mnemonics_id_seq OWNER TO sigmastream;

--
-- Name: standard_mnemonics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.standard_mnemonics_id_seq OWNED BY public.standard_mnemonics.id;


--
-- Name: subasset_standard_mnemonic_groups; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.subasset_standard_mnemonic_groups (
    id integer NOT NULL,
    asset character varying(100),
    subasset character varying(100),
    standard_mnemonic_group_id integer,
    validation_enable character varying(10),
    persistence_enable character varying(10),
    buffer_policy_type character varying(100),
    buffer_value character varying(100),
    buffer_cleanup_interval bigint,
    issi character varying(10) DEFAULT 'Y'::character varying,
    created_by character varying(100) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying,
    index_channel character varying(500),
    config character varying(500),
    subscribe_enable character varying(10) DEFAULT 'Y'::character varying
);


ALTER TABLE public.subasset_standard_mnemonic_groups OWNER TO sigmastream;

--
-- Name: subasset_standard_mnemonic_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.subasset_standard_mnemonic_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subasset_standard_mnemonic_groups_id_seq OWNER TO sigmastream;

--
-- Name: subasset_standard_mnemonic_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.subasset_standard_mnemonic_groups_id_seq OWNED BY public.subasset_standard_mnemonic_groups.id;


--
-- Name: subasset_standard_mnemonics; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.subasset_standard_mnemonics (
    id integer NOT NULL,
    rig character varying(100),
    asset character varying(500),
    subasset character varying(500),
    sourcelog character varying(500),
    standard_mnemonic_group_id integer,
    standard_mnemonic_id bigint,
    source_log_mnemonic character varying(500),
    created_by character varying(100) DEFAULT NULL::character varying,
    created_on character varying(100) DEFAULT NULL::character varying,
    updated_by character varying(100) DEFAULT NULL::character varying,
    updated_on character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public.subasset_standard_mnemonics OWNER TO sigmastream;

--
-- Name: subasset_standard_mnemonics_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.subasset_standard_mnemonics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subasset_standard_mnemonics_id_seq OWNER TO sigmastream;

--
-- Name: subasset_standard_mnemonics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.subasset_standard_mnemonics_id_seq OWNED BY public.subasset_standard_mnemonics.id;


--
-- Name: subassets; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.subassets (
    wellboreid integer NOT NULL,
    wellid character varying(50) NOT NULL,
    name character varying(50) NOT NULL,
    created_user_profile character varying(50) DEFAULT 'CLIENT'::character varying NOT NULL,
    delete_status character varying(7),
    active_status character varying(1) DEFAULT 'Y'::character varying,
    display_name character varying
);


ALTER TABLE public.subassets OWNER TO sigmastream;

--
-- Name: subassets_wellboreid_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.subassets_wellboreid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subassets_wellboreid_seq OWNER TO sigmastream;

--
-- Name: subassets_wellboreid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.subassets_wellboreid_seq OWNED BY public.subassets.wellboreid;


--
-- Name: subscription; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.subscription (
    sub_id integer NOT NULL,
    id character varying(128) DEFAULT NULL::character varying,
    name character varying(128) DEFAULT NULL::character varying,
    apikey character varying(128) NOT NULL,
    remotehost character varying(128) NOT NULL,
    sourcehost character varying(128) NOT NULL,
    desiredfrequency double precision,
    type integer,
    mode integer DEFAULT 0,
    config text,
    active_status character varying(1) DEFAULT 'Y'::character varying,
    device_type character varying(128),
    device_id character varying(128),
    sessionid text,
    configmode character varying(10) DEFAULT 'sparsed'::character varying,
    asset character varying,
    rig character varying
);


ALTER TABLE public.subscription OWNER TO sigmastream;

--
-- Name: subscription_channel; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.subscription_channel (
    sub_channel_id integer NOT NULL,
    sub_id integer,
    uri character varying(300) DEFAULT NULL::character varying,
    channelaction character varying(32) NOT NULL,
    uom character varying(100) NOT NULL,
    updated_on bigint NOT NULL,
    active_status character varying(1) DEFAULT 'Y'::character varying,
    mnemonic character varying(300),
    from_uom character varying(100),
    from_datatype character varying(100),
    to_datatype character varying(100)
);


ALTER TABLE public.subscription_channel OWNER TO sigmastream;

--
-- Name: subscription_channel_sub_channel_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.subscription_channel_sub_channel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_channel_sub_channel_id_seq OWNER TO sigmastream;

--
-- Name: subscription_channel_sub_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.subscription_channel_sub_channel_id_seq OWNED BY public.subscription_channel.sub_channel_id;


--
-- Name: subscription_sub_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.subscription_sub_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_sub_id_seq OWNER TO sigmastream;

--
-- Name: subscription_sub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.subscription_sub_id_seq OWNED BY public.subscription.sub_id;


--
-- Name: unit_of_measurement; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.unit_of_measurement (
    id integer NOT NULL,
    symbol text NOT NULL,
    name text,
    dimension text NOT NULL,
    is_si text NOT NULL,
    category text NOT NULL,
    base_unit text NOT NULL,
    a real,
    b real,
    c real,
    d real,
    alias text
);


ALTER TABLE public.unit_of_measurement OWNER TO sigmastream;

--
-- Name: unit_of_measurement_id_seq; Type: SEQUENCE; Schema: public; Owner: sigmastream
--

CREATE SEQUENCE public.unit_of_measurement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unit_of_measurement_id_seq OWNER TO sigmastream;

--
-- Name: unit_of_measurement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigmastream
--

ALTER SEQUENCE public.unit_of_measurement_id_seq OWNED BY public.unit_of_measurement.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.user_roles (
    role_name character varying(50) NOT NULL,
    username character varying(50) NOT NULL
);


ALTER TABLE public.user_roles OWNER TO sigmastream;

--
-- Name: users; Type: TABLE; Schema: public; Owner: sigmastream
--

CREATE TABLE public.users (
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    fname character varying(50),
    sname character varying(50),
    disp_name character varying(50),
    company character varying(50),
    mobile character varying(50),
    email character varying(100),
    apikey character varying(100),
    delete_status character varying(1) DEFAULT 'N'::character varying,
    active_status character varying(1) DEFAULT 'Y'::character varying
);


ALTER TABLE public.users OWNER TO sigmastream;

--
-- Name: adaptor_metadata id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.adaptor_metadata ALTER COLUMN id SET DEFAULT nextval('public.adaptor_metadata_id_seq'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: attributerules id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.attributerules ALTER COLUMN id SET DEFAULT nextval('public.attributerules_id_seq'::regclass);


--
-- Name: attributes id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.attributes ALTER COLUMN id SET DEFAULT nextval('public.attributes_id_seq'::regclass);


--
-- Name: attributevalues id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.attributevalues ALTER COLUMN id SET DEFAULT nextval('public.attributevalues_id_seq'::regclass);


--
-- Name: bha_run bharunid; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.bha_run ALTER COLUMN bharunid SET DEFAULT nextval('public.bha_run_bharunid_seq'::regclass);


--
-- Name: bharun_feed bharun_feed_id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.bharun_feed ALTER COLUMN bharun_feed_id SET DEFAULT nextval('public.bharun_feed_bharun_feed_id_seq'::regclass);


--
-- Name: channel_identifier channelidentifierid; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.channel_identifier ALTER COLUMN channelidentifierid SET DEFAULT nextval('public.channel_identifier_channelidentifierid_seq'::regclass);


--
-- Name: chunktransfer id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.chunktransfer ALTER COLUMN id SET DEFAULT nextval('public.chunktransfer_id_seq'::regclass);


--
-- Name: config config_id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.config ALTER COLUMN config_id SET DEFAULT nextval('public.config_config_id_seq'::regclass);


--
-- Name: crs crs_id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.crs ALTER COLUMN crs_id SET DEFAULT nextval('public.crs_crs_id_seq'::regclass);


--
-- Name: entity id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.entity ALTER COLUMN id SET DEFAULT nextval('public.entity_id_seq'::regclass);


--
-- Name: entity_activity id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.entity_activity ALTER COLUMN id SET DEFAULT nextval('public.entity_activity_id_seq'::regclass);


--
-- Name: entity_metadata id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.entity_metadata ALTER COLUMN id SET DEFAULT nextval('public.entity_metadata_id_seq'::regclass);


--
-- Name: feed feed_id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.feed ALTER COLUMN feed_id SET DEFAULT nextval('public.feed_feed_id_seq'::regclass);


--
-- Name: feed_config feed_config_id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.feed_config ALTER COLUMN feed_config_id SET DEFAULT nextval('public.feed_config_feed_config_id_seq'::regclass);


--
-- Name: jobrun id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.jobrun ALTER COLUMN id SET DEFAULT nextval('public.jobrun_id_seq'::regclass);


--
-- Name: profile profileid; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.profile ALTER COLUMN profileid SET DEFAULT nextval('public.profile_profileid_seq'::regclass);


--
-- Name: profile_details profile_detailsid; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.profile_details ALTER COLUMN profile_detailsid SET DEFAULT nextval('public.profile_details_profile_detailsid_seq'::regclass);


--
-- Name: rig rigid; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.rig ALTER COLUMN rigid SET DEFAULT nextval('public.rig_rigid_seq'::regclass);


--
-- Name: section sectionid; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.section ALTER COLUMN sectionid SET DEFAULT nextval('public.section_sectionid_seq'::regclass);


--
-- Name: standard_mnemonic_group id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.standard_mnemonic_group ALTER COLUMN id SET DEFAULT nextval('public.standard_mnemonic_group_id_seq'::regclass);


--
-- Name: standard_mnemonic_validation_rule id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.standard_mnemonic_validation_rule ALTER COLUMN id SET DEFAULT nextval('public.standard_mnemonic_validation_rule_id_seq'::regclass);


--
-- Name: standard_mnemonics id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.standard_mnemonics ALTER COLUMN id SET DEFAULT nextval('public.standard_mnemonics_id_seq'::regclass);


--
-- Name: subasset_standard_mnemonic_groups id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subasset_standard_mnemonic_groups ALTER COLUMN id SET DEFAULT nextval('public.subasset_standard_mnemonic_groups_id_seq'::regclass);


--
-- Name: subasset_standard_mnemonics id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subasset_standard_mnemonics ALTER COLUMN id SET DEFAULT nextval('public.subasset_standard_mnemonics_id_seq'::regclass);


--
-- Name: subassets wellboreid; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subassets ALTER COLUMN wellboreid SET DEFAULT nextval('public.subassets_wellboreid_seq'::regclass);


--
-- Name: subscription sub_id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subscription ALTER COLUMN sub_id SET DEFAULT nextval('public.subscription_sub_id_seq'::regclass);


--
-- Name: subscription_channel sub_channel_id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subscription_channel ALTER COLUMN sub_channel_id SET DEFAULT nextval('public.subscription_channel_sub_channel_id_seq'::regclass);


--
-- Name: unit_of_measurement id; Type: DEFAULT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.unit_of_measurement ALTER COLUMN id SET DEFAULT nextval('public.unit_of_measurement_id_seq'::regclass);


--
-- Data for Name: adaptor_metadata; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.adaptor_metadata (id, name, type, configuration, status, profile, created_by, created_on, updated_by, updated_on, iscontextual) FROM stdin;
\.


--
-- Data for Name: appconfig; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.appconfig (propertykey, propertyvalue, valuetype, propertytype, scope, description) FROM stdin;
yh.server.adaptor.witsml.device.provider.rockpigeon.username	PST				
yh.server.adaptor.witsml.publisher.provider.nov.username	XXX				
iot.server.brute.cleaner.force.milisecond	600000				
iot.server.opcua.keyStorePassword	changeit				
iot.server.opcua.max.reconnect.retry.count	5				
iot.server.thread.dump.enable	true				
yh.server.adaptor.witsml.device.provider.pason.username	hari.koduru				
iot.server.data.subscription.thread.pool.size	200				
iot.web.admin.entity	RIG,WELL,WELLBORE,BHARUN				
iot.admin.csv.import.process.processors	50				
yh.metadata.archive.datasource.type	RDBMS				
yh.server.adaptor.witsml.publisher.yhtime.formatter	true				
iot.appmonitor.device.mail.sender	support@sigmastream.com				
iot.waterwheel.replay.btopts.natural	false				
iot.server.opcua.requested.publishing.interval.milliseconds	10.0				
yh.contextual.device.type	Modbus|yellowhammer-in				
yh.csv.timestamp.channel.name	Date Time				
iot.server.backfilling.jobs.concurrent.max.thread.count	3				
iot.wsocket.check.device.status.secure	true				
yh.depth.index.channel.max.value	50000				
iot.server.witsml.dataStreamingType	Log,Trajactory				
yh.server.adaptor.witsml.device.provider.nov.username	XXX				
iot.server.publisher.wellview.bd.key	BD				
iot.db.postgres.host	db				
iot.archived.feed.hard.delete.flag	true				
iot.server.auto.metadata.generate.run.enable	false				
iot.dataloss.backfill.process.interval	900000				
iot.server.opcua.discover.system.nodes	false				
iot.server.witsml.trajectory.data131	[["mdMin","ft","Trajectory"],["mdMax","ft","Trajectory"],["Magnetic Angle","UNITLESS","Trajectory"],["Grid Correction","UNITLESS","Trajectory"],["Azimuth of Vertical Section","denga","Trajectory"],["NS","ft","Trajectory"],["EW","ft","Trajectory"],["Azimuth","dega","Trajectory Stations"],["Inclination","dega","Trajectory Stations"],["md","ft","Trajectory Stations"],["tvd","ft","Trajectory Stations"],["Toolface Magnetic Angle","UNITLESS","Trajectory Stations"],["Toolface Gravity Angle","UNITLESS","Trajectory Stations"],["North","ft","Trajectory Stations"],["East","ft","Trajectory Stations"],["Vertical Section Distance","ft","Trajectory Stations"],["dls","UNITLESS","Trajectory Stations"],["Turn Rate","UNITLESS","Trajectory Stations"],["Build Rate","UNITLESS","Trajectory Stations"],["dMd","UNITLESS","Trajectory Stations"],["dTvd","UNITLESS","Trajectory Stations"],["Gravity Uncertainty","UNITLESS","Trajectory Stations"],["Dip Angle Uncertainty","UNITLESS","Trajectory Stations"],["Magnetic Uncertainty","UNITLESS","Trajectory Stations"],["gravitationFieldReference ","UNITLESS","Trajectory Stations"],["Magnetic Field Reference","UNITLESS","Trajectory Stations"],["Magnetic Dip Angle Reference","UNITLESS","Trajectory Stations"]]				
iot.server.contextual.data.auto.config.runner.frequency	60000				
iot.web.admin.uom.category	atom-allowed,atom,derived,prefixed,atom-special,atom-base				
iot.bigdata.store.provider.type	1				
iot.server.validate.brute.force	true				
yh.live.channel.last.timestamp.thresold	180000				
yh.server.index.channel.uom	ft				
rest.historicaldata.max.page.size	5000				
iot.server.backfilling.maximum.process.records.count	25000				
iot.server.kill.old.session	false				
iot.admin.web.device.manufacturer	UNKNOWN,NOV,H&P,3PS,MSC,PASON				
iot.appmonitor.server.port	8096				
iot.server.witsml.username	xxxxx				
yh.restore.mail.transfer.enable	true				
iot.server.adaptor.channel.frequency.threshold.limit	50				
iot.server.data.partition.enable	false				
yh.server.publisher.backfilling.enable	true				
yh.replay.use.wellinfo.channelid	false				
iot.server.backfilling.delta.percent	2				
iot.server.adaptor.channel.frequency.raise.event.recipients	user@company.com,user2@company.com				
iot.data.processor.thread.pool.size	500				
iot.server.publisher.rdbms.sync.batch.size	1000				
yh.server.integration.msteams.host	sigmastreamcom.webhook.office.com				
yh.monitoring.mail.notification.enable	false				
iot.session.async.send.timeout	10				
yh.data.file.path	AppData/data-files				
iot.wsocket.max.binary.message.buffer.size	32768				
iot.db.postgres.database	yellowhammer				
iot.data.bucketing.time.duration	H 				
iot.server.fat.collection.process.runner.interval	900000				
iot.data.backfilling.dump.restore.interval	60000				
iot.server.adaptor.allow.plcs	SIEMENS				
iot.web.admin.data.response.format	binary				
iot.web.admin.releasenote.version	releaseNotes-1.3.0.6,releaseNotes-1.3.0.8,releaseNotes-1.3.0.9,releaseNotes-1.3.0.10,releaseNotes-1.3.0.12,releaseNotes-1.4.1,releaseNotes-1.4.2,releaseNotes-1.4.3.GA,releaseNotes-1.4.4.GA				
yh.server.adaptor.witsml.publisher.provider.kongsberg.url	XXX				
yh.display.virtual.error.log	true				
yh.csv.default.location	../data-files/csv/sample-data.csv				
iot.server.data.restore.gb.free.memory	2				
yh.server.publisher.wsocket.backfill.enable	true				
iot.web.admin.source.mnemonic.types	COP,WITS				
yh.depth.index.channel.min.value	0.0				
rest.historicaldata.default.page.size	50				
yh.server.adaptor.witsml.publisher.provider.pason.username	XXX				
iot.server.fat.collection.process.auto.start.enable	true				
iot.server.auto.metadata.sync.well.status	active				
yh.monitoring.mail.starttls.enable	true				
iot.server.witsml.logtype	Date Time,Measured Depth				
asset.replication.mail.subjectline	Asset Replication Event				
iot.server.publisher.wellview.hd.key	HD				
iot.server.audit.dBType	PSQL				
yh.server.adaptor.witsml.device.logtypes.depthseries	Measured Depth				
yh.server.import.to.virtual.backfilling.enable	true				
yh.server.reconnect.datapush.on.misconfigure	false				
���##					
iot.server.witsml.data.source	Store				
iot.server.fat.pipe.subscription.allowed.adaptor.types	3PS,MODBUS,WITS,ADAMS,CSV				
yh.server.3ps.tare.enabled	true				
iot.web.admin.source.dbpath	../yellowhammer-db/sqlite/source_yellowhammer.db				
yh.adaptor.witsml.trajectory.standardization.enable	false				
yh.server.adaptor.witsml.publisher.provider.rockpigeon.username	PST				
yh.server.adaptor.witsml.device.provider.kongsberg.password	XXX				
yh.server.data.restore.scheduler.enable	true				
yh.server.local.storage.data.restore.source.availble.check.fast	true				
iot.admin.web.release	2.0.3 GA				
yh.display.restore.payload	true				
yh.wellbore.activity.name	Drilling,Tripping,WholeCleaning				
iot.server.witsml.servertypes	NOV				
iot.server.backfilling.device.types	WSocket				
iot.server.csv.device.nullvalues	34,6229.8696				
iot.server.contextual.data.auto.config.logname	Time_5Sec,Time_30Sec,Time_120Sec				
iot.subscription.cache.maxsize	50				
iot.input.modbus.slave.register.last.update.interval	300000				
iot.data.backfilling.dump.transfer.mode.zip	false				
iot.max.allowed.connection.count	100				
iot.web.socket.validate.asset	false				
yh.server.job.update.uom.cache.batch.count	50				
iot.server.contextual.data.auto.config.rigname	IPC 504				
iot.server.publisher.mqtt.clean.mqtt.client	true				
iot.server.publisher.mqtt.force.close.mqtt	true				
iot.web.admin.country	US				
yh.server.adaptor.witsml.device.provider.rockpigeon.password	SigmaStream				
yh.get.live.cache.device	false				
yh.server.adaptor.witsml.publisher.provider.nov.password	XXX				
iot.server.witsml.device.nullvalues	-999.25,-8888,-8888.0				
iot.web.admin.profile	SOURCE				
iot.server.wellinfo.based.discovery.enable	true				
yh.server.adaptor.witsml.device.trajectory.data131	[["nameWell","nameWell","UNITLESS","-999.25"],["nameWellbore","nameWellbore","UNITLESS","-999.25"],["dTimTrajStart","dTimTrajStart","UNITLESS","-999.25"],["dTimTrajEnd","dTimTrajEnd","UNITLESS","-999.25"],["serviceCompany","serviceCompany","UNITLESS","-999.25"],["memory","memory","UNITLESS","-999.25"],["aziRef","aziRef","UNITLESS","-999.25"],["depth","depth","m","-999.25"],["uid","uid","UNITLESS","-999.25"],["stn_uid","stn_uid","UNITLESS","-999.25"],["t_stn_base64","t_stn_base64","UNITLESS","-999.25"],["t_stn_md","t_stn_md","UNITLESS","-999.25"],["trajectoryName","trajectoryName","UNITLESS","-999.25"],["displayNameWell","displayNameWell","UNITLESS","-999.25"],["displayNameWellbore","displayNameWellbore","UNITLESS","-999.25"]]				
iot.server.witsml.versions	VERSION_1_3_1,VERSION_1_4_1_1				
yh.server.adaptor.witsml.device.provider.pason.password	CVTpilot$2020				
iot.waterwheel.thread.pool.size	2				
yh.server.adaptor.witsml.device.provider.pason.url	https://hub.us.pason.com/hub/witsml/store				
yh.historical.data.batch.processing.enable	false				
iot.mongodb.reader.notification.enable	false				
iot.db.postgres.password	SigmaStream#1				
iot.db.postgres.username	sigmastream				
iot.server.adaptor.reconnect.monitor.enable	true				
iot.server.sync.process.enable	true 				
iot.clean.mongodb.archived.data	false				
iot.streaming.data.runner.pool.size	5				
iot.server.data-push.device.nullvalues	-999.25,-9999,-9999.0,-9999.00,null,"null",-8888.00				
iot.web.admin.chunktransfer.mail.password	aaa				
iot.server.adaptor.allow.publishers	WSocket,Modbus,MQTT,RDBMS,WellView,WITSML				
iot.server.witsml.pollInterval	300				
iot.server.wellview.datawriter.updae.csv	true				
iot.data.persistance.pratition.startegy	Daily				
iot.rdbms.datasource.name	postgresql				
yh.server.adaptor.witsml.publisher.versions	VERSION_1_3_1_1,VERSION_1_4_1_1				
yh.server.adaptor.witsml.device.provider.nov.password	XXX				
iot.datapush.runner.pool.size	100				
iot.server.wsocket.device.nullvalues	-999.25,-9999,-9999.0,-8888,-8888.0,null				
yh.server.adaptor.witsml.publisher.logtypes.depthseries	measured depth				
yh.data.extraction.running.job.limit	2				
iot.db.postgres.port	5432				
yh.server.publisher.data.flow.monitor.enable	true				
yh.server.adaptor.witsml.device.provider.rockpigeon.url	http://146.24.37.83:9090/WITSMLStore/services/Store				
iot.server.log.manager.allow.logger	yhmodbusslave,modbus,wellview,csv,mongodb,wits,witsml,wsocket,mqtt,opcua,rdbms				
iot.data.mongodb.connection.size	500				
yh.server.backfilling.event.osticket.push.enable	false				
yh.data.device.reporting.channel					
yh.server.adaptor.witsml.publisher.provider	nov,pason,kongsberg,rockpigeon				
iot.server.publisher.wellview.hd.bd.hdbcDelta	2				
yh.publisher.auto.start.enable	false				
iot.server.witsml.password	xxxxx				
iot.wellview.send.server.payload	true				
iot.server.reload.historical.channel.stat.enable	true				
iot.server.licensekey.components	enp3s0,eno1,eth0				
yh.server.old.event.stream.enable	false				
iot.web.admin.submenuitems.asset	feedconfig,rig,bharun				
iot.admin.web.loglevel	Debug,Info,Error,Off				
yh.server.job.channel.statistics.update.time.millis	30000				
yh.server.publisher.check.refrence	true				
iot.data.backfilling.dump.transfer.interval	60000				
iot.appmonitor.server.hostname	localhost				
iot.shiro.password.encryption.base64.enabled	true 				
yh.server.job.data.device.update.time.millis	86400000				
iot.web.admin.submenuitems.usermanagement	users,userauth				
iot.server.restore.executor.hours.interval	12				
iot.server.auto.attach.device.with.bharun	true				
iot.web.admin.submenuitems.globalconfig	adams,opcda				
iot.server.witsml.data.download.wait.count	40				
yh.server.rest.log.growing.statuscheck.timeout.millis	600000				
yh.server.adaptor.witsml.publisher.provider.kongsberg.username	XXX				
iot.data.restore.event.recipients	support@sigmastream.com				
yh.server.integration.msteams.port	443				
iot.streaming.metadata.runner.pool.size	5				
iot.server.upgrade.process.historical.data.cleanup	false				
yh.server.adaptor.witsml.device.trajectory.data1411	[["nameWell","nameWell","UNITLESS","-999.25"],["nameWellbore","nameWellbore","UNITLESS","-999.25"],["dTimTrajStart","dTimTrajStart","UNITLESS","-999.25"],["dTimTrajEnd","dTimTrajEnd","UNITLESS","-999.25"],["serviceCompany","serviceCompany","UNITLESS","-999.25"],["memory","memory","UNITLESS","-999.25"],["aziRef","aziRef","UNITLESS","-999.25"],["depth","depth","m","-999.25"],["uid","uid","UNITLESS","-999.25"],["stn_uid","stn_uid","UNITLESS","-999.25"],["t_stn_base64","t_stn_base64","UNITLESS","-999.25"],["t_stn_md","t_stn_md","UNITLESS","-999.25"],["trajectoryName","trajectoryName","UNITLESS","-999.25"],["displayNameWell","displayNameWell","UNITLESS","-999.25"],["displayNameWellbore","displayNameWellbore","UNITLESS","-999.25"]]				
iot.web.admin.instance.name	YellowHammer-Server				
iot.max.pending.subscription.request.count	15				
yh.server.adaptor.force.nano.time.devices	CSV,MongoDB				
iot.server.contextual.auto.start.enable	true				
yh.server.adaptor.witsml.device.provider	nov,pason,kongsberg,rockpigeon				
yh.virtual.data.backfilling.min.speed	100				
iot.admin.web.device.model.number	v1.0				
iot.server.event.capture.enable	true				
iot.web.admin.submenuitems.datamanage	datamanagement,datatransfer,importmergedata,dataextraction				
iot.server.adaptor.allow.plcs.SIEMENS	7				
yh.server.adaptor.witsml.publisher.dataStreamingType	Log,Message,Trajectory				
iot.server.opcua.keep.alive.failure.allowed	5				
iot.app.monitor.server.port	8096 				
iot.server.contextual.data.cleanup.runner.frequency	1296000000				
iot.appmonitor.server.agent.email.notification.enable	true				
iot.server.publisher.rdbms.reconnect.interval	10000				
iot.upgrade.job.start.auto.enabled	false				
yh.server.adaptor.witsml.publisher.provider.nov.url	XXX				
yh.server.display.payload	false				
yh.server.adaptor.witsml.publisher.provider.pason.password	XXX				
yh.server.modules	rig,feedconfig,feedchannel,devicegraph,publishers,subscription,channelidentifier,uominfo,contextualdata,metadata,contextual,administration,versionupgrade,logmanager,users,datamanage,datamanagement,importmergedata,subscriptionconfig,usermanagement,userauth,dataextraction,backfilling,livescreen,liveconnection,historicalconnection				
iot.server.publisher.mqtt.close.mqtt.client	false				
yh.server.adaptor.websocket.pollinterval.multiplier	3				
iot.server.witsml.device.last.stream.enable	true				
iot.server.witsml.firefox.driver	../resources/geckodriver				
iot.server.auto.datafeed.retry.max.limit	5				
iot.server.auto.datafeed.retry.interval	2000				
iot.json.response.max.packet.size	128				
iot.witsml.data.monitor.interval	5000				
iot.web.admin.language.us	en				
yh.server.adaptor.witsml.publisher.provider.rockpigeon.password	SigmaStream				
iot.web.admin.menuitems	rig,feedconfig,publishers,channelidentifier,uominfo,users,contextualdata,administration,datamanage				
yh.server.adaptor.witsml.device.logtypes.timeseries	date time				
yh.server.data.export.delete.job.collection	true				
iot.web.admin.data.request.format	binary				
yh.server.publisher.data.flow.monitor.msteams.push.enable	false				
yh.server.publisher.data.flow.monitor.interval	180000				
iot.server.wits.device.nullvalues	-9999,-9999.0				
yh.server.adaptor.witsml.device.dataStreamingType	Log,Message,Trajectory				
iot.server.multiwell.supported	false				
iot.server.witsml.device.data.range	15,30,60,120,1440				
iot.server.data.metrics.capture.enable	false				
iot.server.yellowhammerapi.connection.enable	false				
yh.server.adaptor.witsml.publisher.provider.rockpigeon.url	http://127.0.0.1:9090/WITSMLStore/services/Store				
iot.appmonitor.channel.mail.title	Wake up, This Is Monitoring Alarm..				
yh.server.session.ping.time.diff	1000				
iot.web.admin.retention.days	1				
yh.server.adaptor.witsml.publisher.logtypes.timeseries	date time				
iot.wellview.database.path	../yellowhammer-db/mdb/wvdatabase.mdb				
iot.server.audit.enabled	true				
iot.web.admin.chunktransfer.mail.host	aaa.aaa.a.aaa				
iot.server.data.restore.directory.executor.hours.interval	5				
yh.publisher.automation.config.file	/sigmastream/yellowhammer/yellowhammer-server/yellowhammer-base/template/publisher_configuration.json				
yh.monitoring.mail.host	email.securesrvr.com				
yh.load.max.connection.card.limit	30				
iot.data.backfilling.max.message.size	32768				
iot.server.restore.raw.data.mnemonics	T_3PS1_P1_timestamp|T_3PS1_P1_Battery|T_3PS1_P1_usec|T_3PS1_X1_Battery				
iot.server.witsml.servertype	NOV				
iot.web.admin.submenuitems.administration	logmanager				
iot.server.backfilling.auto.run.enable	false				
iot.backup.device.mail.subjectline	Backup Process Issue				
yh.wellbore.metadata.name	Block,Operator,Operator Division,Well Purpose ,Well Datum,Name,Code,Rig Reference,MetaData1,MetaData2,MetaData3				
iot.server.adaptor.auto.start.enable	true				
iot.wsocket.max.text.message.buffer.size	32768				
yh.data.import.merge.mongo.interval	10				
iot.server.contextual.data.cleanup.process.enable	false				
iot.server.publisher.rdbms.ts.column.name	TS				
iot.server.data.restore.checked.free.memory.enable	false				
iot.wsocket.max.connection.request.session	60				
iot.wsocket.max.binary.message.size	1048576				
iot.web.admin.pcap.utility.enable	false				
iot.adams.adaptor.config.file.path	AppData/adams-config.properties 				
iot.server.contextual.data.auto.config.channels	BIT_DEPTH:m,TOT_DPT_MD:m,TD_SPEED:rpm,BLOCK_POS:m,HOOKLOAD_MAX:klb,TOT_SPM:SPM,TD_TORQUE:ft.lbf,RIGTIME:DateTime				
iot.server.witsml.trajectory.data1411	[["mdMin","ft","Trajectory"],["mdMax","ft","Trajectory"],["Magnetic Angle","UNITLESS","Trajectory"],["Grid Correction","UNITLESS","Trajectory"],["Azimuth of Vertical Section","denga","Trajectory"],["NS","ft","Trajectory"],["EW","ft","Trajectory"],["Azimuth","dega","Trajectory Stations"],["Inclination","dega","Trajectory Stations"],["md","ft","Trajectory Stations"],["tvd","ft","Trajectory Stations"],["Toolface Magnetic Angle","UNITLESS","Trajectory Stations"],["Toolface Gravity Angle","UNITLESS","Trajectory Stations"],["North","ft","Trajectory Stations"],["East","ft","Trajectory Stations"],["Vertical Section Distance","ft","Trajectory Stations"],["dls","UNITLESS","Trajectory Stations"],["Turn Rate","UNITLESS","Trajectory Stations"],["Build Rate","UNITLESS","Trajectory Stations"],["dMd","UNITLESS","Trajectory Stations"],["dTvd","UNITLESS","Trajectory Stations"],["Gravity Uncertainty","UNITLESS","Trajectory Stations"],["Dip Angle Uncertainty","UNITLESS","Trajectory Stations"],["Magnetic Uncertainty","UNITLESS","Trajectory Stations"],["gravitationFieldReference ","UNITLESS","Trajectory Stations"],["Magnetic Field Reference","UNITLESS","Trajectory Stations"],["Magnetic Dip Angle Reference","UNITLESS","Trajectory Stations"]]				
yh.historical.data.persist.null	false				
iot.server.auto.deploy.enable	true				
iot.source.logger.filepath	logger/log4j2.properties				
iot.server.audit.batch.count	100				
iot.chunk.discovery.enable	false				
iot.server.data.insertion.batch.size.factor	0.25				
iot.websocket.keep.alive.message	ping				
yh.publisher.self.connection.enable	true				
iot.server.device.graph.thread.pool.zise	50				
yh.info.debug.log.enable	false				
iot.appmonitor.device.mail.subjectline	Appmonitor Event - Device is disconnected				
yh.wsocket.adaptor.allow.device.types	DATA-PUSH,CSV,Modbus,WITS,WSocket,MongoDB,MQTT,WITSML,OPCUA,RDBMS				
iot.web.admin.submenuitems.contextualdata	metadata,contextual				
iot.admin.web.section.type	Horizontal,Vertical,Curve-Lateral,Twistoff				
iot.server.adaptor.channel.frequency.monitor.enable	false				
yh.load.connection.card.limit	4				
yh.server.asset.backfill.loadcompleted.job.enable	true				
iot.wellview.writer.directory.path	/sigmastream/yellowhammer/yellowhammer-server/data-files/SNDREPORT				
iot.server.discovery.executor.hours.interval	1				
iot.server.adaptor.allow.devices	CSV,Modbus,WITS,WSocket,MongoDB,OPCUA,WITSML,RDBMS				
yh.server.adaptor.witsml.device.versions	VERSION_1_3_1_1,VERSION_1_4_1_1				
iot.data.default.well.name	YHWell				
yh.server.job.refresh.ahead.cache.time.millis	1800000				
iot.admin.csv.import.process.batchCount	100				
iot.subscription.cache.expire.age	60				
iot.server.network.data.queue.capacity	5				
yh.server.backfilling.event.msteams.push.enable	true				
iot.server.adaptor.channel.frequency.monitor.timer.interval	30000				
iot.server.opcua.request.timeout.milliseconds	15000				
iot.server.backfill.process.enable	true				
iot.admin.chunktransfer.directory.path	../data-files/				
yh.server.adaptor.witsml.publisher.provider.kongsberg.password	XXX				
yh.server.adaptor.upsert.data.devices	WITSML				
yh.monitoring.mail.username	user@company.com				
yh.monitoring.mail.password	xxxxxx				
yh.server.data.export.sleeptime.limit	1				
iot.server.licensekey	SS-YHSE-S-20230601-bWNHY1ppSG5tbW1LbWNHY1ppSG5tbW1Lfm5tfkhiSktiSHZjR0d2dnY=				
yh.server.integration.msteams.apiKey	8c78ee27-09f8-47d9-a0ba-80cc98d76acb@9c6e8818-9573-4af1-a3f4-2d19bf10a063/IncomingWebhook/7ba6245e63244409bf7cfd7fb556d0d4/f90de748-57d3-4413-b55b-7823fb480540				
iot.server.backfilling.interval	700000				
iot.session.timeout	300000				
iot.data.mongodb.hostname	mongodb				
iot.data.backfilling.record.limit	1000				
iot.appmonitor.device.mail.title	Wake up, This Is Monitoring Alarm..				
iot.sqllite.connection.timeout	10				
iot.update.metadata.asset.list	HnPWell,TestWell				
iot.server.data.persisitence.thread.pool.factor	5				
iot.subcription.cache.expire.age	60				
iot.server.backfilling.subscribe.request.speedupfactor	2				
iot.db.sqLite.enabled	true				
iot.server.auto.update.endtime.enable	false				
yh.server.adaptor.witsml.device.provider.kongsberg.url	XXX				
yh.server.publisher.data.flow.monitor.osticket.push.enable	false				
iot.appmonitor.server.agent.enable	true				
iot.server.witsml.tubular.data	{"tubulars":{"version":1,"typeTubularAssy":"drilling","tubular":[{"description":"Drill string","sequence":1,"typeTubularComp":"Composite","tubularComponents":[{"description":"5 1/2 inch DP  - 21.90 lb/ft - HT55","sequence":1,"typeTubularComp":"Composite","repeat":99,"tubularComponent":[{"gender":"Box","sequence":1,"typeTubularComp":"Connection","repeat":1,"materialInfo":{"length":{"uom":"m","val":"0.3174492"},"od":{"uom":"mm","val":184.15},"id":{"uom":"mm","val":98.425},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}}},{"sequence":2,"typeTubularComp":"Upset","repeat":1,"materialInfo":{"length":{"uom":"m","val":"0.1199388"},"od":{"uom":"mm","val":152.4},"id":{"uom":"mm","val":98.425},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}}},{"sequence":3,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"8.4539328"},"od":{"uom":"mm","val":139.7},"id":{"uom":"mm","val":121.3612},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}}},{"sequence":4,"typeTubularComp":"Upset","repeat":1,"materialInfo":{"length":{"uom":"m","val":"0.1199388"},"od":{"uom":"mm","val":152.4},"id":{"uom":"mm","val":98.425},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}}},{"gender":"Pin","sequence":5,"typeTubularComp":"Connection","repeat":1,"materialInfo":{"length":{"uom":"m","val":"0.3174492"},"od":{"uom":"mm","val":184.15},"id":{"uom":"mm","val":98.425},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}}}]},{"description":"Bottom Hole Assembly","sequence":2,"typeTubularComp":"Composite","repeat":1,"tubularComponent":[{"sequence":16,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"0.252984"},"od":{"uom":"mm","val":228.6},"id":{"uom":"mm","val":57.15},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"9 1/2 inch TCI bit"},{"sequence":15,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"7.571232"},"od":{"uom":"mm","val":177.8},"id":{"uom":"mm","val":131.064},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"Xceed 950 rot steerabe"},{"sequence":14,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"3.910584"},"od":{"uom":"mm","val":177.8},"id":{"uom":"mm","val":50.8},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"GeoSphere 675 Transmitter"},{"sequence":13,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"7.918704"},"od":{"uom":"mm","val":177.8},"id":{"uom":"mm","val":98.425},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"EcoScope w/ 9 3/8 inch Stabilizer"},{"sequence":12,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"4.011168"},"od":{"uom":"mm","val":177.8},"id":{"uom":"mm","val":50.8},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"GeoSphere 675 Receiver"},{"sequence":11,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"8.363712"},"od":{"uom":"mm","val":171.45},"id":{"uom":"mm","val":98.425},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"TeleScope 675 NF"},{"sequence":10,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"4.011168"},"od":{"uom":"mm","val":177.8},"id":{"uom":"mm","val":123.825},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"GeoSphere 675 Receiver"},{"sequence":9,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"3.79476"},"od":{"uom":"mm","val":177.8},"id":{"uom":"mm","val":123.825},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"OptiDrill 675-BA"},{"sequence":8,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"1.524"},"od":{"uom":"mm","val":171.45},"id":{"uom":"mm","val":71.3743},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"6.75 inch Misc. Sub 5"},{"sequence":7,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"0.938784"},"od":{"uom":"mm","val":171.45},"id":{"uom":"mm","val":69.85},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"NM Float Sub Non Ported flapper type"},{"sequence":6,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"4.572"},"od":{"uom":"mm","val":171.45},"id":{"uom":"mm","val":69.85},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"7 inch DAV MX Dart Catcher & Circulation Sub"},{"sequence":5,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"9.079992"},"od":{"uom":"mm","val":152.4},"id":{"uom":"mm","val":71.374},"materialDensity":{"uom":"kg/m3","val":8850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"5 inch NM Heavy Weight Drill Pipe"},{"sequence":4,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"9.595104"},"od":{"uom":"mm","val":152.4},"id":{"uom":"mm","val":69.85},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"Jar"},{"sequence":3,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"9.363456"},"od":{"uom":"mm","val":139.7},"id":{"uom":"mm","val":76.2},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"5 inch Heavy Weight Drill Pipe"},{"sequence":2,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"0.950976"},"od":{"uom":"mm","val":171.45},"id":{"uom":"mm","val":69.85},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"Churchill Drift Sub 3.12"},{"sequence":1,"typeTubularComp":"Body","repeat":1,"materialInfo":{"length":{"uom":"m","val":"1.524"},"od":{"uom":"mm","val":171.45},"id":{"uom":"mm","val":57.15},"materialDensity":{"uom":"kg/m3","val":7850},"shearModulus":{"uom":"N/m2","val":79600000000},"hysteresisDelta":{"uom":"Ns/m4","val":300000000},"kappaWall":{"uom":"Ns/m3","val":3}},"description":"X-over Sub NC-50 Pin to HT55 Box"}]}]}]}}				
iot.web.admin.chunktransfer.mail.sender	user@company.com				
iot.appmonitor.channel.mail.subjectline	Appmonitor Event - Channle is not producing data at desired freq				
iot.server.wits.sleep.singleton.time	5000				
iot.web.admin.centric.type	AssetCentric				
iot.app.monitor.server.hostname	localhost 				
iot.server.device.channel.endtime.update.interval	3600000				
iot.server.fat.pipe.subscription.allow.devices	WITS,CSV,WSocket,RDBMS,WITSML,OPCUA,Modbus,DATA-PUSH				
iot.server.adaptor.reconnect.raise.event.recipients	support@sigmastream.com				
yh.data.extract.max.frequency	10				
iot.server.adaptor.channel.frequncy.monitor.enable	true 				
iot.server.update.info.collection.check.interval	900000				
iot.web.permissions.dependent.modules	adaptorconfig|feedconfig				
yh.monitoring.mail.authentication.enable	true				
asset.replication.mail.title	Process is completed successfully				
iot.server.logger.level.change.interval	300000				
iot.data.default.wellbore.name	YHWellbore				
iot.server.backfill.channel.stats.interval	600000				
iot.server.adaptor.auto.archived.enable	false				
iot.profiles.mnemonics.type	COP				
yh.server.job.gap.analysis.update.time.millis	1000				
iot.server.auto.deploy.dir	AppData/deploy				
iot.dcm.message.handler.pool.size	1 				
iot.server.fix.depth.index.enable	false				
iot.web.admin.importexport.enable	false				
yh.device.status.streaming.enable	false				
iot.data.backfilling.socket.timeout	10000				
iot.web.admin.chunktransfer.mail.port	aaa				
iot.data.default.rig.name	YHRig				
yh.server.adaptor.witsml.publisher.provider.pason.url	XXX				
yh.monitoring.mail.port	965				
iot.server.publisher.rdbms.sync.lastts.name	LASTTS				
iot.server.publisher.rdbms.max.thread.pool.size	100				
iot.appmonitor.channel.mail.sender	donotreply@mailserver.com				
iot.server.publisher.wsocket.filter.null.enable	true				
iot.subcription.cache.maxsize	50				
iot.server.witsml.url	https://witsml.welldata.net//witsml//wmls.asmx				
yh.server.adaptor.channel.monitor.msteams.push.enable	false				
iot.server.publisher.wsocket.push.interval.milli	-1				
yh.server.job.keep.inventory.uom.in.cache	false				
yh.server.adaptor.witsml.device.provider.nov.url	XXX				
iot.db.connection.pool.type	hikari				
iot.server.restore.raw.devices.mnemonics	P1_Battery|X1_Acceleration X (G)|X1_Battery|P1_usec				
iot.restore.device.mail.subjectline	Restore Process Issue				
yh.server.adaptor.witsml.device.provider.kongsberg.username	XXX				
yh.contextual.device.config.path	AppData/template/contextual				
iot.rest.session.timeout.interval	1800000				
iot.server.witsml.live.data	false				
yh.publisher.debug.log.enable	true				
asset.replication.mail.sender	user@company.com				
iot.admin.web.device.type	UNKNOWN,EMS,STRINGSENSE,3PS,ADAMS				
iot.upgrade.job.start.delayed	0				
iot.data.backup.instance.name	RIG_NAME_HERE				
iot.server.contextual.data.auto.config.enable	true				
yh.server.adaptor.prevent.auto.start.devices	WITS,WITSML,CSV				
iot.db.postgres.maxActive	10				
iot.server.publisher.wsocket.merge.interval.milli	-1				
iot.server.not.allow.device.copy.channels	DATA-PUSH				
yh.server.integration.msteams.enable	false				
iot.server.max.tolerance.session.time.sec	600000				
yh.server.cluster.environment.setup	false				
yh.server.auto.switch.well.enable	false				
iot.wsocket.input.buffer.size	32768				
iot.wsocket.max.text.message.size	1048576				
yh.data.mount.path	AppData			\N	\N
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.assets (id, wellid, rigid, api, uwi, companyuwi, commonname, legalname, field, lease, district, region, county, state, country, latitude, longitude, easting, northing, crs, elevationkb, elevationground, spuddate, completiondate, created_user_profile, delete_status, active_status, welldata_capture, updatedon) FROM stdin;
1	DEMO_WELL	1	49eb353e-7238-4547-9d86-26030afe8d51	49eb353e-7238-4547-9d86-26030afe8d51	49eb353e-7238-4547-9d86-26030afe8d51	DEMO_WELL								US	0.0	0.0	0.0	0.0	AGD66	0.0	0.0			SOURCE	\N	N	N	
\.


--
-- Data for Name: attributerules; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.attributerules (id, attributeid, ruletype, name, weight, value, timeout, description, status) FROM stdin;
2833	1	POTENTIAL	WITSMLNOV	0		500000		0
2834	1	POTENTIAL	WITSMLPason	0		500000		0
2835	1	POTENTIAL	WellViewPeloton	0		500000		0
2836	1	QUALITY	REGEXP	0	^[0-9]	0		0
2837	1	QUALITY	RANGE	0	12.0-18.0	0		0
2838	3	POTENTIAL	WITSMLNOV	0		500000		0
2839	3	POTENTIAL	WITSMLPason	0		500000		0
2840	3	POTENTIAL	WellViewPeloton	0		500000		0
2841	3	QUALITY	REGEXP	0	^[0-9]	0		0
2842	4	QUALITY	REGEXP	0	^[0-9]	0		0
2843	4	POTENTIAL	WITSMLNOV	0		500000		0
2844	4	POTENTIAL	WITSMLPason	0		500000		0
2845	4	POTENTIAL	WellViewPeloton	0		500000		0
2846	5	QUALITY	REGEXP	0	^[0-9]	0		0
2847	5	POTENTIAL	WITSMLNOV	0		500000		0
2848	5	POTENTIAL	WITSMLPason	0		500000		0
2849	5	POTENTIAL	WellViewPeloton	0		500000		0
2850	6	QUALITY	REGEXP	0	^[0-9]	0		0
2851	6	POTENTIAL	WITSMLNOV	0		500000		0
2852	6	POTENTIAL	WITSMLPason	0		500000		0
2853	6	POTENTIAL	WellViewPeloton	0		500000		0
2854	7	QUALITY	REGEXP	0	^[0-9]	0		0
2855	7	QUALITY	RANGE	0	12.0-18.0	0		0
2856	7	POTENTIAL	WITSMLNOV	0		500000		0
2857	7	POTENTIAL	WITSMLPason	0		500000		0
2858	7	POTENTIAL	WellViewPeloton	0		500000		0
2859	8	QUALITY	REGEXP	0	^[0-9]	0		0
2860	8	POTENTIAL	WITSMLNOV	0		500000		0
2861	8	POTENTIAL	WITSMLPason	0		500000		0
2862	8	POTENTIAL	WellViewPeloton	0		500000		0
2863	9	QUALITY	REGEXP	0	^[0-9]	0		0
2864	9	QUALITY	RANGE	0	12.0-18.0	0		0
2865	9	POTENTIAL	WITSMLNOV	0		500000		0
2866	9	POTENTIAL	WITSMLPason	0		500000		0
2867	9	POTENTIAL	WellViewPeloton	0		500000		0
2868	10	QUALITY	REGEXP	0	^[0-9]	0		0
2869	10	QUALITY	RANGE	0	12.0-18.0	0		0
2870	10	POTENTIAL	WITSMLNOV	0		500000		0
2871	10	POTENTIAL	WITSMLPason	0		500000		0
2872	10	POTENTIAL	WellViewPeloton	0		500000		0
2873	11	QUALITY	REGEXP	0	^[0-9]	0		0
2874	11	QUALITY	RANGE	0	12.0-18.0	0		0
2875	11	POTENTIAL	WITSMLNOV	0		500000		0
2876	11	POTENTIAL	WITSMLPason	0		500000		0
2877	11	POTENTIAL	WellViewPeloton	0		500000		0
2878	12	QUALITY	REGEXP	0	^[0-9]	0		0
2879	12	QUALITY	RANGE	0	12.0-18.0	0		0
2880	12	POTENTIAL	WITSMLNOV	0		500000		0
2881	12	POTENTIAL	WITSMLPason	0		500000		0
2882	12	POTENTIAL	WellViewPeloton	0		500000		0
2883	13	QUALITY	REGEXP	0	^[0-9]	0		0
2884	13	QUALITY	RANGE	0	12.0-18.0	0		0
2885	13	POTENTIAL	WITSMLNOV	0		500000		0
2886	13	POTENTIAL	WITSMLPason	0		500000		0
2887	13	POTENTIAL	WellViewPeloton	0		500000		0
2888	14	QUALITY	REGEXP	0	^[0-9]	0		0
2889	14	QUALITY	RANGE	0	12.0-18.0	0		0
2890	14	POTENTIAL	WITSMLNOV	0		500000		0
2891	14	POTENTIAL	WITSMLPason	0		500000		0
2892	14	POTENTIAL	WellViewPeloton	0		500000		0
2893	15	QUALITY	REGEXP	0	^[0-9]	0		0
2894	15	QUALITY	RANGE	0	12.0-18.0	0		0
2895	15	POTENTIAL	WITSMLNOV	0		500000		0
2896	15	POTENTIAL	WITSMLPason	0		500000		0
2897	15	POTENTIAL	WellViewPeloton	0		500000		0
2898	16	QUALITY	REGEXP	0	^[0-9]	0		0
2899	16	QUALITY	RANGE	0	12.0-18.0	0		0
2900	16	POTENTIAL	WITSMLNOV	0		500000		0
2901	16	POTENTIAL	WITSMLPason	0		500000		0
2902	16	POTENTIAL	WellViewPeloton	0		500000		0
2903	17	QUALITY	REGEXP	0	^[0-9]	0		0
2904	17	QUALITY	RANGE	0	12.0-18.0	0		0
2905	17	POTENTIAL	WITSMLNOV	0		500000		0
2906	17	POTENTIAL	WITSMLPason	0		500000		0
2907	17	POTENTIAL	WellViewPeloton	0		500000		0
2908	18	QUALITY	REGEXP	0	^[0-9]	0		0
2909	18	QUALITY	RANGE	0	12.0-18.0	0		0
2910	18	POTENTIAL	WITSMLNOV	0		500000		0
2911	18	POTENTIAL	WITSMLPason	0		500000		0
2912	18	POTENTIAL	WellViewPeloton	0		500000		0
2913	19	QUALITY	REGEXP	0	^[0-9]	0		0
2914	19	QUALITY	RANGE	0	12.0-18.0	0		0
2915	19	POTENTIAL	WITSMLNOV	0		500000		0
2916	19	POTENTIAL	WITSMLPason	0		500000		0
2917	19	POTENTIAL	WellViewPeloton	0		500000		0
2918	20	QUALITY	REGEXP	0	^[0-9]	0		0
2919	20	QUALITY	RANGE	0	12.0-18.0	0		0
2920	20	POTENTIAL	WITSMLNOV	0		500000		0
2921	20	POTENTIAL	WITSMLPason	0		500000		0
2922	20	POTENTIAL	WellViewPeloton	0		500000		0
2923	21	QUALITY	REGEXP	0	^[0-9]	0		0
2924	21	QUALITY	RANGE	0	12.0-18.0	0		0
2925	21	POTENTIAL	WITSMLNOV	0		500000		0
2926	21	POTENTIAL	WITSMLPason	0		500000		0
2927	21	POTENTIAL	WellViewPeloton	0		500000		0
115	0	QUALITY	REGEXP	0	^[0-9]	0		0
116	0	POTENTIAL	WITSMLNOV	0		500000		0
117	0	POTENTIAL	WITSMLPason	0		500000		0
118	0	POTENTIAL	WellViewPeloton	0		500000		0
2928	22	QUALITY	REGEXP	0	^[0-9]	0		0
2929	22	QUALITY	RANGE	0	12.0-18.0	0		0
2930	22	POTENTIAL	WITSMLNOV	0		500000		0
2931	22	POTENTIAL	WITSMLPason	0		500000		0
2932	22	POTENTIAL	WellViewPeloton	0		500000		0
2933	23	POTENTIAL	WITSMLNOV	0		500000		0
2934	23	POTENTIAL	WITSMLPason	0		500000		0
2935	23	POTENTIAL	WellViewPeloton	0		500000		0
2936	23	QUALITY	REGEXP	0	^[0-9]	0		0
2937	23	QUALITY	RANGE	0	12.0-18.0	0		0
2938	24	POTENTIAL	WITSMLNOV	0		500000		0
2939	24	POTENTIAL	WITSMLPason	0		500000		0
2940	24	POTENTIAL	WellViewPeloton	0		500000		0
2941	24	QUALITY	REGEXP	0	^[0-9]	0		0
2942	24	QUALITY	RANGE	0	12.0-18.0	0		0
2943	25	QUALITY	REGEXP	0	^[0-9]	0		0
2944	25	POTENTIAL	WITSMLNOV	0		500000		0
2945	25	POTENTIAL	WITSMLPason	0		500000		0
2946	25	POTENTIAL	WellViewPeloton	0		500000		0
2947	26	QUALITY	REGEXP	0	^[0-9]	0		0
2948	26	POTENTIAL	WITSMLNOV	0		500000		0
2949	26	POTENTIAL	WITSMLPason	0		500000		0
2950	26	POTENTIAL	WellViewPeloton	0		500000		0
\.


--
-- Data for Name: attributes; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.attributes (id, entityid, name, editable, isrequired, latestvalue, quorumenable, instantupdate, description, status) FROM stdin;
1	1	name	t	t	\N	f	f	\N	0
2	1	created_user_profile	t	f	\N	f	t	\N	0
3	1	drillingContractor	t	t	\N	f	f	\N	0
4	2	api	t	f	\N	f	f	\N	0
5	2	uwi	t	f	\N	f	f	\N	0
6	2	companyUWI	t	f	\N	f	f	\N	0
7	2	commonName	t	f	\N	f	f	\N	0
8	2	legalName	t	f	\N	f	f	\N	0
9	2	field	t	f	\N	f	f	\N	0
10	2	lease	t	f	\N	f	f	\N	0
11	2	district	t	f	\N	f	f	\N	0
12	2	region	t	f	\N	f	f	\N	0
13	2	county	t	f	\N	f	f	\N	0
14	2	country	t	f	\N	f	f	\N	0
15	2	latitude	t	f	\N	f	f	\N	0
16	2	longitude	t	f	\N	f	f	\N	0
17	2	northing	t	f	\N	f	f	\N	0
18	2	crs	t	f	\N	f	f	\N	0
19	2	elevationKB	t	f	\N	f	f	\N	0
20	2	elevationGround	t	f	\N	f	f	\N	0
21	2	spudDate	t	f	\N	f	f	\N	0
22	2	completionDate	t	f	\N	f	f	\N	0
23	2	wellID	t	f	\N	f	f	\N	0
24	2	state	t	t	\N	t	t	\N	0
25	3	name	t	f	\N	f	f	\N	0
26	4	bhaRunNumber	t	f	\N	f	f	\N	0
\.


--
-- Data for Name: attributevalues; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.attributevalues (id, attributeid, sourcename, value, "timestamp") FROM stdin;
\.


--
-- Data for Name: bha_run; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.bha_run (bharunid, sectionid, bharunnumber, created_user_profile, delete_status, active_status) FROM stdin;
1	1	11	SOURCE	\N	N
3	3	12	SOURCE	\N	N
\.


--
-- Data for Name: bharun_feed; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.bharun_feed (bharun_feed_id, bharunid, feed_id, delete_status, created_user_profile) FROM stdin;
1	1	1	\N	SOURCE
\.


--
-- Data for Name: channel_identifier; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.channel_identifier (channelidentifierid, description, longmnemonic, shortmnemonic, itemtype, itemlength, metricunits, fpsunits, type, created_user_profile, issi) FROM stdin;
1	Acetylene	ACET	ACET	L	4	PPM	PPM	WITS	SOURCE	N
2	Activity Code	ACTCOD	ACTC	S	2	----	----	WITS	SOURCE	N
3	Air Temperature	AIRTEMP	AIRT	F	4	DEGC	DEGF	WITS	SOURCE	N
4	Anemometer Height	ANEMHGHT	ANEM	F	4	M	F	WITS	SOURCE	N
5	Annular Velocity (min)	AVELN	AVN	F	4	M/S	FPM	WITS	SOURCE	N
6	Annular Velocity (max)	AVELX	AVX	F	4	M/S	FPM	WITS	SOURCE	N
7	Barometric Pressure	BARPRES	BARP	F	4	KPA	IHG	WITS	SOURCE	N
8	Bit IADC Code	BTCODE	BCOD	A	8	----	----	WITS	SOURCE	N
9	Bit Comments	BTCOMM	BCOM	A	128	----	----	WITS	SOURCE	N
10	Bit Cost	BTCOST	BCST	F	4	$	$	WITS	SOURCE	N
11	Bit Drilled Distance	BTDDIST	BDDI	F	4	M	F	WITS	SOURCE	N
12	Bulk Density	BULKDEN	BDEN	F	4	G/CC	G/CC	WITS	SOURCE	N
13	Bit Diameter	BTDIAM	BDIA	F	4	MM	IN	WITS	SOURCE	N
14	Bit Starting Depth (In)	BTDEPIN	BDPI	F	4	M	F	WITS	SOURCE	N
15	Bit Ending Depth (Out)	BTDEPOUT	BDPO	F	4	M	F	WITS	SOURCE	N
16	Bit Drilled Time	BTDTIME	BDTI	F	4	HR	HR	WITS	SOURCE	N
17	Bit Grade In	BTGRDIN	BGI	A	16	----	----	WITS	SOURCE	N
18	Bit Grade Out	BTGRDOUT	BGO	A	16	----	----	WITS	SOURCE	N
19	Bit Hydraulic Power	BHP	BHP	F	4	KW	HP	WITS	SOURCE	N
20	Bit Hydraulic Power/Area	BHPA	BHPA	F	4	KWM2	HSI	WITS	SOURCE	N
21	Bit Jet 1 Diameter	BTJET1	BJT1	F	4	MM	I/32	WITS	SOURCE	N
22	Bit Jet 2 Diameter	BTJET2	BJT2	F	4	MM	I/32	WITS	SOURCE	N
23	Bit Jet 3 Diameter	BTJET3	BJT3	F	4	MM	I/32	WITS	SOURCE	N
24	Bit Jet 4 Diameter	BTJET4	BJT4	F	4	MM	I/32	WITS	SOURCE	N
25	Bit Center Jet Diameter	BTJETCEN	BJTC	F	4	MM	I/32	WITS	SOURCE	N
26	Bit Manufacturer	BTMANUF	BMAN	A	16	----	----	WITS	SOURCE	N
27	Bit Mud Density (avg)	BTMDA	BMDA	F	4	KGM3	PPG	WITS	SOURCE	N
28	Bit Mud Flow Rate (avg)	BTMFA	BMFA	F	4	L/M	GPM	WITS	SOURCE	N
29	Bit Mud Motor Used ?	BTMUDMOT	BMM	A	1	----	----	WITS	SOURCE	N
30	Bit Name	BTNAME	BNAM	A	16	----	----	WITS	SOURCE	N
31	Bit Number	BTNUM	BNUM	A	8	----	----	WITS	SOURCE	N
32	Block Position	BLKPOS	BPOS	F	4	M	F	WITS	SOURCE	N
33	Bit Reason Pulled	BTPULL	BPUL	A	16	----	----	WITS	SOURCE	N
34	Bit Rotary Speed (avg)	BTRPMA	BRMA	S	2	RPM	RPM	WITS	SOURCE	N
35	Bit Rotary Speed (max)	BTRPMX	BRMX	S	2	RPM	RPM	WITS	SOURCE	N
36	Bit Penetration Rate (avg)	BTROPA	BRPA	F	4	M/HR	F/HR	WITS	SOURCE	N
37	Bit Run Reamed Time	BTRTIME	BRTI	F	4	HR	HR	WITS	SOURCE	N
38	Bit Reason Run	BTRUN	BRUN	A	16	----	----	WITS	SOURCE	N
39	Bit Revolutions (cum)	BTREVC	BRVC	L	4	----	----	WITS	SOURCE	N
40	Bit Serial Number	BTSERNUM	BSER	A	16	----	----	WITS	SOURCE	N
41	Bit Shock Sub Used ?	BTSHKSUB	BSHK	A	1	----	----	WITS	SOURCE	N
42	Bit Standpipe Pressure (avg)	BTSPPA	BSPA	F	4	KPA	PSI	WITS	SOURCE	N
43	Bit Total Flow Area	BTTFA	BTFA	F	4	MM2	SQIN	WITS	SOURCE	N
44	Bit Weight-on-Bit (avg)	BTWOBA	BWBA	F	4	KDN	KLB	WITS	SOURCE	N
45	Bit Weight-on-Bit (max)	BTWOBX	BWBX	F	4	KDN	KLB	WITS	SOURCE	N
46	Cavings %	CAVINGS	CAV	S	2	%	%	WITS	SOURCE	N
47	Cem Volume to Bump Plug	CEMBPVOL	CBVL	F	4	M3	BBL	WITS	SOURCE	N
48	Calcimetry Calcite %	CCAL	CCAL	F	4	%	%	WITS	SOURCE	N
49	Cem Cumulative Returns	CEMCUMRT	CCRT	F	4	M3	BBL	WITS	SOURCE	N
50	Cem Cement Vol Pumped	CEMCVOL	CCVL	F	4	M3	BBL	WITS	SOURCE	N
51	Cem Fluid Dens In (avg)	CEMDIA	CDIA	F	4	KGM3	PPG	WITS	SOURCE	N
52	Current Direction	CURRDIR	CDIR	F	4	DEG	DEG	WITS	SOURCE	N
53	Cem Fluid Dens Out (avg)	CEMDOA	CDOA	F	4	KGM3	PPG	WITS	SOURCE	N
54	Calcimetry Dolomite %	CDOL	CDOL	F	4	%	%	WITS	SOURCE	N
55	Connections Done	CONNDONE	CDON	S	2	----	----	WITS	SOURCE	N
56	Cuttings CEC	CEC	CEC	F	4	MEHG	MEHG	WITS	SOURCE	N
57	Cem Flow Rate In (avg)	CEMFIA	CFIA	F	4	M3/M	BPM	WITS	SOURCE	N
58	Cem Flow Rate In (calc)	CEMFIC	CFIC	F	4	M3/M	BPM	WITS	SOURCE	N
59	Cem Flow Rate Out (avg)	CEMFOA	CFOA	F	4	M3/M	BPM	WITS	SOURCE	N
60	Cem Flow Out %	CEMFOP	CFOP	S	2	%	%	WITS	SOURCE	N
61	Connection Gas (avg)	CONNGASA	CGSA	F	4	%	%	WITS	SOURCE	N
62	Connection Gas (last)	CONNGASL	CGSL	F	4	%	%	WITS	SOURCE	N
63	Connection Gas (max)	CONNGASX	CGSX	F	4	%	%	WITS	SOURCE	N
64	Choke Line ID	CHKID	CHID	F	4	MM	IN	WITS	SOURCE	N
65	Choke Line Joint ID	CHKJID	CHJD	F	4	MM	IN	WITS	SOURCE	N
66	Choke Line Joint Fraction	CHKJF	CHJF	S	2	%	%	WITS	SOURCE	N
67	Casing (Choke) Pressure	CHKP	CHKP	F	4	KPA	PSI	WITS	SOURCE	N
68	Choke Line Length	CHKLEN	CHLE	F	4	M	F	WITS	SOURCE	N
69	Cem Indiv Vol Pumped	CEMIVOL	CIVL	F	4	M3	BBL	WITS	SOURCE	N
70	Cem Job Type	CEMJTYP	CJTY	A	16	----	----	WITS	SOURCE	N
71	Carbon Dioxide	CO2	CO2	L	4	PPM	PPM	WITS	SOURCE	N
72	Carbon Dioxide (avg)	CO2A	CO2A	L	4	PPM	PPM	WITS	SOURCE	N
73	Carbon Dioxide (min)	CO2N	CO2N	L	4	PPM	PPM	WITS	SOURCE	N
74	Carbon Dioxide (max)	CO2X	CO2X	L	4	PPM	PPM	WITS	SOURCE	N
75	Comments	COMM	COMM	A	256	----	----	WITS	SOURCE	N
76	Drilling Contractor	DRLGCONT	CONT	A	16	----	----	WITS	SOURCE	N
77	Cost/Distance (cum)	CPDC	CPDC	F	4	$/M	$/F	WITS	SOURCE	N
78	Cost/Distance (inst)	CPDI	CPDI	F	0	$/M	$/F	WITS	SOURCE	N
79	Cem No./Status of Plug(s)	CEMPLUGS	CPLG	A	8	----	----	WITS	SOURCE	N
80	Cem Pump Pressure (avg)	CEMPPA	CPPA	F	4	KPA	PSI	WITS	SOURCE	N
81	Connections Remaining	CONNREM	CREM	S	2	----	----	WITS	SOURCE	N
82	Current Speed	CURRSPD	CSPD	S	2	KPH	MPH	WITS	SOURCE	N
83	Cem Stage Number	CEMSTAGE	CSTG	S	2	----	----	WITS	SOURCE	N
84	Cem Fluid Temp In (avg)	CEMTIA	CTIA	F	4	DEGC	DEGF	WITS	SOURCE	N
85	Cem Fluid Temp Out (avg)	CEMTOA	CTOA	F	4	DEGC	DEGF	WITS	SOURCE	N
86	Cem Total Vol Pumped	CEMTVOL	CTVL	F	4	M3	BBL	WITS	SOURCE	N
87	Cem Fluid Type/Batch	CEMFTYPE	CTYP	A	16	----	----	WITS	SOURCE	N
88	Custom Field 10 Identifier	CUS0	CUS0	A	32	----	----	WITS	SOURCE	N
89	Custom Field 01 Identifier	CUS1	CUS1	A	32	----	----	WITS	SOURCE	N
90	Custom Field 02 Identifier	CUS2	CUS2	A	32	----	----	WITS	SOURCE	N
91	Custom Field 03 Identifier	CUS3	CUS3	A	32	----	----	WITS	SOURCE	N
92	Custom Field 04 Identifier	CUS4	CUS4	A	32	----	----	WITS	SOURCE	N
93	Custom Field 05 Identifier	CUS5	CUS5	A	32	----	----	WITS	SOURCE	N
94	Custom Field 06 Identifier	CUS6	CUS6	A	32	----	----	WITS	SOURCE	N
95	Custom Field 07 Identifier	CUS7	CUS7	A	32	----	----	WITS	SOURCE	N
96	Custom Field 08 Identifier	CUS8	CUS8	A	32	----	----	WITS	SOURCE	N
97	Custom Field 09 Identifier	CUS9	CUS9	A	32	----	----	WITS	SOURCE	N
98	DS Section 1 ID	DS1ID	D1ID	F	4	MM	IN	WITS	SOURCE	N
99	DS Section 1 Tool Joint ID	DS1JID	D1JI	F	4	MM	IN	WITS	SOURCE	N
100	DS Section 1 Tool Joint OD	DS1JOD	D1JO	F	4	MM	IN	WITS	SOURCE	N
101	DS Section 1 Length	DS1LEN	D1LE	F	4	M	F	WITS	SOURCE	N
102	DS Section 1 Mass/Length	DS1MASS	D1MA	F	4	KG/M	LB/F	WITS	SOURCE	N
103	DS Section 1 OD	DS1OD	D1OD	F	4	MM	IN	WITS	SOURCE	N
104	DS Section 2 ID	DS2ID	D2ID	F	4	MM	IN	WITS	SOURCE	N
105	DS Section 2 Tool Joint ID	DS2JID	D2JI	F	4	MM	IN	WITS	SOURCE	N
106	DS Section 2 Tool Joint OD	DS2JOD	D2JO	F	4	MM	IN	WITS	SOURCE	N
107	DS Section 2 Length	DS2LEN	D2LE	F	4	M	F	WITS	SOURCE	N
108	DS Section 2 Mass/Length	DS2MASS	D2MA	F	4	KG/M	LB/F	WITS	SOURCE	N
109	DS Section 2 OD	DS2OD	D2OD	F	4	MM	IN	WITS	SOURCE	N
110	DS Section 3 ID	DS3ID	D3ID	F	4	MM	IN	WITS	SOURCE	N
111	DS Section 3 Tool Joint ID	DS3JID	D3JI	F	4	MM	IN	WITS	SOURCE	N
112	DS Section 3 Tool Joint OD	DS3JOD	D3JO	F	4	MM	IN	WITS	SOURCE	N
113	DS Section 3 Length	DS3LEN	D3LE	F	4	M	F	WITS	SOURCE	N
114	DS Section 3 Mass/Length	DS3MASS	D3MA	F	4	KG/M	LB/F	WITS	SOURCE	N
115	DS Section 3 OD	DS3OD	D3OD	F	4	MM	IN	WITS	SOURCE	N
116	DS Section 4 ID	DS4ID	D4ID	F	4	MM	IN	WITS	SOURCE	N
117	DS Section 4 Tool Joint ID	DS4JID	D4JI	F	4	MM	IN	WITS	SOURCE	N
118	DS Section 4 Tool Joint OD	DS4JOD	D4JO	F	4	MM	IN	WITS	SOURCE	N
119	DS Section 4 Length	DS4LEN	D4LE	F	4	M	F	WITS	SOURCE	N
120	DS Section 4 Mass/Length	DS4MASS	D4MA	F	4	KG/M	LB/F	WITS	SOURCE	N
121	DS Section 4 OD	DS4OD	D4OD	F	4	MM	IN	WITS	SOURCE	N
122	DS Section 5 ID	DS5ID	D5ID	F	4	MM	IN	WITS	SOURCE	N
123	DS Section 5 Tool Joint ID	DS5JID	D5JI	F	4	MM	IN	WITS	SOURCE	N
124	DS Section 5 Tool Joint OD	DS5JOD	D5JO	F	4	MM	IN	WITS	SOURCE	N
125	DS Section 5 Length	DS5LEN	D5LE	F	4	M	F	WITS	SOURCE	N
126	DS Section 5 Mass/Length	DS5MASS	D5MA	F	4	KG/M	LB/F	WITS	SOURCE	N
127	DS Section 5 OD	DS5OD	D5OD	F	4	MM	IN	WITS	SOURCE	N
128	DS Section 6 ID	DS6ID	D6ID	F	4	MM	IN	WITS	SOURCE	N
129	DS Section 6 Tool Joint ID	DS6JID	D6JI	F	4	MM	IN	WITS	SOURCE	N
130	DS Section 6 Tool Joint OD	DS6JOD	D6JO	F	4	MM	IN	WITS	SOURCE	N
131	DS Section 6 Mass/Length	DS6MASS	D6MA	F	4	KG/M	LB/F	WITS	SOURCE	N
132	DS Section 6 OD	DS6OD	D6OD	F	4	MM	IN	WITS	SOURCE	N
133	Date	DATE	DATE	L	4	----	----	WITS	SOURCE	N
134	DST Bottom Hole Pressure	DSTBHP	DBHP	F	4	KPA	PSI	WITS	SOURCE	N
135	DST Bottom Hole Temp	DSTBHT	DBHT	F	4	DEGC	DEGF	WITS	SOURCE	N
136	Depth Bit (meas)	DEPTBITM	DBTM	F	4	M	F	WITS	SOURCE	N
137	Depth Bit (vert)	DEPTBITV	DBTV	F	4	M	F	WITS	SOURCE	N
138	Depth Casing Shoe (meas)	DEPTCSGM	DCGM	F	4	M	F	WITS	SOURCE	N
139	DST Cum Gas Production	DSTCGP	DCGP	F	4	MCM	MCF	WITS	SOURCE	N
140	Depth Casing Shoe (vert)	DEPTCSGV	DCGV	F	4	M	F	WITS	SOURCE	N
141	Depth Chrom Sample (meas)	DEPTCHRM	DCHM	F	4	M	F	WITS	SOURCE	N
142	Date Chrom Sample	DATECHR	DCHR	L	4	----	----	WITS	SOURCE	N
143	Depth Chrom Sample (vert)	DEPTCHRV	DCHV	F	4	M	F	WITS	SOURCE	N
144	Depth Caliper (meas)	DEPTCALM	DCLM	F	4	M	F	WITS	SOURCE	N
145	DST Cum Liquid Production	DSTCLP	DCLP	F	4	M3	BBL	WITS	SOURCE	N
146	Depth Caliper (vert)	DEPTCALV	DCLV	F	4	M	F	WITS	SOURCE	N
147	Depth Connection (meas)	DEPTCONM	DCNM	F	4	M	F	WITS	SOURCE	N
148	Depth Connection (vert)	DEPTCONV	DCNV	F	4	M	F	WITS	SOURCE	N
149	DST Cum Total Production	DSTCTP	DCTP	F	4	M3	BBL	WITS	SOURCE	N
150	Depth current measured	DEPTCURR	DCUR	F	4	M	F	WITS	SOURCE	N
151	DST Intvl Bott Depth (meas)	DEPTDIBM	DDBM	F	4	M	F	WITS	SOURCE	N
152	DST Intvl Bott Depth (vert)	DEPTDIBV	DDBV	F	4	M	F	WITS	SOURCE	N
153	DST Intvl Top Depth (meas)	DEPTDITM	DDTM	F	4	M	F	WITS	SOURCE	N
154	DST Intvl Top Depth (vert)	DEPTDITV	DDTV	F	4	M	F	WITS	SOURCE	N
155	Cem Depth to DV Tool	DEPTDVT	DDVT	F	4	M	F	WITS	SOURCE	N
156	Description type	DESCTYPE	DESC	A	8	----	----	WITS	SOURCE	N
157	Depth Form Density (meas)	DEPTFDM	DFDM	F	4	M	F	WITS	SOURCE	N
158	Depth Form Density (vert)	DEPTFDV	DFDV	F	4	M	F	WITS	SOURCE	N
159	Depth G.Ray 1 sensor(meas)	DEPTGR1M	DG1M	F	4	M	F	WITS	SOURCE	N
160	Depth G.Ray 1 sensor(vert)	DEPTGR1V	DG1V	F	4	M	F	WITS	SOURCE	N
161	Depth G.Ray 2 sensor(meas)	DEPTGR2M	DG2M	F	4	M	F	WITS	SOURCE	N
162	Depth G.Ray 2 sensor(vert)	DEPTGR2V	DG2V	F	4	M	F	WITS	SOURCE	N
163	DST Gas Flow Rate	DSTGASFR	DGFR	F	4	MCMD	MCFD	WITS	SOURCE	N
164	DST Liquid Flow Rate	DSTLIQFR	DLFR	F	4	M3/D	BPD	WITS	SOURCE	N
165	Depth Hole (meas)	DEPTMEAS	DMEA	F	4	M	F	WITS	SOURCE	N
166	Depth Por 1 sensor (meas)	DEPTP1M	DP1M	F	4	M	F	WITS	SOURCE	N
167	Depth Por 1 sensor (vert)	DEPTP1V	DP1V	F	4	M	F	WITS	SOURCE	N
168	Depth Por 2 sensor (meas)	DEPTP2M	DP2M	F	4	M	F	WITS	SOURCE	N
169	Depth Por 2 sensor (vert)	DEPTP2V	DP2V	F	4	M	F	WITS	SOURCE	N
170	Depth PIT (meas)	DEPTPITM	DPTM	F	4	M	F	WITS	SOURCE	N
171	Depth PIT (vert)	DEPTPITV	DPTV	F	4	M	F	WITS	SOURCE	N
172	Depth Resis 1 sensor (meas)	DEPTRS1M	DR1M	F	4	M	F	WITS	SOURCE	N
173	Depth Resis 1 sensor (vert)	DEPTRS1V	DR1V	F	4	M	F	WITS	SOURCE	N
174	Depth Resis 2 sensor (meas)	DEPTRS2M	DR2M	F	4	M	F	WITS	SOURCE	N
175	Depth Resis 2 sensor (vert)	DEPTRS2V	DR2V	F	4	M	F	WITS	SOURCE	N
176	Depth Returns (meas)	DEPTRETM	DRTM	F	4	M	F	WITS	SOURCE	N
177	Depth Returns (vert)	DEPTRETV	DRTV	F	4	M	F	WITS	SOURCE	N
178	Depth Sample (meas)	DEPTSAMM	DSAM	F	4	M	F	WITS	SOURCE	N
179	Depth Sample (vert)	DEPTSAMV	DSAV	F	4	M	F	WITS	SOURCE	N
180	Show Intvl Bott Depth(meas)	DEPTSIBM	DSBM	F	4	M	F	WITS	SOURCE	N
181	Show Intvl Bott Depth(vert)	DEPTSIBV	DSBV	F	4	M	F	WITS	SOURCE	N
182	DST identification	DSTID	DSID	A	8	----	----	WITS	SOURCE	N
183	No. Drill String Sections	DSNUM	DSNO	S	2	----	----	WITS	SOURCE	N
184	DST Surf Pressure, Casing	DSTSPCAS	DSPC	F	4	KPA	PSI	WITS	SOURCE	N
185	DST Surf Pressure, Tubing	DSTSPTUB	DSPT	F	4	KPA	PSI	WITS	SOURCE	N
186	DST State of Well	DSTSTATE	DSTA	S	2	----	----	WITS	SOURCE	N
187	Show Intvl Top Depth (meas)	DEPTSITM	DSTM	F	4	M	F	WITS	SOURCE	N
188	DST Surf Temp, Tubing	DSTSTTUB	DSTT	F	4	DEGC	DEGF	WITS	SOURCE	N
189	Show Intvl Top Depth (vert)	DEPTSITV	DSTV	F	4	M	F	WITS	SOURCE	N
190	Depth Svy/reading (meas)	DEPTSVYM	DSVM	F	4	M	F	WITS	SOURCE	N
191	Depth Svy/reading (vert)	DEPTSVYV	DSVV	F	4	M	F	WITS	SOURCE	N
192	DST Total Flow Rate	DSTTOTFR	DTFR	F	4	M3/D	BPD	WITS	SOURCE	N
193	DST Tool Time	DSTTTIME	DTTI	L	4	HR	HR	WITS	SOURCE	N
194	Depth Hole (vert)	DEPTVERT	DVER	F	4	M	F	WITS	SOURCE	N
195	Corr. Drilling Exponent	DXC	DXC	F	4	----	----	WITS	SOURCE	N
196	ECD at Bit	ECDBIT	ECDB	F	4	KGM3	PPG	WITS	SOURCE	N
197	ECD at Casing Shoe	ECDCSG	ECDC	F	4	KGM3	PPG	WITS	SOURCE	N
198	ECD at Total Depth	ECDTD	ECDT	F	4	KGM3	PPG	WITS	SOURCE	N
199	Elev : Datum-MSL	ELEVDP	ELDP	F	4	M	F	WITS	SOURCE	N
200	Elev : Ground Level-MSL	ELEVGL	ELGL	F	4	M	F	WITS	SOURCE	N
201	Elev : Kelly Bushing-MSL	ELEVKB	ELKB	F	4	M	F	WITS	SOURCE	N
202	Neo-Pentane (EC5)	EPENTANE	EPEN	L	4	PPM	PPM	WITS	SOURCE	N
203	Neo-Pentane (EC5) (avg)	EPENTA	EPNA	L	4	PPM	PPM	WITS	SOURCE	N
204	Show Mud Smple N-Pentane	EPENMUD	EPNM	L	4	PPM	PPM	WITS	SOURCE	N
205	Neo-Pentane (EC5) (min)	EPENTN	EPNN	L	4	PPM	PPM	WITS	SOURCE	N
206	Neo-Pentane (EC5) (max)	EPENTX	EPNX	L	4	PPM	PPM	WITS	SOURCE	N
207	Elapsed Time Bottom-Slips	ETIMEBTS	ETBS	S	2	SEC	SEC	WITS	SOURCE	N
208	Ethane (C2)	ETHANE	ETH	L	4	PPM	PPM	WITS	SOURCE	N
209	Ethane (C2) (avg)	ETHA	ETHA	L	4	PPM	PPM	WITS	SOURCE	N
210	Show Mud Smple Ethane	ETHMUD	ETHM	L	4	PPM	PPM	WITS	SOURCE	N
211	Ethane (C2) (min)	ETHN	ETHN	L	4	PPM	PPM	WITS	SOURCE	N
212	Ethane (C2) (max)	ETHX	ETHX	L	4	PPM	PPM	WITS	SOURCE	N
213	Elapsed Time Out-of-Slips	ETIMEOS	ETOS	S	2	SEC	SEC	WITS	SOURCE	N
214	Elapsed Time Pumps-Off	ETIMEPOF	ETPO	S	2	SEC	SEC	WITS	SOURCE	N
215	Elapsed Time Slips-Bottom	ETIMESTB	ETSB	S	2	SEC	SEC	WITS	SOURCE	N
216	Elapsed Time In-Slips	ETIMESLP	ETSL	S	2	SEC	SEC	WITS	SOURCE	N
217	Est. Form. Frac Press Grad.	FFRACPG	FFPG	F	4	KGM3	PPG	WITS	SOURCE	N
218	Field Name	FIELD	FLD	A	32	----	----	WITS	SOURCE	N
219	Est. Form. Overburden Grad.	FOBPG	FOPG	F	4	KGM3	PPG	WITS	SOURCE	N
220	Fossils	FOSS	FOSS	A	16	----	----	WITS	SOURCE	N
221	Frac Pressure Grad at PIT	FPGPIT	FPIT	F	4	KGM3	PPG	WITS	SOURCE	N
222	Est. Form. Pore Press Grad.	FPOREPG	FPPG	F	4	KGM3	PPG	WITS	SOURCE	N
223	Fill/Gain Volume Exp.	FVOLE	FVE	F	4	M3	BBL	WITS	SOURCE	N
224	Fill/Gain Volume Exp (cum)	FVOLEC	FVEC	F	4	M3	BBL	WITS	SOURCE	N
225	Fill/Gain Volume Obs.	FVOLO	FVO	F	4	M3	BBL	WITS	SOURCE	N
226	Fill/Gain Volume Obs.(cum)	FVOLOC	FVOC	F	4	M3	BBL	WITS	SOURCE	N
227	Gas (avg)	GASA	GASA	F	4	%	%	WITS	SOURCE	N
228	Gas (max)	GASX	GASX	F	4	%	%	WITS	SOURCE	N
229	Cuttings Gas	GASCUTT	GCUT	F	4	%	%	WITS	SOURCE	N
230	Gas In (lagd)	GASIL	GSIL	F	4	%	%	WITS	SOURCE	N
231	Hole Section 1 Diam	HL1DIAM	H1DI	F	4	MM	IN	WITS	SOURCE	N
232	Hole Section 1 Length	HL1LEN	H1LE	F	4	M	F	WITS	SOURCE	N
233	Hole Section 2 Diam	HL2DIAM	H2DI	F	4	MM	IN	WITS	SOURCE	N
234	Hole Section 2 Length	HL2LEN	H2LE	F	4	M	F	WITS	SOURCE	N
235	Hole Section 3 Diam	HL3DIAM	H3DI	F	4	MM	IN	WITS	SOURCE	N
236	Hole Section 3 Length	HL3LEN	H3LE	F	4	M	F	WITS	SOURCE	N
237	Hole Section 4 Diam	HL4DIAM	H4DI	F	4	MM	IN	WITS	SOURCE	N
238	Hole Section 4 Length	HL4LEN	H4LE	F	4	M	F	WITS	SOURCE	N
239	Hole Section 5 Diam	HL5DIAM	H5DI	F	4	MM	IN	WITS	SOURCE	N
240	Heel	HEEL	HEEL	F	4	DEG	DEG	WITS	SOURCE	N
241	Hyd.Sulfide Haz.Pot. (avg)	HSHPA	HHPA	F	4	PPM	PPM	WITS	SOURCE	N
242	Hookload (avg)	HKLA	HKLA	F	4	KDN	KLB	WITS	SOURCE	N
243	Hookload (min)	HKLN	HKLN	F	4	KDN	KLB	WITS	SOURCE	N
244	Hookload (max)	HKLX	HKLX	F	4	KDN	KLB	WITS	SOURCE	N
245	No. Hole Sections	HOLENUM	HLNO	S	2	----	----	WITS	SOURCE	N
246	Hyd.Sulfide pH (avg)	HSPHA	HPHA	F	4	----	----	WITS	SOURCE	N
247	Hyd.Sulfide pHS (avg)	HSPHSA	HPSA	F	4	%	%	WITS	SOURCE	N
248	Hydrogen Sulfide (avg)	HSA	HSA	L	4	PPM	PPM	WITS	SOURCE	N
249	Hydrogen Sulfide (max)	HSX	HSX	L	4	PPM	PPM	WITS	SOURCE	N
250	Heave, Mean Period	HEAVMPER	HVMP	S	2	SEC	SEC	WITS	SOURCE	N
251	Heave, Peak-to-Peak (max)	HEAVMAX	HVMX	F	4	M	F	WITS	SOURCE	N
252	Heave, Peak-to-Peak (sig)	HEAVSIG	HVSG	F	4	M	F	WITS	SOURCE	N
253	Iso-Butane (IC4) (avg)	IBUTA	IBTA	L	4	PPM	PPM	WITS	SOURCE	N
254	Show Mud Smple I-Butane	IBUTMUD	IBTM	L	4	PPM	PPM	WITS	SOURCE	N
255	Iso-Butane (IC4) (min)	IBUTN	IBTN	L	4	PPM	PPM	WITS	SOURCE	N
256	Iso-Butane (IC4) (max)	IBUTX	IBTX	L	4	PPM	PPM	WITS	SOURCE	N
257	Iso-Butane (IC4)	IBUTANE	IBUT	L	4	PPM	PPM	WITS	SOURCE	N
258	Iso-Hexane (IC6)	IHEXANE	IHEX	L	4	PPM	PPM	WITS	SOURCE	N
259	Iso-Hexane (IC6) (avg)	IHEXA	IHXA	L	4	PPM	PPM	WITS	SOURCE	N
260	Show Mud Smple I-Hexane	IHEXMUD	IHXM	L	4	PPM	PPM	WITS	SOURCE	N
261	Iso-Hexane (IC6) (min)	IHEXN	IHXN	L	4	PPM	PPM	WITS	SOURCE	N
262	Iso-Hexane (IC6) (max)	IHEXX	IHXX	L	4	PPM	PPM	WITS	SOURCE	N
263	Iso-Pentane (IC5)	IPENTANE	IPEN	L	4	PPM	PPM	WITS	SOURCE	N
264	Iso-Pentane (IC5) (avg)	IPENTA	IPNA	L	4	PPM	PPM	WITS	SOURCE	N
265	Show Mud Smple I-Pentane	IPENMUD	IPNM	L	4	PPM	PPM	WITS	SOURCE	N
266	Iso-Pentane (IC5) (min)	IPENTN	IPNN	L	4	PPM	PPM	WITS	SOURCE	N
267	Iso-Pentane (IC5) (max)	IPENTX	IPNX	L	4	PPM	PPM	WITS	SOURCE	N
268	Jet Impact Force	JIF	JIF	F	4	KDN	LB	WITS	SOURCE	N
269	Jet Velocity	JV	JV	F	4	M/S	FPS	WITS	SOURCE	N
270	Kelly ID	KELLYID	KID	F	4	MM	IN	WITS	SOURCE	N
271	Kelly Length	KELLYLEN	KLEN	F	4	M	F	WITS	SOURCE	N
272	Kill Line ID	KILLID	KLID	F	4	MM	IN	WITS	SOURCE	N
273	Kill Line Joint ID	KILLJID	KLJD	F	4	MM	IN	WITS	SOURCE	N
274	Kill Line Joint Fraction	KILLJF	KLJF	S	2	%	%	WITS	SOURCE	N
275	Kill Line Length	KILLLEN	KLLE	F	4	M	F	WITS	SOURCE	N
276	Est. Kick Tolerance	KTOL	KTOL	F	4	KGM3	PPG	WITS	SOURCE	N
277	Lith 1 accessories	L1ACC	L1AC	A	16	----	----	WITS	SOURCE	N
278	Lith 1 classification	L1CLASS	L1CL	A	16	----	----	WITS	SOURCE	N
279	Lith 1 color	L1COLOR	L1CO	A	16	----	----	WITS	SOURCE	N
280	Lith 1 hardness	L1HARD	L1HD	A	16	----	----	WITS	SOURCE	N
281	Lith 1 matrix/cement	L1MATCEM	L1MC	A	16	----	----	WITS	SOURCE	N
282	Lith 1 %	L1PERC	L1PC	S	2	%	%	WITS	SOURCE	N
283	Lith 1 permeability	L1PERM	L1PE	F	4	MD	MD	WITS	SOURCE	N
284	Lith 1 porosity	L1POR	L1PO	F	4	%	%	WITS	SOURCE	N
285	Lith 1 roundness	L1ROUND	L1RD	A	16	----	----	WITS	SOURCE	N
286	Lith 1 sorting	L1SORT	L1SO	A	16	----	----	WITS	SOURCE	N
287	Lith 1 grain size	L1SIZE	L1SZ	A	16	----	----	WITS	SOURCE	N
288	Lith 1 texture	L1TEXT	L1TX	A	16	----	----	WITS	SOURCE	N
289	Lith 1 type	L1TYPE	L1TY	A	16	----	----	WITS	SOURCE	N
290	Lith 2 accessories	L2ACC	L2AC	A	16	----	----	WITS	SOURCE	N
291	Lith 2 classification	L2CLASS	L2CL	A	16	----	----	WITS	SOURCE	N
292	Lith 2 color	L2COLOR	L2CO	A	16	----	----	WITS	SOURCE	N
293	Lith 2 hardness	L2HARD	L2HD	A	16	----	----	WITS	SOURCE	N
294	Lith 2 matrix/cement	L2MATCEM	L2MC	A	16	----	----	WITS	SOURCE	N
295	Lith 2 %	L2PERC	L2PC	S	2	%	%	WITS	SOURCE	N
296	Lith 2 permeability	L2PERM	L2PE	F	4	MD	MD	WITS	SOURCE	N
297	Lith 2 porosity	L2POR	L2PO	F	4	%	%	WITS	SOURCE	N
298	Lith 2 roundness	L2ROUND	L2RD	A	16	----	----	WITS	SOURCE	N
299	Lith 2 sorting	L2SORT	L2SO	A	16	----	----	WITS	SOURCE	N
300	Lith 2 grain size	L2SIZE	L2SZ	A	16	----	----	WITS	SOURCE	N
301	Lith 2 texture	L2TEXT	L2TX	A	16	----	----	WITS	SOURCE	N
302	Lith 2 type	L2TYPE	L2TY	A	16	----	----	WITS	SOURCE	N
303	Lith 3 classification	L3CLASS	L3CL	A	16	----	----	WITS	SOURCE	N
304	Lith 3 %	L3PERC	L3PC	S	2	%	%	WITS	SOURCE	N
305	Lith 3 type	L3TYPE	L3TY	A	16	---- -	---	WITS	SOURCE	N
306	Lith 4 classification	L4CLASS	L4CL	A	16	----	----	WITS	SOURCE	N
307	Lith 4 %	L4PERC	L4PC	S	2	%	%	WITS	SOURCE	N
308	Lith 4 type	L4TYPE	L4TY	A	16	----	----	WITS	SOURCE	N
309	Lith 5 classification	L5CLASS	L5CL	A	16	----	----	WITS	SOURCE	N
310	Lith 5 %	L5PERC	L5PC	S	2	%	%	WITS	SOURCE	N
311	Lith 5 type	L5TYPE	L5TY	A	16	----	----	WITS	SOURCE	N
312	LMRP Angle (avg)	LMRPANA	LANA	F	4	DEG	DEG	WITS	SOURCE	N
313	LMRP Angle, Direction	LMRPAND	LAND	F	4	DEG	DEG	WITS	SOURCE	N
314	LMRP Angle (max)	LMRPANX	LANX	F	4	DEG	DEG	WITS	SOURCE	N
315	Lag Strokes	LAGSTKS	LSTK	S	2	----	----	WITS	SOURCE	N
316	Mud Rept Viscom 100 rpm	MRVIS100	M100	F	4	----	----	WITS	SOURCE	N
317	Mud Rept Viscom 200 rpm	MRVIS200	M200	F	4	----	----	WITS	SOURCE	N
318	Mud Rept Viscom 3 rpm	MRVIS3	M3	F	4	----	----	WITS	SOURCE	N
319	Mud Rept Viscom 300 rpm	MRVIS300	M300	F	4	----	----	WITS	SOURCE	N
320	Mud Rept Viscom 6 rpm	MRVIS6	M6	F	4	----	----	WITS	SOURCE	N
321	Mud Rept Viscom 600 rpm	MRVIS600	M600	F	4	----	----	WITS	SOURCE	N
322	Mud Rept Alkalinity	MRALK	MALK	F	4	MLML	MLML	WITS	SOURCE	N
323	MWD Tool Alternator Voltage	MALTVOLT	MALT	S	2	V	V	WITS	SOURCE	N
324	Bottom-hole annulus press	MBHPANN	MBPA	F	4	KPA	PSI	WITS	SOURCE	N
325	Bottom-hole internal press	MBHPINT	MBPI	F	4	KPA	PSI	WITS	SOURCE	N
326	Mud Rept Brine %	MRBRINE	MBRI	F	4	%	%	WITS	SOURCE	N
327	Mud Rept Barite content	MRBARITE	MBRT	F	4	%	%	WITS	SOURCE	N
328	Mud Rept Filter Cake	MRCAKE	MCAK	S	2	MM	I/32	WITS	SOURCE	N
329	Mud Rept Calcium	MRCALC	MCAL	F	4	MG/L	MG/L	WITS	SOURCE	N
330	Mud Rept CaCl, Wt %	MRCACL	MCCL	F	4	%	%	WITS	SOURCE	N
331	Mud Rept Chlorides	MRCHLOR	MCHL	F	4	MG/L	MG/L	WITS	SOURCE	N
332	Mud Conductivity In (avg)	MCIA	MCIA	F	4	MMHO	MMHO	WITS	SOURCE	N
333	Mud Conductivity In (lagd)	MCIL	MCIL	F	4	MMHO	MMHO	WITS	SOURCE	N
334	Caliper	MCLP	MCLP	F	4	MM	IN	WITS	SOURCE	N
335	Mud Conductivity Out (avg)	MCOA	MCOA	F	4	MMHO	MMHO	WITS	SOURCE	N
336	Mud Rept Sample Date	MRSDATE	MDAT	L	4	----	----	WITS	SOURCE	N
337	Mud Rept Mud Density	MRDENS	MDEN	F	4	KGM3	PPG	WITS	SOURCE	N
338	Mud Density In (avg)	MDIA	MDIA	F	4	KGM3	PPG	WITS	SOURCE	N
339	Mud Density In (lagd)	MDIL	MDIL	F	4	KGM3	PPG	WITS	SOURCE	N
340	Mud Density Out (avg)	MDOA	MDOA	F	4	KGM3	PPG	WITS	SOURCE	N
341	Fluid Density in Riser	MDRISER	MDRI	F	4	KGM3	PPG	WITS	SOURCE	N
342	Mud Rept Elect. Stability	MRELECST	MELS	F	4	V	V	WITS	SOURCE	N
343	Methane (C1)	METHANE	METH	L	4	PPM	PPM	WITS	SOURCE	N
344	Formation Density	MFD	MFD	F	4	G/CC	G/CC	WITS	SOURCE	N
345	Frac Pressure Grad MWD	MFFP	MFFP	F	4	KGM3	PPG	WITS	SOURCE	N
346	Mud Flow In (avg)	MFIA	MFIA	F	4	L/M	GPM	WITS	SOURCE	N
347	Mud Rept Filtrate	MRFILT	MFIL	F	4	C/30	C/30	WITS	SOURCE	N
348	Mud Flow Out (avg)	MFOA	MFOA	F	4	L/M	GPM	WITS	SOURCE	N
349	Mud Flow Out %	MFOP	MFOP	S	2	%	%	WITS	SOURCE	N
350	Pore Pressure Grad MWD	MFPP	MFPP	F	4	KGM3	PPG	WITS	SOURCE	N
351	Downhole Fluid Resis (ann)	MFRANN	MFRA	F	4	OHMM	OHMM	WITS	SOURCE	N
352	Downhole Fluid Resis (pipe)	MFRPIPE	MFRP	F	4	OHMM	OHMM	WITS	SOURCE	N
353	Downhole Fluid Temp (ann)	MFTANN	MFTA	F	4	DEGC	DEGF	WITS	SOURCE	N
354	Downhole Fluid Temp (pipe)	MFTPIPE	MFTP	F	4	DEGC	DEGF	WITS	SOURCE	N
355	Mud Rept Funnel Vis	MRFVIS	MFV	S	2	S/L	S/QT	WITS	SOURCE	N
356	Mud Rept Funnel Vis Temp	MRFVIST	MFVT	F	4	DEGC	DEGF	WITS	SOURCE	N
357	Gamma Ray 1 reading	MG1	MG1	F	4	API	API	WITS	SOURCE	N
358	Gamma Ray 1(borehole corr)	MG1C	MG1C	F	4	API	API	WITS	SOURCE	N
359	Gamma Ray 2 reading	MG2	MG2	F	4	API	API	WITS	SOURCE	N
360	Gamma Ray 2(borehole corr)	MG2C	MG2C	F	4	API	API	WITS	SOURCE	N
361	Mud Rept Gel - 10 sec	MRGEL10S	MGL1	F	4	PA	PHSF	WITS	SOURCE	N
362	Mud Rept Gel - 10 min	MRGEL10M	MGL2	F	4	PA	PHSF	WITS	SOURCE	N
363	Mud Rept Gel - 30 min	MRGEL30M	MGL3	F	4	PA	PHSF	WITS	SOURCE	N
364	Mud Rept HTHP Filter Cake	MRHCAKE	MHCK	S	2	MM	I/32	WITS	SOURCE	N
365	Mud Rept HTHP Filtrate	MRHFILT	MHFI	F	4	C/30	C/30	WITS	SOURCE	N
366	Mud Rept HTHP Pressure	MRHP	MHP	F	4	KPA	PSI	WITS	SOURCE	N
367	Mud Rept HTHP Temp	MRHT	MHT	F	4	DEGC	DEGF	WITS	SOURCE	N
368	Mud Rept LCM content	MRLCM	MLCM	F	4	KGM3	PPB	WITS	SOURCE	N
369	Mud Rept Low Grav Sol %	MRLGSOL	MLGS	F	4	%	%	WITS	SOURCE	N
370	Mud Rept Lime content	MRLIME	MLIM	F	4	KGM3	PPB	WITS	SOURCE	N
371	Mud Rept Sample Location	MRSLOC	MLOC	A	8	----	----	WITS	SOURCE	N
372	Mud Rept Magnesium	MRMAG	MMAG	F	4	MG/L	MG/L	WITS	SOURCE	N
373	Mud Rept MBT capacity	MRMBT	MMBT	F	4	KGM3	PPB	WITS	SOURCE	N
374	Mud Rept Mf	MRMF	MMF	F	4	MLML	MLML	WITS	SOURCE	N
375	Downhole Motor RPM	MMMRPM	MMRP	S	2	RPM	RPM	WITS	SOURCE	N
376	Mud Rept Number	MREPNUM	MNUM	S	2	----	----	WITS	SOURCE	N
377	Mud Rept Oil % (retort)	MROILRET	MOIL	F	4	%	%	WITS	SOURCE	N
378	Mud Rept Pf	MRPF	MPF	F	4	MLML	MLML	WITS	SOURCE	N
379	Mud Rept pH	MRPH	MPH	F	4	----	----	WITS	SOURCE	N
380	Mud Rept pH sample temp	MRPHT	MPHT	F	4	DEGC	DEGF	WITS	SOURCE	N
381	Mud Rept Pm	MRPM	MPM	F	4	MLML	MLML	WITS	SOURCE	N
382	Porosity Tool 1 reading	MPO1	MPO1	F	4	----	----	WITS	SOURCE	N
383	Porosity Tool 2 reading	MPO2	MPO2	F	4	----	----	WITS	SOURCE	N
384	Mud Rept Potassium	MRPOT	MPOT	F	4	MG/L	MG/L	WITS	SOURCE	N
385	Mud Rept Plastic Vis	MRPV	MPV	F	4	CP	CP	WITS	SOURCE	N
386	Resis 1 reading	MR1	MR1	F	4	OHMM	OHMM	WITS	SOURCE	N
387	Resis 1 (borehole corr)	MR1C	MR1C	F	4	OHMM	OHMM	WITS	SOURCE	N
388	Resis 2 reading	MR2	MR2	F	4	OHMM	OHMM	WITS	SOURCE	N
389	Resis 2 (borehole corr)	MR2C	MR2C	F	4	OHMM	OHMM	WITS	SOURCE	N
390	Mud Rept Depth (meas)	MREPDM	MRDM	F	4	M	F	WITS	SOURCE	N
391	Mud Rept Depth (vert)	MREPDV	MRDV	F	4	M	F	WITS	SOURCE	N
392	Mud Rept Rheometer temp	MRRHETEM	MRHT	F	4	DEGC	DEGF	WITS	SOURCE	N
393	Mud Rept P1	MRP1	MRP1	F	4	MLML	MLML	WITS	SOURCE	N
394	Mud Rept P2	MRP2	MRP2	F	4	MLML	MLML	WITS	SOURCE	N
395	Mud Rept Sand %	MRSAND	MSAN	F	4	%	%	WITS	SOURCE	N
396	Mud Rept Solids % (calc)	MRSOLCAL	MSCA	F	4	%	%	WITS	SOURCE	N
397	Mud Rept Solids % (retort)	MRSOLRET	MSOL	F	4	%	%	WITS	SOURCE	N
398	Methane (C1) (avg)	METHA	MTHA	L	4	PPM	PPM	WITS	SOURCE	N
399	Show Mud Smple Methane	METHMUD	MTHM	L	4	PPM	PPM	WITS	SOURCE	N
400	Methane (C1) (min)	METHN	MTHN	L	4	PPM	PPM	WITS	SOURCE	N
401	Methane (C1) (max)	METHX	MTHX	L	4	PPM	PPM	WITS	SOURCE	N
402	Mud Temperature In (avg)	MTIA	MTIA	F	4	DEGC	DEGF	WITS	SOURCE	N
403	Mud Temperature In (lagd)	MTIL	MTIL	F	4	DEGC	DEGF	WITS	SOURCE	N
404	Mud Rept Sample Time	MRSTIME	MTIM	L	4	----	----	WITS	SOURCE	N
405	Mud Temperature Out (avg)	MTOA	MTOA	F	4	DEGC	DEGF	WITS	SOURCE	N
406	Downhole Torque (avg)	MTORQA	MTQA	F	4	KNM	KFLB	WITS	SOURCE	N
407	Downhole Torque (max)	MTORQX	MTQX	F	4	KNM	KFLB	WITS	SOURCE	N
408	Mud Rept Mud Type	MRMTYPE	MTYP	A	16	----	----	WITS	SOURCE	N
409	Mud Rept Water % (retort)	MRWATRET	MWAT	F	4	%	%	WITS	SOURCE	N
410	Downhole Wt-on-Bit (avg)	MWOBA	MWBA	F	4	KDN	KLB	WITS	SOURCE	N
411	Downhole Wt-on-Bit (max)	MWOBX	MWBX	F	4	KDN	KLB	WITS	SOURCE	N
412	Mud Rept Yield Point	MRYP	MYP	F	4	PA	PHSF	WITS	SOURCE	N
413	Nor-Butane (NC4) (avg)	NBUTA	NBTA	L	4	PPM	PPM	WITS	SOURCE	N
414	Show Mud Smple N-Butane	NBUTMUD	NBTM	L	4	PPM	PPM	WITS	SOURCE	N
415	Nor-Butane (NC4) (min)	NBUTN	NBTN	L	4	PPM	PPM	WITS	SOURCE	N
416	Nor-Butane (NC4) (max)	NBUTX	NBTX	L	4	PPM	PPM	WITS	SOURCE	N
417	Nor-Butane (NC4)	NBUTANE	NBUT	L	4	PPM	PPM	WITS	SOURCE	N
418	Nor-Hexane (NC6)	NHEXANE	NHEX	L	4	PPM	PPM	WITS	SOURCE	N
419	Nor-Hexane (NC6) (avg)	NHEXA	NHXA	L	4	PPM	PPM	WITS	SOURCE	N
420	Show Mud Smple N-Hexane	NHEXMUD	NHXM	L	4	PPM	PPM	WITS	SOURCE	N
421	Nor-Hexane (NC6) (min)	NHEXN	NHXN	L	4	PPM	PPM	WITS	SOURCE	N
422	Nor-Hexane (NC6) (max)	NHEXX	NHXX	L	4	PPM	PPM	WITS	SOURCE	N
423	Nor-Pentane (NC5)	NPENTANE	NPEN	L	4	PPM	PPM	WITS	SOURCE	N
424	Nor-Pentane (NC5) (avg)	NPENTA	NPNA	L	4	PPM	PPM	WITS	SOURCE	N
425	Show Mud Smple N-Pentane	NPENMUD	NPNM	L	4	PPM	PPM	WITS	SOURCE	N
426	Nor-Pentane (NC5) (min)	NPENTN	NPNN	L	4	PPM	PPM	WITS	SOURCE	N
427	Nor-Pentane (NC5) (max)	NPENTX	NPNX	L	4	PPM	PPM	WITS	SOURCE	N
428	Rig Offset (avg)	OFFSETA	OFSA	F	4	M	F	WITS	SOURCE	N
429	Rig Offset Direction	OFFSETD	OFSD	F	4	DEG	DEG	WITS	SOURCE	N
430	Rig Offset (max)	OFFSETX	OFSX	F	4	M	F	WITS	SOURCE	N
431	Operator	OPERATOR	OPER	A	32	----	----	WITS	SOURCE	N
432	Pump 1 Capacity	PUMP1CAP	P1CA	F	4	M3ST	B/ST	WITS	SOURCE	N
433	Pump 1 Efficiency	PUMP1EFF	P1EF	S	2	%	%	WITS	SOURCE	N
434	Pump 2 Capacity	PUMP2CAP	P2CA	F	4	M3ST	B/ST	WITS	SOURCE	N
435	Pump 2 Efficiency	PUMP2EFF	P2EF	S	2	%	%	WITS	SOURCE	N
436	Pump 3 Capacity	PUMP3CAP	P3CA	F	4	M3ST	B/ST	WITS	SOURCE	N
437	Pump 3 Efficiency	PUMP3EFF	P3EF	S	2	%	%	WITS	SOURCE	N
438	Pass Number	PASSNUM	PASS	S	2	----	----	WITS	SOURCE	N
439	Pump Hydraulic Power	PHP	PHP	F	4	KW	HP	WITS	SOURCE	N
440	Pressure Loss - annulus	PLA	PLA	F	4	KPA	PSI	WITS	SOURCE	N
441	Pressure Loss - bit	PLB	PLB	F	4	KPA	PSI	WITS	SOURCE	N
442	Calc/Obs Press.Loss ratio	PLCO	PLCO	F	4	%	%	WITS	SOURCE	N
443	Pressure Loss - string	PLDS	PLDS	F	4	KPA	PSI	WITS	SOURCE	N
444	Pressure Loss - mud motor	PLMM	PLMM	F	4	KPA	PSI	WITS	SOURCE	N
445	Pressure Loss - MWD tool	PLMWD	PLMW	F	4	KPA	PSI	WITS	SOURCE	N
446	Pressure Loss - % at bit	PLPB	PLPB	F	4	%	%	WITS	SOURCE	N
447	Pressure Loss - surface	PLSU	PLSU	F	4	KPA	PSI	WITS	SOURCE	N
448	Propane (C3)	PROPANE	PRP	L	4	PPM	PPM	WITS	SOURCE	N
449	Propane (C3) (avg)	PROPA	PRPA	L	4	PPM	PPM	WITS	SOURCE	N
450	Show Mud Smple Propane	PROPMUD	PRPM	L	4	PPM	PPM	WITS	SOURCE	N
451	Propane (C3) (min)	PROPN	PRPN	L	4	PPM	PPM	WITS	SOURCE	N
452	Propane (C3) (max)	PROPX	PRPX	L	4	PPM	PPM	WITS	SOURCE	N
453	Max. Permitted SICP (init)	PSIPX	PSIP	F	4	KPA	PSI	WITS	SOURCE	N
454	Pitch, Mean Period	PTCHMPER	PTMP	S	2	SEC	SEC	WITS	SOURCE	N
455	Pitch, Peak-to-Peak (max)	PTCHMAX	PTMX	F	4	DEG	DEG	WITS	SOURCE	N
456	Pitch, Peak-to-Peak (sig)	PTCHSIG	PTSG	F	4	DEG	DEG	WITS	SOURCE	N
457	Plastic Viscosity	PV	PV	F	4	CP	CP	WITS	SOURCE	N
458	Record Identifier	RECID	RID	S	2	----	----	WITS	SOURCE	N
459	Rig Name	RIGNAME	RIG	A	16	----	----	WITS	SOURCE	N
460	Rig Operating Cost/Hour	RIGCOST	RIGC	S	2	----	$	WITS	SOURCE	N
461	Roll, Mean Period	ROLLMPER	RLMP	S	2	SEC	SEC	WITS	SOURCE	N
462	Roll, Peak-to-Peak (max)	ROLLMAX	RLMX	F	4	DEG	DEG	WITS	SOURCE	N
463	Roll, Peak-to-Peak (sig)	ROLLSIG	RLSG	F	4	DEG	DEG	WITS	SOURCE	N
464	Rate of Penetration (avg)	ROPA	ROPA	F	4	M/HR	F/HR	WITS	SOURCE	N
465	Rotary Speed (surf,avg)	RPMA	RPMA	S	2	RPM	RPM	WITS	SOURCE	N
466	Running Speed -down (avg)	RSDA	RSDA	F	4	M/S	FPM	WITS	SOURCE	N
467	Running Speed - down (max)	RSDX	RSDX	F	4	M/S	FPM	WITS	SOURCE	N
468	Running Speed -up (avg)	RSUA	RSUA	F	4	M/S	FPM	WITS	SOURCE	N
469	Running Speed - up (max)	RSUX	RSUX	F	4	M/S	FPM	WITS	SOURCE	N
470	Riser Tension	RISTENS	RTEN	F	4	KDN	KLB	WITS	SOURCE	N
471	Rig Type	RIGTYPE	RTYP	A	16	----	----	WITS	SOURCE	N
472	Rig VCG	RIGVCG	RVCG	F	4	M	F	WITS	SOURCE	N
473	Svy Azimuth (corrected)	SVYAZC	SAZC	F	4	DEG	DEG	WITS	SOURCE	N
474	Svy Azimuth (uncorrected)	SVYAZU	SAZU	F	4	DEG	DEG	WITS	SOURCE	N
475	Shale Density	SHALEDEN	SDEN	F	4	G/CC	G/CC	WITS	SOURCE	N
476	Svy Dog Leg Severity	SVYDLS	SDLS	F	4	DGHM	DGHF	WITS	SOURCE	N
477	Svy East-West Position	SVYEW	SEW	F	4	M	F	WITS	SOURCE	N
478	Svy Gravity Toolface	SVYGTF	SGTF	F	4	DEG	DEG	WITS	SOURCE	N
479	Composite Show	COMPSHOW	SHOW	A	16	----	----	WITS	SOURCE	N
480	Svy Inclination	SVYINC	SINC	F	4	DEG	DEG	WITS	SOURCE	N
481	No. Joints/Stand	DPSTDJNT	SJNT	S	2	----	----	WITS	SOURCE	N
482	Sidetrack/Hole Sect No.	STKNUM	SKNO	S	2	----	----	WITS	SOURCE	N
483	Drill Pipe Stand Length	DPSTDLEN	SLEN	F	4	M	F	WITS	SOURCE	N
484	Svy Magnetic Toolface	SVYMTF	SMTF	F	4	DEG	DEG	WITS	SOURCE	N
485	Svy North-South Position	SVYNS	SNS	F	4	M	F	WITS	SOURCE	N
486	Spud Date	SPUDDATE	SPDT	L	4	----	----	WITS	SOURCE	N
487	Pump Stroke Rate #1	SPM1	SPM1	S	2	SPM	SPM	WITS	SOURCE	N
488	Pump Stroke Rate #2	SPM2	SPM2	S	2	SPM	SPM	WITS	SOURCE	N
489	Pump Stroke Rate #3	SPM3	SPM3	S	2	SPM	SPM	WITS	SOURCE	N
490	Standpipe Pressure (avg)	SPPA	SPPA	F	4	KPA	PSI	WITS	SOURCE	N
491	Sequence Identifier	SEQID	SQID	L	4	----	----	WITS	SOURCE	N
492	In-Slips Status	STATUSIS	STIS	A	2	----	----	WITS	SOURCE	N
493	Pump Stroke Count (cum)	STKC	STKC	L	4	----	----	WITS	SOURCE	N
494	String Weight (rot,avg)	STRGWT	STWT	F	4	KDN	KLB	WITS	SOURCE	N
495	Svy Type	SVYTYPE	STYP	A	8	----	----	WITS	SOURCE	N
496	Surge, Mean Period	SURGMPER	SUMP	S	2	SEC	SEC	WITS	SOURCE	N
497	Surge, Peak-to-Peak (max)	SURGMAX	SUMX	F	4	M	F	WITS	SOURCE	N
498	Surge, Peak-to-Peak (sig)	SURGSIG	SUSG	F	4	M	F	WITS	SOURCE	N
499	Swell, Direction	SWDIR	SWDI	F	4	DEG	DEG	WITS	SOURCE	N
500	Svy Rate of Walk	SVYWALK	SWLK	F	4	DGHM	DGHF	WITS	SOURCE	N
501	Swell, Maximum Height	SWMHGHT	SWMH	F	4	M	F	WITS	SOURCE	N
502	Swell, Mean Period	SWMPER	SWMP	S	2	SEC	SEC	WITS	SOURCE	N
503	Show Number	SHOWNUM	SWNO	S	2	----	----	WITS	SOURCE	N
504	Swell, Significant Height	SWSHGHT	SWSH	F	4	M	F	WITS	SOURCE	N
505	Sway, Mean Period	SWAYMPER	SYMP	S	2	SEC	SEC	WITS	SOURCE	N
506	Sway, Peak-to-Peak (max)	SWAYMAX	SYMX	F	4	M	F	WITS	SOURCE	N
507	Sway, Peak-to-Peak (sig)	SWAYSIG	SYSG	F	4	M	F	WITS	SOURCE	N
508	Mooring Line #01 Tens(avg)	MLTA01	TA01	F	4	KDN	KLB	WITS	SOURCE	N
509	Mooring Line #02 Tens(avg)	MLTA02	TA02	F	4	KDN	KLB	WITS	SOURCE	N
510	Mooring Line #03 Tens(avg)	MLTA03	TA03	F	4	KDN	KLB	WITS	SOURCE	N
511	Mooring Line #04 Tens(avg)	MLTA04	TA04	F	4	KDN	KLB	WITS	SOURCE	N
512	Mooring Line #05 Tens(avg)	MLTA05	TA05	F	4	KDN	KLB	WITS	SOURCE	N
513	Mooring Line #06 Tens(avg)	MLTA06	TA06	F	4	KDN	KLB	WITS	SOURCE	N
514	Mooring Line #07 Tens(avg)	MLTA07	TA07	F	4	KDN	KLB	WITS	SOURCE	N
515	Mooring Line #08 Tens(avg)	MLTA08	TA08	F	4	KDN	KLB	WITS	SOURCE	N
516	Mooring Line #09 Tens(avg)	MLTA09	TA09	F	4	KDN	KLB	WITS	SOURCE	N
517	Mooring Line #10 Tens(avg)	MLTA10	TA10	F	4	KDN	KLB	WITS	SOURCE	N
518	Mooring Line #11 Tens(avg)	MLTA11	TA11	F	4	KDN	KLB	WITS	SOURCE	N
519	Mooring Line #12 Tens(avg)	MLTA12	TA12	F	4	KDN	KLB	WITS	SOURCE	N
520	Time Chrom Sample	TIMECHR	TCHR	L	4	----	----	WITS	SOURCE	N
521	Thruster #01, Direction	THRD01	TD01	F	4	DEG	DEG	WITS	SOURCE	N
522	Thruster #02, Direction	THRD02	TD02	F	4	DEG	DEG	WITS	SOURCE	N
523	Thruster #03, Direction	THRD03	TD03	F	4	DEG	DEG	WITS	SOURCE	N
524	Thruster #04, Direction	THRD04	TD04	F	4	DEG	DEG	WITS	SOURCE	N
525	Thruster #05, Direction	THRD05	TD05	F	4	DEG	DEG	WITS	SOURCE	N
526	Thruster #06, Direction	THRF06	TD06	F	4	DEG	DEG	WITS	SOURCE	N
527	Thruster #07, Direction	THRD07	TD07	F	4	DEG	DEG	WITS	SOURCE	N
528	Thruster #08, Direction	THRD08	TD08	F	4	DEG	DEG	WITS	SOURCE	N
529	Thruster #01, Force	THRF01	TF01	F	4	KDN	KLB	WITS	SOURCE	N
530	Thruster #02, Force	THRF02	TF02	F	4	KDN	KLB	WITS	SOURCE	N
531	Thruster #03, Force	THRF03	TF03	F	4	KDN	KLB	WITS	SOURCE	N
532	Thruster #04, Force	THRF04	TF04	F	4	KDN	KLB	WITS	SOURCE	N
533	Thruster #05, Force	THRF05	TF05	F	4	KDN	KLB	WITS	SOURCE	N
534	Thruster #06, Force	THRF06	TF06	F	4	KDN	KLB	WITS	SOURCE	N
535	Thruster #07, Force	THRF07	TF07	F	4	KDN	KLB	WITS	SOURCE	N
536	Thruster #08, Force	THRF08	TF08	F	4	KDN	KLB	WITS	SOURCE	N
537	Last Trip Gas	TRIPGAS	TGAS	F	4	%	%	WITS	SOURCE	N
538	Tide	TIDE	TIDE	F	4	M	F	WITS	SOURCE	N
539	Time	TIME	TIME	L	4	----	----	WITS	SOURCE	N
540	Trip Number	TRIPNUM	TNUM	S	2	----	----	WITS	SOURCE	N
541	Time Zone Offset	TOFFSET	TOFF	L	4	----	----	WITS	SOURCE	N
542	Rotary Torque (surf,avg)	TORQA	TQA	F	4	KNM	KFLB	WITS	SOURCE	N
543	Torque - Breakout (max)	TORQBOX	TQBX	F	4	KNM	KFLB	WITS	SOURCE	N
544	Torque - Make Up (max)	TORQMUX	TQMX	F	4	KNM	KFLB	WITS	SOURCE	N
545	Rotary Torque (surf,max)	TORQX	TQX	F	4	KNM	KFLB	WITS	SOURCE	N
546	Trim	TRIM	TRIM	F	4	DEG	DEG	WITS	SOURCE	N
547	Trip Rate (Dist/Time)	TRIPRATE	TRRT	F	4	KPH	KF/H	WITS	SOURCE	N
548	Trip Tank 1 Volume	TTVOL1	TTV1	F	4	M3	BBL	WITS	SOURCE	N
549	Trip Tank 2 Volume	TTVOL2	TTV2	F	4	M3	BBL	WITS	SOURCE	N
550	Tank 01 Volume	TVOL01	TV01	F	4	M3	BBL	WITS	SOURCE	N
551	Tank 02 Volume	TVOL02	TV02	F	4	M3	BBL	WITS	SOURCE	N
552	Tank 03 Volume	TVOL03	TV03	F	4	M3	BBL	WITS	SOURCE	N
553	Tank 04 Volume	TVOL04	TV04	F	4	M3	BBL	WITS	SOURCE	N
554	Tank 05 Volume	TVOL05	TV05	F	4	M3	BBL	WITS	SOURCE	N
555	Tank 06 Volume	TVOL06	TV06	F	4	M3	BBL	WITS	SOURCE	N
556	Tank 07 Volume	TVOL07	TV07	F	4	M3	BBL	WITS	SOURCE	N
557	Tank 08 Volume	TVOL08	TV08	F	4	M3	BBL	WITS	SOURCE	N
558	Tank 09 Volume	TVOL09	TV09	F	4	M3	BBL	WITS	SOURCE	N
559	Tank 10 Volume	TVOL10	TV10	F	4	M3	BBL	WITS	SOURCE	N
560	Tank 11 Volume	TVOL11	TV11	F	4	M3	BBL	WITS	SOURCE	N
561	Tank 12 Volume	TVOL12	TV12	F	4	M3	BBL	WITS	SOURCE	N
562	Tank 13 Volume	TVOL13	TV13	F	4	M3	BBL	WITS	SOURCE	N
563	Tank 14 Volume	TVOL14	TV14	F	4	M3	BBL	WITS	SOURCE	N
564	Tank Volume (active)	TVOLACT	TVA	F	4	M3	BBL	WITS	SOURCE	N
565	Tank Volume Change (act)	TVOLCACT	TVCA	F	4	M3	BBL	WITS	SOURCE	N
566	Tank Volume Change (total)	TVOLCTOT	TVCT	F	4	M3	BBL	WITS	SOURCE	N
567	Tank Volume Reset Time	TVRESET	TVRT	L	4	----	----	WITS	SOURCE	N
568	Tank Volume (total)	TVOLTOT	TVT	F	4	M3	BBL	WITS	SOURCE	N
569	Mooring Line #01 Tens(max)	MLTX01	TX01	F	4	KDN	KLB	WITS	SOURCE	N
570	Mooring Line #02 Tens(max)	MLTX02	TX02	F	4	KDN	KLB	WITS	SOURCE	N
571	Mooring Line #03 Tens(max)	MLTX03	TX03	F	4	KDN	KLB	WITS	SOURCE	N
572	Mooring Line #04 Tens(max)	MLTX04	TX04	F	4	KDN	KLB	WITS	SOURCE	N
573	Mooring Line #05 Tens(max)	MLTX05	TX05	F	4	KDN	KLB	WITS	SOURCE	N
574	Mooring Line #06 Tens(max)	MLTX06	TX06	F	4	KDN	KLB	WITS	SOURCE	N
575	Mooring Line #07 Tens(max)	MLTX07	TX07	F	4	KDN	KLB	WITS	SOURCE	N
576	Mooring Line #08 Tens(max)	MLTX08	TX08	F	4	KDN	KLB	WITS	SOURCE	N
577	Mooring Line #09 Tens(max)	MLTX09	TX09	F	4	KDN	KLB	WITS	SOURCE	N
578	Mooring Line #10 Tens(max)	MLTX10	TX10	F	4	KDN	KLB	WITS	SOURCE	N
579	Mooring Line #11 Tens(max)	MLTX11	TX11	F	4	KDN	KLB	WITS	SOURCE	N
580	Mooring Line #12 Tens(max)	MLTX12	TX12	F	4	KDN	KLB	WITS	SOURCE	N
581	Units Type used	UNIT	UNIT	A	8	----	----	WITS	SOURCE	N
582	Vendor 1 Name/Service	VENDOR1	VEN1	A	32	----	----	WITS	SOURCE	N
583	Vendor 2 Name/Service	VENDOR2	VEN2	A	32	----	----	WITS	SOURCE	N
584	Vendor 3 Name/Service	VENDOR3	VEN3	A	32	----	----	WITS	SOURCE	N
585	Vendor 4 Name/Service	VENDOR4	VEN4	A	32	----	----	WITS	SOURCE	N
586	Vendor 5 Name/Service	VENDOR5	VEN5	A	32	----	----	WITS	SOURCE	N
587	Vendor 6 Name/Service	VENDOR6	VEN6	A	32	----	----	WITS	SOURCE	N
588	Vessel Heading	VESSHEAD	VHED	F	4	DEG	DEG	WITS	SOURCE	N
589	Vessel Mean Draft	VESMDRFT	VMD	F	4	M	F	WITS	SOURCE	N
590	Well Classification (Lahee)	WELLCLAS	WCLS	A	16	----	----	WITS	SOURCE	N
591	Show Comments	SHOWCOMM	WCOM	A	128	----	----	WITS	SOURCE	N
592	Wind Direction	WINDDIR	WDIR	F	4	DEG	DEG	WITS	SOURCE	N
593	Water Depth (mean)	WATDEPT	WDPM	F	4	M	F	WITS	SOURCE	N
594	Well Name	WELLNAME	WELL	A	32	----	----	WITS	SOURCE	N
595	Wind Gusts ( 5 sec )	WINDGUST	WGST	F	4	KPH	MPH	WITS	SOURCE	N
596	Well Identifier	WELLID	WID	A	16	----	----	WITS	SOURCE	N
597	Show Lith accessories	SHLACC	WLAC	A	16	----	----	WITS	SOURCE	N
598	Well Surface Latitude	WELLLAT	WLAT	A	16	----	----	WITS	SOURCE	N
599	Show Lith classification	SHLCLASS	WLCL	A	16	----	----	WITS	SOURCE	N
600	Show Lith color	SHLCOLOR	WLCO	A	16	----	----	WITS	SOURCE	N
601	Show Lith cut description	SHLCUT	WLCT	A	64	----	----	WITS	SOURCE	N
602	Show Lith fluor description	SHLFLUOR	WLFL	A	64	----	----	WITS	SOURCE	N
603	Show Lith cuttings gas	SHLGCUT	WLGC	F	4	%	%	WITS	SOURCE	N
604	Show Lith hardness	SHLHARD	WLHD	A	16	----	----	WITS	SOURCE	N
605	Show Lith matrix/cement	SHLMC	WLMC	A	16	----	----	WITS	SOURCE	N
606	Well Location	LOCATION	WLOC	A	32	----	----	WITS	SOURCE	N
607	Well Surface Longitude	WELLLON	WLON	A	16	----	----	WITS	SOURCE	N
608	Show Lith permeability	SHLPERM	WLPE	F	4	MD	MD	WITS	SOURCE	N
609	Show Lith porosity -meas	SHLPORM	WLPM	F	4	%	%	WITS	SOURCE	N
610	Show Lith porosity -visible	SHLPORV	WLPV	A	16	----	----	WITS	SOURCE	N
611	Show Lith roundness	SHLROUND	WLRD	A	16	----	----	WITS	SOURCE	N
612	Show Lith sorting	SHLSORT	WLSO	A	16	----	----	WITS	SOURCE	N
613	Show Lith stain description	SHLSTAIN	WLST	A	64	----	----	WITS	SOURCE	N
614	Show Lith grain size	SHLSIZE	WLSZ	A	16	----	----	WITS	SOURCE	N
615	Show Lith texture	SHLTEXT	WLTX	A	16	----	----	WITS	SOURCE	N
616	Show Lith type	SHLTYPE	WLTY	A	16	----	----	WITS	SOURCE	N
617	Well Identification Number	WELLNUM	WNUM	A	16	----	----	WITS	SOURCE	N
618	Weight-on-Bit (surf,avg)	WOBA	WOBA	F	4	KDN	KLB	WITS	SOURCE	N
619	Weight-on-Bit (surf,max)	WOBX	WOBX	F	4	KDN	KLB	WITS	SOURCE	N
620	Show titrated salinity	SHSAL	WSAL	L	4	PPM	PPM	WITS	SOURCE	N
621	Weather Comments	WSSCOMM	WSCM	A	128	----	----	WITS	SOURCE	N
622	Wind Speed ( 1 min )	WINDSPD	WSPD	F	4	KPH	MPH	WITS	SOURCE	N
623	Well Univ.Tran.Mercator	WELLUTM	WUTM	A	16	----	----	WITS	SOURCE	N
624	Waves, Direction	WVDIR	WVDI	F	4	DEG	DEG	WITS	SOURCE	N
625	Waves, Maximum Height	WVMHGHT	WVMH	F	4	M	F	WITS	SOURCE	N
626	Waves, Mean Period	WVMPER	WVMP	S	2	SEC	SEC	WITS	SOURCE	N
627	Waves, Significant Height	WVSHGHT	WVSH	F	4	M	F	WITS	SOURCE	N
628	Yield Point	YP	YP	F	4	PA	PHSF	WITS	SOURCE	N
629	Yaw, Mean Period	YAWMPER	YWMP	S	2	SEC	SEC	WITS	SOURCE	N
630	Yaw, Peak-to-Peak (max)	YAWMAX	YWMX	F	4	DEG	DEG	WITS	SOURCE	N
631	Yaw, Peak-to Peak (sig)	YAWSIG	YWSG	F	4	DEG	DEG	WITS	SOURCE	N
632	COP Weight On Bit State	copWOB_State	copWOB_State	S	128	----	----	COP	SOURCE	Y
633	COP Weight On Bit Sliding Set Point	copWOB_SlidingSetPt	copWOB_SlidingSetPt	S	128	kg	kg	COP	SOURCE	Y
634	COP Weight On Bit Rotary Set Point	copWOB_RotarySetPt	copWOB_RotarySetPt	S	128	kg	kg	COP	SOURCE	Y
635	COP Calaculated Rig State	copRigState	copRigState	S	128	----	----	COP	SOURCE	Y
636	Number of trips in drilling job	copTripCount	copTripCount	S	128	----	----	COP	SOURCE	Y
637	Number of connections in drilling job	copConnectionCount	copConnectionCount	S	128	----	----	COP	SOURCE	Y
638	Number of drill pipe stands to current hole depth	copStandCount	copStandCount	S	128	----	----	COP	SOURCE	Y
639	COP Distance From Bit	copDistanceFromBit	copDistanceFromBit	S	128	meter	meter	COP	SOURCE	Y
640	COP Distance From Surface	copDistanceFromSurface	copDistanceFromSurface	S	128	meter	meter	COP	SOURCE	Y
641	Time elapsed	TIME_ELAPSED	TIME_ELAPSED	S	128	no conversion	no conversion	COP	SOURCE	Y
642	Stand Pipe Pressure	SPP	SPP	S	128	bar	bar	COP	SOURCE	Y
643	Axial Accelerometer	ACLZ	ACLZ	S	128	m s^-2	m s^-2	COP	SOURCE	Y
644	Temperature	TEMPERATURE	TEMPERATURE	S	128	absolute K	absolute K	COP	SOURCE	Y
645	COP Radial Accelerometer	copAccelX	copAccelX	S	128	m s^-2	m s^-2	COP	SOURCE	Y
646	COP Tangential Accelerometer	copAccelY	copAccelY	S	128	m s^-12	m s^-12	COP	SOURCE	Y
647	COP Axial Accelerometer	copAccelZ	copAccelZ	S	128	m s^-22	m s^-22	COP	SOURCE	Y
648	COP Accelerometer Vector Sum	copAccelVectorSum	copAccelVectorSum	S	128	----	----	COP	SOURCE	Y
649	Surface Torque on Bit	STOB	STOB	S	128	si::torque = m^2 kg s^-2 rad^-1	si::torque = m^2 kg s^-2 rad^-1	COP	SOURCE	Y
650	Radial Accelerometer	ACLX	ACLX	S	128	m s^-2	m s^-2	COP	SOURCE	Y
651	Tangential Accelerometer	ACLY	ACLY	S	128	m s^-2	m s^-2	COP	SOURCE	Y
652	Rate of penetration	ROP	ROP	S	128	meter/hr	meter/hr	COP	SOURCE	Y
653	COP rate of bit when off bottom	ROB	ROB	S	128	meter/hr	meter/hr	COP	SOURCE	Y
654	COP Mechanical Specific Energy	MSE	MSE	S	128	----	----	COP	SOURCE	Y
655	True Vertical Depth	TVD	TVD	S	128	meter	meter	COP	SOURCE	Y
656	Gamma Ray Depth	GR_RT_DEPT	GR_RT_DEPT	S	128	meter	meter	COP	SOURCE	Y
657	Gamma Ray API Value	GR_RT	GR_RT	S	128	API -> ?	API -> ?	COP	SOURCE	Y
658	GR_REC_DEPT	GR_REC_DEPT	GR_REC_DEPT	S	128	meter	meter	COP	SOURCE	Y
659	GR_REC	GR_REC	GR_REC	S	128	API -> ?	API -> ?	COP	SOURCE	Y
660	Survey tool measured depth	SURVEY_DEPT	SURVEY_DEPT	S	128	meter	meter	COP	SOURCE	Y
661	Survey tool true vertical depth	SURVEY_TVD	SURVEY_TVD	S	128	meter	meter	COP	SOURCE	Y
662	Inclination	INC	INC	S	128	rad	rad	COP	SOURCE	Y
663	Azimuth	AZM	AZM	S	128	rad	rad	COP	SOURCE	Y
664	North/South	NS	NS	S	128	meter	meter	COP	SOURCE	Y
665	East/West	EW	EW	S	128	meter	meter	COP	SOURCE	Y
666	Vertical Section	VS	VS	S	128	meter	meter	COP	SOURCE	Y
667	Number of degrees of curvature per 100 feet	DOGLEG	DOGLEG	S	128	rad/m	rad/m	COP	SOURCE	Y
668	COP Tortuosity	copTortuosity	copTortuosity	S	128	----	----	COP	SOURCE	Y
669	The stick slip algorithm is on	SS_ON	SS_ON	S	128	boolean	boolean	COP	SOURCE	Y
670	High Frequency Surface Torque on Bit	HF_STRQ	HF_STRQ	S	128	si::torque = m^2 kg s^-2 rad^-1	si::torque = m^2 kg s^-2 rad^-1	COP	SOURCE	Y
671	High Frequency Surface RPM	HF_SRPM	HF_SRPM	S	128	rpm	rpm	COP	SOURCE	Y
672	COP calculated proportional (P) term of PID output.	COP_PID_P	COP_PID_P	S	128	Nms	Nms	COP	SOURCE	Y
673	COP calculated integral (I) term of PID output.	COP_PID_I	COP_PID_I	S	128	Nm	Nm	COP	SOURCE	Y
674	COP calculated derivative (D) term of PID output.	COP_PID_D	COP_PID_D	S	128	Nml^2	Nml^2	COP	SOURCE	Y
675	Vendor stick slip set point active	SS_SETPOINT_ON	SS_SETPOINT_ON	S	128	boolean	boolean	COP	SOURCE	Y
676	COP stick slip set point active	COP_SETPOINT_ON	COP_SETPOINT_ON	S	128	boolean	boolean	COP	SOURCE	Y
677	Autodriller is on	AUTODRILLER_ON	AUTODRILLER_ON	S	128	boolean	boolean	COP	SOURCE	Y
678	The type of set point that the autodriller is using	AUTODRILLER_MOD	AUTODRILLER_MOD	S	128	----	----	COP	SOURCE	Y
679	The autodriller allows external set point	AUTODRILLER_MASTER_ENABLE	AUTODRILLER_MASTER_ENABLE	S	128	boolean	boolean	COP	SOURCE	Y
680	The autodriller is using the vendor WOB set point	AUTODRILLER_WOB_ON	AUTODRILLER_WOB_ON	S	128	boolean	boolean	COP	SOURCE	Y
681	The autodriller is using the COP WOB set point	COP_AUTODRILLER_WOB_ON	COP_AUTODRILLER_WOB_ON	S	128	boolean	boolean	COP	SOURCE	Y
682	The COP WOB set point value for the autodriller	COP_WOB_SET_POINT	COP_WOB_SET_POINT	S	128	kg	kg	COP	SOURCE	Y
683	Differential Pressure	DP	DP	S	128	bar	bar	COP	SOURCE	Y
684	The RPM Set Point currently in use by driller	RPM_SET_POINT	RPM_SET_POINT	S	128	rpm	rpm	COP	SOURCE	Y
\.


--
-- Data for Name: chunktransfer; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.chunktransfer (id, chunkprofile, asset, host, status, recipient, summary, peers, userprofile, progress, mongodbname, created_on, start_time, filepath, port, devices, requesttype, runcount, tagname) FROM stdin;
\.


--
-- Data for Name: config; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.config (config_id, configuration, created_by, created_on, updated_by, updated_on) FROM stdin;
\.


--
-- Data for Name: crs; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.crs (crs_id, crs_name) FROM stdin;
1	AGD66
2	AGD84
3	AHD
4	AIOC95
5	ATF
6	ATS77
7	Abidjan
8	Accra
9	Adindan
10	Afgooye
11	Agadez
12	Ain
13	Albanian
14	Alicante
15	American
16	Amersfoort
17	Ammassalik
18	Anguilla
19	Antalya
20	Antigua
21	Aratu
22	Arc
23	Ascension
24	Astra
25	Auckland
26	Australian
27	Ayabelle
28	Azores
29	BDA2000
30	Baltic
31	Bandar
32	Barbados
33	Barcelona
34	Barinas
35	Batavia
36	Beduaram
37	Beijing
38	Belfast
39	Belge
40	Bellevue
41	Bermuda
42	Bern
43	Bissau
44	Black
45	Bluff
46	Bogota
47	Bora
48	Bukit
49	CGCS2000
50	CGVD28
51	CH1903
52	CH1903+
53	CHTRF95
54	CSG67
55	Cadastre
56	Camacupa
57	Camp
58	Campo
59	Cape
60	Carthage
61	Cascais
62	Caspian
63	Chatham
64	China
65	Chos
66	Chua
67	Cocos
68	Combani
69	Conakry
70	Constanta
71	Corrego
72	Cote
73	County
74	DGN95
75	DHDN
76	DHHN85
77	DHHN92
78	DNN
79	DVR90
80	Dabajuro
81	Dabola
82	Danger
83	Datum
84	Dealul
85	Deception
86	Deir
87	Diego
88	Dominica
89	Douala
90	Douglas
91	Dunedin
92	Dunedin-Bluff
93	Durres
94	ED50
95	ED50(ED77)
96	ED79
97	ED87
98	EGM2008
99	EGM96
100	ELD79
101	EOMA
102	EPSG
103	EST92
104	EST97
105	ETRS89
106	EVRF2000
107	EVRF2007
108	Easter
109	Egypt
110	El
111	Estonian
112	FD54
113	FD58
114	Fahud
115	Fair
116	Fao
117	Fatu
118	Fiji
119	Flannan
120	Fort
121	Foula
122	GDA94
123	GDM2000
124	GGRS87
125	GHA
126	GR96
127	Gan
128	Gandajika
129	Garoua
130	Gisborne
131	Grand
132	Greek
133	Grenada
134	Guadeloupe
135	Guam
136	Gulshan
137	Guyane
138	HD1909
139	HD72
140	HKCD
141	HKPD
142	HTRS96
143	HVRS71
144	Ha
145	Hanoi
146	Hartebeesthoek94
147	Helle
148	Herat
149	Hito
150	Hjorsey
151	Hon
152	Hong
153	Hu
154	Huahine
155	ID74
156	IGC
157	IGCB
158	IGLD
159	IGM95
160	IGN
161	IGN53
162	IGN56
163	IGN63
164	IGN72
165	IGN78
166	IGRS
167	IKBD-92
168	IRENET95
169	ISN93
170	ITRF2000
171	ITRF2005
172	ITRF88
173	ITRF89
174	ITRF90
175	ITRF91
176	ITRF92
177	ITRF93
178	ITRF94
179	ITRF96
180	ITRF97
181	Indian
182	Israel
183	Iwo
184	JAD2001
185	JAD69
186	JGD2000
187	JSLD
188	Jamaica
189	Johnston
190	Jouik
191	K0
192	KKJ
193	KOC
194	KUDAMS
195	Kalianpur
196	Kandawala
197	Karbala
198	Kasai
199	Katanga
200	Kertau
201	Korea
202	Korean
203	Kousseri
204	Kusaie
205	Kuwait
206	LGD2006
207	LHN95
208	LKS92
209	LKS94
210	LN02
211	La
212	Lagos
213	Lake
214	Lao
215	Le
216	Leigon
217	Lerwick
218	Liberia
219	Lietuvos
220	Lisbon
221	Little
222	Locodjo
223	Loma
224	Lome
225	Luxembourg
226	Luzon
227	Lyttelton
228	M'poraloko
229	MAGNA-SIRGAS
230	MGI
231	MOLDREF99
232	MOP78
233	Madeira
234	Madrid
235	Madzansua
236	Mahe
237	Makassar
238	Malin
239	Malongo
240	Manoca
241	Maputo
242	Maracaibo
243	Marcus
244	Marshall
245	Martinique
246	Massawa
247	Maturin
248	Maupiti
249	Mauritania
250	Mayotte
251	Mene
252	Merchich
253	Mexican
254	Mhast
255	Midway
256	Minna
257	Monte
258	Montserrat
259	Moorea
260	Moturiki
261	Mount
262	Moznet
263	N60
264	NAD
265	NAD27
266	NAD27(76)
267	NAD27(CGQ77)
268	NAD83
269	NAD83(CSRS)
270	NAD83(CSRS98)
271	NAD83(HARN)
272	NAD83(NSRS2007)
273	NAP
274	NAVD88
275	NDG
276	NEA74
277	NG-L
278	NGC
279	NGF
280	NGG1977
281	NGN
282	NGNC
283	NGO
284	NGPF
285	NGVD29
286	NN54
287	NSIDC
288	NSWC
289	NTF
290	NVN99
291	NZGD2000
292	NZGD49
293	NZVD2009
294	Nahrwan
295	Nakhl-e
296	Naparima
297	Napier
298	Nelson
299	New
300	Nord
301	North
302	Nouakchott
303	ODN
304	OS(SN)80
305	OSGB
306	OSGB36
307	OSGB70
308	OSNI
309	Observatario
310	Old
311	One
312	Oostende
313	Ordnance
314	PD
315	PDO
316	PHD93
317	POSGAR
318	PRS92
319	PSAD56
320	PSD93
321	PSHD93
322	PZ-90
323	Padang
324	Palestine
325	Pampa
326	Perroud
327	Petrels
328	Phoenix
329	Pico
330	Piraeus
331	Pitcairn
332	Piton
333	Point
334	Pointe
335	Poolbeg
336	Popular
337	Porto
338	Principe
339	Puerto
340	Pulkovo
341	QND95
342	Qatar
343	Qornoq
344	RD
345	REGCAN95
346	REGVEN
347	RGF93
348	RGFG95
349	RGM04
350	RGNC
351	RGNC91-93
352	RGPF
353	RGR92
354	RGRDC
355	RGSPM06
356	RH00
357	RH2000
358	RH70
359	RRAF
360	RSRGD2000
361	RT38
362	RT90
363	Raiatea
364	Rassadiran
365	Reunion
366	Reykjavik
367	S-JTSK
368	SAD69
369	SIRGAS
370	SNN76
371	SREF98
372	ST71
373	ST74
374	ST84
375	ST87
376	SVY21
377	SWEREF99
378	Saint
379	Sainte
380	Samboja
381	Santa
382	Santo
383	Sao
384	Sapper
385	Schwarzeck
386	Scoresbysund
387	Segara
388	Segora
389	Selvagem
390	Serindung
391	Sierra
392	Slovenia
393	Solomon
394	South
395	St
396	St.
397	Stewart
398	Stornoway
399	Sudan
400	Sule
401	TC(1948)
402	TM65
403	TM75
404	TWD67
405	TWD97
406	Tahaa
407	Tahiti
408	Tananarive
409	Taranaki
410	Tararu
411	Tern
412	Tete
413	Timbalai
414	Tokyo
415	Tombak
416	Trinidad
417	Tristan
418	Tucupita
419	UKOOA
420	US
421	Unknown
422	Unspecified
423	VN-2000
424	Vanua
425	Various
426	Vientiane
427	Viti
428	Voirol
429	WGS
430	Wake
431	Wellington
432	World
433	Xian
434	Yacare
435	Yellow
436	Yemen
437	Yoff
438	Zanderij
439	coord_ref_sys_name
440	fk89
441	msl
\.


--
-- Data for Name: entity; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.entity (id, name, parentname, status) FROM stdin;
1	RIG	--	0
2	WELL	--	0
3	WELLBORE	--	0
4	BHARUN	--	0
\.


--
-- Data for Name: entity_activity; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.entity_activity (id, wellboreid, activityname, starttime, endtime, created_by, created_on, updated_by, updated_on, entity_name) FROM stdin;
\.


--
-- Data for Name: entity_metadata; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.entity_metadata (id, entity_id, name, value, created_by, created_on, updated_by, updated_on, entity_name) FROM stdin;
1	1	displayName	EDR_SIMULATOR	\N	\N	\N	\N	wellbore
2	2	uid	6d211de6-530f-44cf-973a-bec3da653177-ST00BP00	SOURCE	1671520967487	SOURCE	1671520967487	wellbore
3	2	displayName	P434	SOURCE	1671521415105	SOURCE	1671521415105	wellbore
4	3	uid	28e4e0e1-f6de-4805-ad4c-665d17c226a1-ST00BP00	SOURCE	1671523931391	SOURCE	1671523931391	wellbore
5	3	displayName	P555	SOURCE	1671523984135	SOURCE	1671523984135	wellbore
6	4	displayName	BLUECARDINAL	SOURCE	1672300635250	SOURCE	1672300635250	wellbore
7	9	uid	66572437-6fea-4da3-bc24-a9557c9b0ae6-ST00BP00	SOURCE	1685625821620	SOURCE	1685625821620	wellbore
8	10	uid	c205a398-c98f-4d45-b1b5-7855f5f3e1f2-ST00BP00	SOURCE	1685628006165	SOURCE	1685628006165	wellbore
9	2	displayName	Sanity_Log	SOURCE	1685629594136	SOURCE	1685629594136	device
10	11	uid	ead8acdc-93ae-4678-a0ba-1b5c49659169-ST00BP00	SOURCE	1685686042601	SOURCE	1685686042601	wellbore
11	3	displayName	Sanity_Importmerge_Log	SOURCE	1685687268960	SOURCE	1685687268960	device
\.


--
-- Data for Name: feed; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.feed (feed_id, asset_id, sub_asset_id, logid, feed_type, server_address, source_address, issecure, username, password, archive_status, socketid, created_user_profile, active, adaptorconfig, created_by, created_on, updated_by, updated_on, devicename, frequency, delete_status, dfbit, device_id, data_type, manufacturer, device_type, model_number, serial_number, storagetype, partitionpolicy, partitionsize, timezone, dstenable) FROM stdin;
1	DEMO_WELL	DEMO_WELLBORE	EDR_SIMULATOR	CSV			false			Y	null	SOURCE	N	{"tsChannelName":"","loopingEnable":"True","freq":"1","deepSleepTime":"60000","monitorDataFile":"False","device_type":"TIMESERIES","sparseDataStreaming":"True","sourceFile":"","csvStreamDataCount":"","speedupFactor":"","streamLoopingEvents":"False","skipOverlap":"True","csvMonitorTimeInterval":"5000","indexMnemonic":""}	\N	1673348862543	\N	1685625487197	EDR_SIMULATOR	11	\N	0	yellowhammer	SIMULATED		TIMESERIES			INDIVIDUAL	NO-PARTITION	DAILY	Asia/Calcutta	false
\.


--
-- Data for Name: feed_config; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.feed_config (feed_config_id, feed_id, channel_id, index_id, channel_uri, channel_nm, channel_uuid, mnemonic, data_type, uom, start_index, end_index, description, frequencyinhz, subscribable, nullvalue, status, archive_status, created_user_profile, created_by, created_on, updated_by, updated_on, delete_status, category, sourcechannelidentifier, metadata) FROM stdin;
1	1	1	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(TestName)	TestName	881fcc583831165a8a16899cf6fd257f	TestName	A	UNITLESS			TestName	11	Y	-999.25	N	N	SOURCE	\N	\N	\N	\N	\N	DATA		\N
9	1	9	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Date Time)	Date Time	9c664f5006f32638c437a26b7909520b	Date Time	A	UNITLESS	null	null	Date Time	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
14	1	14	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Hole Depth)	Hole Depth	512a17bb44f031c8943c4b6569140e5b	Hole Depth	A	UNITLESS	null	null	Hole Depth	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
2	1	2	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Bit Position)	Bit Position	abe6f99e25fb62e16b3ef2b9a6ef54c6	Bit Position	A	UNITLESS	null	null	Bit Position	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
3	1	3	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Block Height)	Block Height	8a7403ce8848b246841a05d33f9d9eec	Block Height	A	UNITLESS	null	null	Block Height	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
11	1	11	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Bit Weight)	Bit Weight	54dc02e50398fd0b466047bb29d10f35	Bit Weight	A	UNITLESS	null	null	Bit Weight	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
8	1	8	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Flow In Rate)	Flow In Rate	0f4a456100e7af86229edee615f4c13d	Flow In Rate	A	UNITLESS	null	null	Flow In Rate	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
13	1	13	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Hook Load)	Hook Load	2085e69a584154c4d1544e443e861378	Hook Load	A	UNITLESS	null	null	Hook Load	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
12	1	12	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(ROP - Average)	ROP - Average	d443ee3a0feab367927e16c88749a6f0	ROP - Average	A	UNITLESS	null	null	ROP - Average	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
5	1	5	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Standpipe Pressure 1)	Standpipe Pressure 1	8ad643fc6ae5cc042a6043760c7ffec8	Standpipe Pressure 1	A	UNITLESS	null	null	Standpipe Pressure 1	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
7	1	7	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Standpipe Pressure 2)	Standpipe Pressure 2	c05f617c7880d9d4a47aa62509d7bd09	Standpipe Pressure 2	A	UNITLESS	null	null	Standpipe Pressure 2	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
16	1	16	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Strks - Pump 1)	Strks - Pump 1	14dc0216b05364bc93677adf07995fa0	Strks - Pump 1	A	UNITLESS	null	null	Strks - Pump 1	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
18	1	18	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Strks - Pump 2)	Strks - Pump 2	18baff6e0f06e746617ac91980696cdd	Strks - Pump 2	A	UNITLESS	null	null	Strks - Pump 2	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
17	1	17	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Strks - Pump 3)	Strks - Pump 3	32b10cd5757f59607ae9dbb26ab630ef	Strks - Pump 3	A	UNITLESS	null	null	Strks - Pump 3	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
4	1	4	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Strks - Total)	Strks - Total	360de501fe63ed7e5511ae029f9ee8ec	Strks - Total	A	UNITLESS	null	null	Strks - Total	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
15	1	15	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Top Drive RPM)	Top Drive RPM	e3612014269267351d1da8067e8efbc9	Top Drive RPM	A	UNITLESS	null	null	Top Drive RPM	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
10	1	10	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(Top Drive Torque)	Top Drive Torque	37bceff883b4ae6be9fd1ae3117a8b2c	Top Drive Torque	A	UNITLESS	null	null	Top Drive Torque	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
6	1	6	0	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(indexCount)	indexCount	da2d957df71c24d6b8f7b601fd444de6	indexCount	A	UNITLESS	null	null	indexCount	1	Y	-999.25	Y	Y	SOURCE	\N	1673348862543	\N	\N	\N	DATA		\N
\.


--
-- Data for Name: jobrun; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.jobrun (id, name, status, modifieddate, summary, jsonconfig, isconfigurable, type, initialdelay, "interval") FROM stdin;
16	virtual_backfilling_Sanity_Well	0	0	\N	{"candidate":true,"autoRunJobs":false,"maxProcessingRecordCount":25000,"interval_Backfilling":700000,"interval_channelStats":600000,"deviceTypes":["WSocket"],"delta":2,"concurrentJobCount":3,"speedUpFactor":2,"deviceSyncMap":[]}	t	backfilling	10	600000
17	Test1_physical	2	1685633708178	null	{"Name":"Test1_physical","rig":"3","Well":"Sanity_Well","SubAsset":"Sanity_Wellbore","wellbore":"Sanity_Wellbore","devicesType":"TIMESERIES","startIndex":"01/01/2023 12:25","endIndex":"04/06/2169 11:37","extractFreq":"","dataCount":907,"timezoneID":"0","deviceNameList":"Sanity_Device","isVirtualLog":"false","dataType":"RAW","processedDevices":["Sanity_Device"],"mapping":[{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(streamingUpTime)","mnemonic":"streamingUpTime","header":"streamingUpTime","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"20"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(TIME)","mnemonic":"TIME","header":"TIME","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"19"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(frequency)","mnemonic":"frequency","header":"frequency","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"33"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(streamingDownTime)","mnemonic":"streamingDownTime","header":"streamingDownTime","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"30"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(channelCount)","mnemonic":"channelCount","header":"channelCount","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"32"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(recordCount)","mnemonic":"recordCount","header":"recordCount","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"35"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(timestamp)","mnemonic":"timestamp","header":"timestamp","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"24"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(DIFP)","mnemonic":"DIFP","header":"DIFP","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"22"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(indexCount)","mnemonic":"indexCount","header":"indexCount","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"23"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(BLOCKCOMP)","mnemonic":"BLOCKCOMP","header":"BLOCKCOMP","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"25"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(WOB AVG)","mnemonic":"WOB AVG","header":"WOB AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"26"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(ROP AVG)","mnemonic":"ROP AVG","header":"ROP AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"27"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(BITDEP)","mnemonic":"BITDEP","header":"BITDEP","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"28"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(HKLD AVG)","mnemonic":"HKLD AVG","header":"HKLD AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"29"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(DEPTH)","mnemonic":"DEPTH","header":"DEPTH","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"31"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(SPP AVG)","mnemonic":"SPP AVG","header":"SPP AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"34"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(SURF RPM)","mnemonic":"SURF RPM","header":"SURF RPM","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"37"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(PTIME)","mnemonic":"PTIME","header":"PTIME","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"38"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(FLOWIN)","mnemonic":"FLOWIN","header":"FLOWIN","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"39"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(ROP INS)","mnemonic":"ROP INS","header":"ROP INS","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"21"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(TORQUE AVG)","mnemonic":"TORQUE AVG","header":"TORQUE AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"36"}],"FilePath":"AppData/data-files/jobs/17/csv-files/Test1_physical_Sanity_Well_1685633705733.csv","startTimeInMillis":1.6725759E12,"endTimeInMillis":6.28814742E12,"executionTime":"00:00:02"}	t	DataExport	0	0
18	Test_virtual	2	1685633805873	null	{"Name":"Test_virtual","rig":"3","Well":"Sanity_Well","SubAsset":"Sanity_Wellbore","wellbore":"Sanity_Wellbore","devicesType":"TIMESERIES","startIndex":"01/01/2023 12:25","endIndex":"04/06/2169 11:37","extractFreq":"","dataCount":5007,"timezoneID":"0","deviceNameList":"Test_Virtual_Backfill_Log","isVirtualLog":"true","dataType":"RAW","processedDevices":["Test_Virtual_Backfill_Log"],"mapping":[{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Test_Virtual_Backfill_Log)/mnemonic(DateTime)","mnemonic":"DateTime","header":"DateTime","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"1"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Test_Virtual_Backfill_Log)/mnemonic(depth)","mnemonic":"depth","header":"depth","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"2"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Test_Virtual_Backfill_Log)/mnemonic(bitdepth)","mnemonic":"bitdepth","header":"bitdepth","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"3"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Test_Virtual_Backfill_Log)/mnemonic(bit weight)","mnemonic":"bit weight","header":"bit weight","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"4"},{"uri":"/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Test_Virtual_Backfill_Log)/mnemonic(Torque)","mnemonic":"Torque","header":"Torque","fromUOM":"UNITLESS","toUOM":"UNITLESS","sequence":"0","include":true,"channel_id":"5"}],"FilePath":"AppData/data-files/jobs/18/csv-files/Test_virtual_Sanity_Well_1685633803875.csv","startTimeInMillis":1.6725759E12,"endTimeInMillis":6.28814742E12,"executionTime":"00:00:02"}	t	DataExport	0	0
19	virtual_backfilling_Sanity_Importmerge_Well	0	0	\N	{"candidate":true,"autoRunJobs":false,"maxProcessingRecordCount":25000,"interval_Backfilling":700000,"interval_channelStats":600000,"deviceTypes":["WSocket"],"delta":2,"concurrentJobCount":3,"speedUpFactor":2,"deviceSyncMap":[]}	t	backfilling	10	600000
20	Test	2	1685694311870	{"1":{"summary":"Mnemonic Mapping","status":"2"},"2":{"summary":"Uploading CSV Files","status":"2"},"3":{"summary":"Importing CSV Data","status":"2"},"6":{"summary":"Validating merged data","status":"2"}}	{"FilePath":"/jobs/20/csv-files/","mapping":[{"header":"ROP AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"ROP AVG","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"WOB AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"WOB AVG","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"BLOCKCOMP","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"BLOCKCOMP","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"TORQUE AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"TORQUE AVG","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"ROP INS","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"ROP INS","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"BITDEP","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"BITDEP","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"TIME","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"TIME","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"HKLD AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"HKLD AVG","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"SURF RPM","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"SURF RPM","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"DIFP","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"DIFP","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"PTIME","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"PTIME","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"FLOWIN","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"FLOWIN","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"SPP AVG","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"SPP AVG","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"DEPTH","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"DEPTH","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"timestamp","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"timestamp","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"streamingDownTime","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"streamingDownTime","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"indexCount","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"indexCount","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"recordCount","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"recordCount","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"frequency","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"frequency","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"channelCount","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"channelCount","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"},{"header":"streamingUpTime","fromUOM":"UNITLESS","toUOM":"UNITLESS","mnemonic":"streamingUpTime","sequence":"0","include":true,"fromDatatype":"string","toDatatype":"string"}],"devicesType":"TIMESERIES","Well":"Sanity_Importmerge_Well","deviceNameList":"","csvTimezone":"GMT","Name":"Test","SubAsset":"Sanity_Importmerge_Wellbore","fileConfig":[{"headerIndex":"1","tsChannelName":"TIME","datatypeIndex":"-1","dataIndex":"2","skip":"0","limit":"0","uomIndex":"-1","fileName":"gapdata30min2gap.csv"}],"mergeifAvailable":"True","processedDevices":["Sanity_Importmerge_Device"],"DeviceName":"Sanity_Importmerge_Device","DataTypes":"RAW"}	t	importMerge	0	0
3	RefreshAheadCache	2	0	null	null	t	scheduler	0	1800000
14	HistoricalChannelStatisticsJob	2	1685708347797	{"1":{"summary":"Start Channel statistics update process.","status":"2"},"2":{"summary":"Complete Channel statistics update process.","status":"2"}}	null	f	scheduler	0	30000
1	UpdateDeviceConnectionContext	3	1685708018875	{"1":{"summary":"Update device context in reader monitor","status":"0"},"2":{"summary":"Update device context in reader monitor","status":"3"}}	null	f	scheduler	0	86400000
12	EncodeUserPassword	2	1685708017704	{"1":{"summary":"Started EncodeUserPassword process","status":"1"}}	null	f	system	0	0
2	ArchivedMetaDataSync	2	0			f	scheduler	0	900000
10	UpdateChannelUoM	0	0	{"1":{"summary":"Started UoM update Process","status":"0"},"2":{"summary":"Completed UoM update Process","status":"0"}}	null	f	scheduler	0	0
9	MigrateConnectionObject	2	1685708017706	{}	null	f	system	0	0
8	SetAssetRigFromConfig	2	1685708317705	{}	null	f	system	0	300000
5	WITSMLDeviceDataRestore	0	0	null	null	f	scheduler	0	0
11	DataQualityAdvance	0	0	null	null	f	scheduler	0	0
15	WellViewDrillParamSync	0	0	{}	null	f	scheduler	0	0
13	DataSourceStatusChecker	2	1685708317752	{"summary":"Data source is available."}	null	f	scheduler	0	60000
4	MigratePublisherBackfill_V1	2	1685708017712	{}	null	f	system	0	0
7	WellOperationEvent	0	0	null	null	f	scheduler	0	0
6	GenericScheduleGapJob	0	0	null	null	f	scheduler	0	0
21	deviceGapAnalysis_3	3	0	\N	{"isDeviceOffsetEnable":false,"issLiveStreaming":false,"offSetChannel":{"TIME":0.0,"streamingUpTime":0.0,"TORQUE AVG":0.0,"frequency":0.0,"ROP INS":0.0,"timestamp":0.0,"ROP AVG":0.0,"streamingDownTime":0.0,"channelCount":0.0,"HKLD AVG":0.0,"BITDEP":0.0,"SURF RPM":0.0,"DIFP":0.0,"BLOCKCOMP":0.0,"indexCount":0.0,"recordCount":0.0,"WOB AVG":0.0,"PTIME":0.0,"FLOWIN":0.0,"SPP AVG":0.0,"DEPTH":0.0},"deviceOffsetThreshold":"","offSet":"0","log":"Timebase_Datagap_Log","witsmldataSource":"Store","deviceId":"3","issResumeStreaming":true,"rig":"Timebase_Datagap_Rig","uid":"Timebase_Datagap_Log","password":"Gautam123","witsmlLogType":"date time","startIndex":"","wellStatus":"","endIndex":"","dataStreamingType":"Log","deviceGapIntervalMinute":"60","uidWellbore":[{"name":"Timebase_Datagap_Wellbore","id":"bce9b0b4-4cbe-47aa-b7f2-ea76f4c7074e-ST00BP00"}],"deviceOffset":"","indexMnemonic":"TIME","uidWellboreRef":"bce9b0b4-4cbe-47aa-b7f2-ea76f4c7074e-ST00BP00","uidWellRef":"bce9b0b4-4cbe-47aa-b7f2-ea76f4c7074e","isDeviceThresholdbackfillEnable":false,"backfillPollInterval":"1","userName":"Gautam123","backfillBatchSize":"100","url":"http://192.168.1.131:9090/WITSMLStore/services/Store","delayInterval":"","uidWell":[{"name":"Timebase_Datagap_Well","id":"bce9b0b4-4cbe-47aa-b7f2-ea76f4c7074e"}],"pollInterval":"1","devicePerformReportingEnable":false,"isDeviceBackfillEnable":false,"deviceThresholdAutoBackFIllInterval":"120","isDeviceAutoRestoreEnable":false,"deviceThresholdAutoRecoveryInterval":"","deviceRestoreRetry":"","dataProvider":"nov","witsmlVersion":"VERSION_1_3_1_1","batchSize":"100","devicePerformReportingInterval":"5","deviceThresholdAutoBackFIllMergeInterval":"120"}	t	WITSMLDeviceBackfill	0	0
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.log (uid, uidwell, uidwellbore, number, suffixapi, indexcurve, vw, upd, del) FROM stdin;
\.


--
-- Data for Name: logcurve; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.logcurve (uid, mnemonic, vw, upd, del) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.permissions (permission_nm, permission_str) FROM stdin;
READ	1
ADD	2
UPDATE	3
DELETE	4
COPY	5
ACTIVATE	6
INACTIVATE	7
EXPORT	8
IMPORT	9
DOWNLOAD	10
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.profile (profileid, name, asset_id, sub_asset_id, description, created_user_profile, delete_status, active_status, created_by, created_on, updated_by, updated_on) FROM stdin;
\.


--
-- Data for Name: profile_details; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.profile_details (profile_detailsid, profileid, uri, mnemonic, created_user_profile, delete_status, active_status, created_by, created_on, updated_by, updated_on, channel_id, uom) FROM stdin;
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.resources (resource_name, label) FROM stdin;
rig	Setup
feedconfig	Device
feedchannel	Channel
devicegraph	Device Graph
publishers	Publishers
subscription	Subscription
manageprofile	Profiles
channelidentifier	Mnemonics
utility	Connectors
uominfo	Units of Measurement
contextualdata	ContexualMetadata
metadata	Attributes Configuration
contextual	Adaptor Configuration
administration	Administrator
versionupgrade	Schedule Jobs
chunktransfer	Asset Replication
logmanager	Logs
users	Users
serverconfig	Server Configuration
userprofile	User Profile Management
datamanage	Datamanage
datamanagement	Data Viewer
importmergedata	Import/Merge Data
documentViewer	Resources
importconfig	Import Configuration
subscriptionconfig	Publisher Configuration
usermanagement	User Management
userauth	Role Permission
dataextraction	DataExtraction
audittrail	Audit Trail
backfilling	Backfilling
globalconfig	Global Configuration
adams	ADAMS Configuration
opcda	OPCDA Configuration
utility	Connectors
livescreen	Live Streaming Data
liveconnection	Live Connection
historyconnection	Historical Connection
dataexportjob	Data Extraction
standardization	Standardization
standardizationMaster	Standardization Master
standardization	Standardization
standardizationMaster	Standardization Master
\.


--
-- Data for Name: rig; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.rig (rigid, name, drillingcontractor, created_user_profile, delete_status, active_status, timezone, dstenabled, display_name) FROM stdin;
1	DEMO_RIG	DEMO_RIG	SOURCE	\N	N	Asia/Calcutta	false	DEMO RIG
\.


--
-- Data for Name: role_res_perms; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.role_res_perms (role, resource, perm) FROM stdin;
rigadmin	rig	YYYYYYYYYY
rigadmin	feedconfig	YYYYYYYYYY
rigadmin	feedchannel	YYYYYYYYYY
rigadmin	devicegraph	YYYYYYYYYY
rigadmin	publishers	YYYYYYYYYY
rigadmin	subscription	YYYYYYYYYY
rigadmin	manageprofile	NNNNNNNNNN
rigadmin	channelidentifier	YYYYYYYYYY
rigadmin	utility	YYYYYYYYYY
rigadmin	uominfo	NNNNNNNNNN
rigadmin	contextualdata	YYYYYYYYYY
rigadmin	metadata	YYYYYYYYYY
rigadmin	contextual	YYYYYYYYYY
rigadmin	administration	NNNNNNNNNN
rigadmin	versionupgrade	NNNNNNNNNN
rigadmin	chunktransfer	YYYYYYYYYY
rigadmin	logmanager	YYYYYYYYYY
rigadmin	users	NNNNNNNNNN
rigadmin	serverconfig	NNNNNNNNNN
rigadmin	userprofile	NNNNNNNNNN
rigadmin	datamanage	YYYYYYYYYY
rigadmin	datamanagement	YYYYYYYYYY
rigadmin	importmergedata	YYYYYYYYYY
rigadmin	documentViewer	YYYYYYYYYY
rigadmin	importconfig	YYYYYYYYYY
rigadmin	subscriptionconfig	YYYYYYYYYY
rigadmin	audittrail	NNNNNNNNNN
rigadmin	usermanagement	NNNNNNNNNN
rigadmin	default	YYYYYYYYYY
rigadmin	dataextraction	YYYYYYYYYY
rigadmin	backfilling	YYYYYYYYYY
rigadmin	globalconfig	YYYYYYYYYY
rigadmin	adams	YYYYYYYYYY
rigadmin	opcda	YYYYYYYYYY
rigadmin	livescreen	YYYYYYYYYY
rigadmin	liveconnection	YYYYYYYYYY
rigadmin	historyconnection	YYYYYYYYYY
rigadmin	dataexportjob	YYYYYYYYYY
systemadmin	rig	NNNNNNNNNN
systemadmin	feedconfig	NNNNNNNNNN
systemadmin	feedchannel	NNNNNNNNNN
systemadmin	devicegraph	NNNNNNNNNN
systemadmin	publishers	NNNNNNNNNN
systemadmin	subscription	NNNNNNNNNN
systemadmin	manageprofile	YYYYYYYYYY
systemadmin	channelidentifier	YYYYYYYYYY
systemadmin	utility	NNNNNNNNNN
systemadmin	uominfo	YYYYYYYYYY
systemadmin	contextualdata	NNNNNNNNNN
systemadmin	metadata	NNNNNNNNNN
systemadmin	contextual	NNNNNNNNNN
systemadmin	administration	YYYYYYYYYY
systemadmin	versionupgrade	YYYYYYYYYY
systemadmin	chunktransfer	NNNNNNNNNN
systemadmin	logmanager	YYYYYYYYYY
systemadmin	users	YYYYYYYYYY
systemadmin	serverconfig	YYYYYYYYYY
systemadmin	userprofile	YYYYYYYYYY
systemadmin	datamanage	NNNNNNNNNN
systemadmin	datamanagement	NNNNNNNNNN
systemadmin	importmergedata	NNNNNNNNNN
systemadmin	documentViewer	NNNNNNNNNN
systemadmin	importconfig	NNNNNNNNNN
systemadmin	subscriptionconfig	NNNNNNNNNN
systemadmin	userauth	YYYYYYYYYY
systemadmin	audittrail	YYYYYYYYYY
systemadmin	usermanagement	YYYYYYYYYY
systemadmin	default	YYYYYYYYYY
systemadmin	dataextraction	NNNNNNNNNN
systemadmin	backfilling	NNNNNNNNNN
systemadmin	globalconfig	NNNNNNNNNN
systemadmin	adams	NNNNNNNNNN
systemadmin	opcda	NNNNNNNNNN
systemadmin	livescreen	NNNNNNNNNN
systemadmin	liveconnection	YYYYYYYYYY
systemadmin	historyconnection	YYYYYYYYYY
systemadmin	dataexportjob	YYYYYYYYYY
guest	rig	YNNNNNNNNN
guest	feedconfig	YNNNNNNNNN
guest	feedchannel	YNNNNNNNNN
guest	devicegraph	YNNNNNNNNN
guest	publishers	YNNNNNNNNN
guest	subscription	NNNNNNNNNN
guest	manageprofile	NNNNNNNNNN
guest	channelidentifier	NNNNNNNNNN
guest	utility	NNNNNNNNNN
guest	uominfo	NNNNNNNNNN
guest	contextualdata	NNNNNNNNNN
guest	metadata	MNNNNNNNNN
guest	contextual	NNNNNNNNNN
guest	administration	NNNNNNNNNN
guest	versionupgrade	NNNNNNNNNN
guest	chunktransfer	NNNNNNNNNN
guest	logmanager	NNNNNNNNNN
guest	users	NNNNNNNNNN
guest	serverconfig	NNNNNNNNNN
guest	userprofile	NNNNNNNNNN
guest	datamanage	YNNNNNNNNN
guest	datamanagement	YNNNNNNNNN
guest	importmergedata	NNNNNNNNNN
guest	documentViewer	NNNNNNNNNN
guest	importconfig	NNNNNNNNNN
guest	subscriptionconfig	YNNNNNNNNN
guest	audittrail	NNNNNNNNNN
guest	usermanagement	NNNNNNNNNN
guest	default	NNNNNNNNNN
guest	dataextraction	NNNNNNNNNN
guest	backfilling	NNNNNNNNNN
guest	globalconfig	NNNNNNNNNN
guest	adams	NNNNNNNNNN
guest	opcda	NNNNNNNNNN
guest	livescreen	YNNNNNNNNN
guest	liveconnection	NNNNNNNNNN
guest	historyconnection	NNNNNNNNNN
guest	dataexportjob	NNNNNNNNNN
systemadmin	standardizationMaster	YYYYYYYYYY
rigadmin	standardizationMaster	NNNNNNNNNN
guest	standardizationMaster	NNNNNNNNNN
systemadmin	standardizationMaster	YYYYYYYYYY
rigadmin	standardizationMaster	NNNNNNNNNN
guest	standardizationMaster	NNNNNNNNNN
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.roles (role_name, description) FROM stdin;
systemadmin	systemadmin
rigadmin	rigadmin
guest	guest
\.


--
-- Data for Name: roles_permissions; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.roles_permissions (roleper, role_name, permission) FROM stdin;
	SuperAdmin	*
	administrator	*
\.


--
-- Data for Name: section; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.section (sectionid, wellboreid, type, top, bottom, created_user_profile, delete_status, active_status) FROM stdin;
1	1	Horizontal	11	11	SOURCE	\N	N
3	8	Horizontal	12	12	SOURCE	\N	N
\.


--
-- Data for Name: standard_mnemonic_group; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.standard_mnemonic_group (id, groupname, grouptype, indextype, created_by, created_on, updated_by, updated_on) FROM stdin;
1	Test_Virtual_Backfill_Log	Test_Virtual_Backfill	TIMESERIES	null	1685628088922	SuperAdmin	1685628088922
\.


--
-- Data for Name: standard_mnemonic_validation_rule; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.standard_mnemonic_validation_rule (id, standard_mnemonic_id, rule_type, rule_expression, sequence, created_by, created_on, updated_by, updated_on) FROM stdin;
\.


--
-- Data for Name: standard_mnemonics; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.standard_mnemonics (id, standard_mnemonic_group_id, status, minindex, maxindex, metricunit, fpsunit, mnemonicname, datatype, created_by, created_on, updated_by, updated_on) FROM stdin;
1	1	Y	0	1e+06	UNITLESS	UNITLESS	DateTime	T	SuperAdmin	null	null	null
2	1	Y	0	1e+06	UNITLESS	UNITLESS	depth	F	SuperAdmin	null	null	null
3	1	Y	0	1e+07	UNITLESS	UNITLESS	bitdepth	F	SuperAdmin	null	null	null
4	1	Y	0	100000	UNITLESS	UNITLESS	bit weight	F	SuperAdmin	null	null	null
5	1	Y	0	1e+06	UNITLESS	UNITLESS	Torque	F	SuperAdmin	null	null	null
\.


--
-- Data for Name: subasset_standard_mnemonic_groups; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.subasset_standard_mnemonic_groups (id, asset, subasset, standard_mnemonic_group_id, validation_enable, persistence_enable, buffer_policy_type, buffer_value, buffer_cleanup_interval, issi, created_by, created_on, updated_by, updated_on, index_channel, config, subscribe_enable) FROM stdin;
1	Sanity_Well	Sanity_Wellbore	1	Y	Y	count	infinite	3600000	Y	RigAdmin	1685628276441	RigAdmin	1685628276441		{"dataAgregationType":"","windowLength":"","isDataAgregationType":"","dataFlowType":"","contextualMapping":""}	Y
2	Sanity_Well	Sanity_Wellbore	1	Y	Y	count	infinite	3600000	Y	RigAdmin	1685630577801	RigAdmin	1685630577801	DateTime	{}	Y
3	Sanity_Importmerge_Well	Sanity_Importmerge_Wellbore	1	N	Y	count	infinite	3600000	Y	RigAdmin	1685686072058	RigAdmin	1685687290132	DateTime	{"dataAgregationType":"latest","windowLength":"1000","isDataAgregationType":"false","dataFlowType":"natural","contextualMapping":"{\\"1\\":{\\"enableContextualAnalysis\\":\\"false\\",\\"rules\\":{\\"rulesStatus\\":\\"disabled\\",\\"correlation\\":[],\\"contextual\\":[]}}}"}	Y
\.


--
-- Data for Name: subasset_standard_mnemonics; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.subasset_standard_mnemonics (id, rig, asset, subasset, sourcelog, standard_mnemonic_group_id, standard_mnemonic_id, source_log_mnemonic, created_by, created_on, updated_by, updated_on) FROM stdin;
1	Sanity_Rig	Sanity_Well	Sanity_Wellbore	Sanity_Log	1	1	TIME	RigAdmin	1685629755321	RigAdmin	1685629755321
2	Sanity_Rig	Sanity_Well	Sanity_Wellbore	Sanity_Log	1	2	DEPTH	RigAdmin	1685629763782	RigAdmin	1685629763782
3	Sanity_Rig	Sanity_Well	Sanity_Wellbore	Sanity_Log	1	3	BITDEP	RigAdmin	1685629772787	RigAdmin	1685629772787
4	Sanity_Rig	Sanity_Well	Sanity_Wellbore	Sanity_Log	1	4	WOB AVG	RigAdmin	1685629779444	RigAdmin	1685629779444
5	Sanity_Rig	Sanity_Well	Sanity_Wellbore	Sanity_Log	1	5	TORQUE AVG	RigAdmin	1685629786222	RigAdmin	1685629786222
6	Sanity_Importmerge_Rig	Sanity_Importmerge_Well	Sanity_Importmerge_Wellbore	Sanity_Importmerge_Log	1	2	DEPTH	RigAdmin	1685687305501	RigAdmin	1685687305501
7	Sanity_Importmerge_Rig	Sanity_Importmerge_Well	Sanity_Importmerge_Wellbore	Sanity_Importmerge_Log	1	1	TIME	RigAdmin	1685687311408	RigAdmin	1685687311408
8	Sanity_Importmerge_Rig	Sanity_Importmerge_Well	Sanity_Importmerge_Wellbore	Sanity_Importmerge_Log	1	5	TORQUE AVG	RigAdmin	1685687319231	RigAdmin	1685687319231
9	Sanity_Importmerge_Rig	Sanity_Importmerge_Well	Sanity_Importmerge_Wellbore	Sanity_Importmerge_Log	1	4	WOB AVG	RigAdmin	1685687330843	RigAdmin	1685687330843
10	Sanity_Importmerge_Rig	Sanity_Importmerge_Well	Sanity_Importmerge_Wellbore	Sanity_Importmerge_Log	1	3	BITDEP	RigAdmin	1685687337314	RigAdmin	1685687337314
\.


--
-- Data for Name: subassets; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.subassets (wellboreid, wellid, name, created_user_profile, delete_status, active_status, display_name) FROM stdin;
2	P434	P434	SOURCE	\N	Y	P434
3	P555	P555	SOURCE	\N	Y	P555
1	DEMO_WELL	DEMO_WELLBORE	SOURCE	\N	N	DEMO_WELLBORE
4	DEMO_WELL	DEMO_WELLBORE	SOURCE	\N	N	DEMO_WELLBORE
5	DEMO_WELL	DEMO_WELLBORE	SOURCE	\N	N	DEMO_WELLBORE
6	DEMO_WELL	DEMO_WELLBORE	SOURCE	\N	N	DEMO_WELLBORE
7	DEMO_WELL	DEMO_WELLBORE	SOURCE	\N	N	DEMO_WELLBORE
8	DEMO_WELL	DEMO_WELLBORE	SOURCE	\N	N	DEMO_WELLBORE
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.subscription (sub_id, id, name, apikey, remotehost, sourcehost, desiredfrequency, type, mode, config, active_status, device_type, device_id, sessionid, configmode, asset, rig) FROM stdin;
1	1	TestPublisher				0	0	1	{"deviceIndexType":"TIMESERIES","rigName":"DEMO_RIG","dataFlowMode":"async"}	N	WSocket	yellowhammer	null	sparse	\N	DEMO_RIG
3	3dbc5030-a85a-426f-b048-48d98d54f5d0	172.19.0.1-33094	8476509c72164674802e5471f3591435	172.19.0.1		0	0	0	{}	Y	null	null	5330959c-2404-4dd7-b911-7ab3096850e7	null	null	null
4	2edc5ff7-dda6-484d-a796-39036bc6faa5	172.19.0.1-41580	8476509c72164674802e5471f3591435	172.19.0.1		0	0	0	{}	N	null	null	7d37cd86-47e5-457a-b5e3-2f8d9a8ab416	null	null	null
5	7a82f52f-a204-43f5-8981-c30f5ea9cff4	172.19.0.1-36658	8476509c72164674802e5471f3591435	172.19.0.1		0	0	0	{}	N	null	null	f950f71f-a7c0-46b1-b86c-a63d78853173	null	null	null
\.


--
-- Data for Name: subscription_channel; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.subscription_channel (sub_channel_id, sub_id, uri, channelaction, uom, updated_on, active_status, mnemonic, from_uom, from_datatype, to_datatype) FROM stdin;
1	1	/well(DEMO_WELL)/wellbore(DEMO_WELLBORE)/log(EDR_SIMULATOR)/mnemonic(TestName)		UNITLESS	1625208155336	Y	TestName	\N	\N	\N
2	3	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(HKLD AVG)	SUBSCRIBE	UNITLESS	1685631512724	Y		\N	\N	
3	3	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(SPP AVG)	SUBSCRIBE	UNITLESS	1685631512724	Y		\N	\N	
6	3	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(ROP AVG)	SUBSCRIBE	UNITLESS	1685631512724	Y		\N	\N	
7	3	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(DEPTH)	SUBSCRIBE	UNITLESS	1685631512724	Y		\N	\N	
8	3	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(TORQUE AVG)	SUBSCRIBE	UNITLESS	1685631512724	Y		\N	\N	
9	3	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(TIME)	SUBSCRIBE	UNITLESS	1685631512724	Y		\N	\N	
10	4	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(HKLD AVG)	SUBSCRIBE	UNITLESS	1685701303992	Y		\N	\N	
11	4	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(SPP AVG)	SUBSCRIBE	UNITLESS	1685701303994	Y		\N	\N	
12	4	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(WOB AVG)	SUBSCRIBE	UNITLESS	1685701303994	Y		\N	\N	
13	4	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(BITDEP)	SUBSCRIBE	UNITLESS	1685701303994	Y		\N	\N	
14	4	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(ROP AVG)	SUBSCRIBE	UNITLESS	1685701303994	Y		\N	\N	
15	4	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(DEPTH)	SUBSCRIBE	UNITLESS	1685701303994	Y		\N	\N	
16	4	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(TORQUE AVG)	SUBSCRIBE	UNITLESS	1685701303994	Y		\N	\N	
17	4	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(TIME)	SUBSCRIBE	UNITLESS	1685701303994	Y		\N	\N	
18	5	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(HKLD AVG)	SUBSCRIBE	UNITLESS	1685701521354	Y		\N	\N	
19	5	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(SPP AVG)	SUBSCRIBE	UNITLESS	1685701521378	Y		\N	\N	
20	5	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(WOB AVG)	SUBSCRIBE	UNITLESS	1685701521378	Y		\N	\N	
21	5	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(BITDEP)	SUBSCRIBE	UNITLESS	1685701521378	Y		\N	\N	
22	5	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(ROP AVG)	SUBSCRIBE	UNITLESS	1685701521378	Y		\N	\N	
23	5	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(DEPTH)	SUBSCRIBE	UNITLESS	1685701521378	Y		\N	\N	
24	5	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(TORQUE AVG)	SUBSCRIBE	UNITLESS	1685701521378	Y		\N	\N	
25	5	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(TIME)	SUBSCRIBE	UNITLESS	1685701521378	Y		\N	\N	
4	3	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(WOB AVG)	SUBSCRIBE	UNITLESS	1685631512724	N		\N	\N	
5	3	/well(Sanity_Well)/wellbore(Sanity_Wellbore)/log(Sanity_Log)/mnemonic(BITDEP)	SUBSCRIBE	UNITLESS	1685631512724	N		\N	\N	
\.


--
-- Data for Name: unit_of_measurement; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.unit_of_measurement (id, symbol, name, dimension, is_si, category, base_unit, a, b, c, d, alias) FROM stdin;
1	%	percent	1	Y	atom-allowed	Euc	0	0.01	1	0	%,1%=100 Units
2	ppk	part per thousand	1	N	atom	Euc	0	0.001	1	0	ppk
3	ppm	part per million	1	N	atom	Euc	0	1e-06	1	0	ppm
4	Euc	euclid	1	Y	atom-allowed	IS-BASE	0	1	1	0	Euc
5	byte	byte	1	N	atom	bit	0	8	1	0	byte
6	bit	bit	1	Y	atom-allowed	IS-BASE	0	1	1	0	bit
7	%[mass]	percent [mass basis]	1	N	atom	kg/kg	0	0.01	1	0	%[mass]
8	ppm[mass]	part per million [mass basis]	1	N	atom	kg/kg	0	1e-06	1	0	ppm[mass]
9	%[area]	percent [area basis]	1	N	atom	m2/m2	0	0.01	1	0	%[area]
10	%[vol]	percent [volume basis]	1	N	atom	m3/m3	0	0.01	1	0	%[vol]
11	ppm[vol]	part per million [volume basis]	1	N	atom	m3/m3	0	1e-06	1	0	ppm[vol]
12	%[molar]	percent [molar basis]	1	N	atom	mol/mol	0	0.01	1	0	%[molar]
13	(bbl/d)/(bbl/d)	(barrel per day) per (barrel per day)	1	N	derived	(m3/s)/(m3/s)	0	1	1	0	(bbl/d)/(bbl/d)
14	(m3/d)/(m3/d)	(cubic metre per day) per (cubic metre per day)	1	Y	derived	(m3/s)/(m3/s)	0	1	1	0	(m3/d)/(m3/d)
15	1E6 (ft3/d)/(bbl/d)	(million cubic foot per day) per (barrel per day)	1	N	derived	(m3/s)/(m3/s)	0	28300	0.1589873	0	1E6 (ft3/d)/(bbl/d)
16	(m3/s)/(m3/s)	(cubic metre per second) per (cubic metre per second)	1	Y	derived	IS-BASE	0	1	1	0	(m3/s)/(m3/s)
17	kg/kg	kilogram per kilogram	1	Y	derived	IS-BASE	0	1	1	0	kg/kg
18	m/m	metre per metre	1	Y	derived	IS-BASE	0	1	1	0	m/m
19	m2/m2	square metre per square metre	1	Y	derived	IS-BASE	0	1	1	0	m2/m2
20	m3/m3	cubic metre per cubic metre	1	Y	derived	IS-BASE	0	1	1	0	m3/m3
21	mol/mol	mole per mole	1	Y	derived	IS-BASE	0	1	1	0	mol/mol
22	N/N	newton per newton	1	Y	derived	IS-BASE	0	1	1	0	N/N
23	s/s	second per second	1	Y	derived	IS-BASE	0	1	1	0	s/s
24	W/W	watt per watt	1	Y	derived	IS-BASE	0	1	1	0	W/W
25	g/kg	gram per kilogram	1	Y	derived	kg/kg	0	0.001	1	0	g/kg
26	g/t	gram per tonne	1	Y	derived	kg/kg	0	1e-06	1	0	g/t
27	kg/sack[94lbm]	kilogram per 94-pound-sack	1	N	derived	kg/kg	0	1	42.637684	0	kg/sack[94lbm]
28	kg/t	kilogram per tonne	1	Y	derived	kg/kg	0	0.001	1	0	kg/t
29	mg/g	milligram per gram	1	Y	derived	kg/kg	0	0.001	1	0	mg/g
30	mg/kg	milligram per kilogram	1	Y	derived	kg/kg	0	1e-06	1	0	mg/kg
31	ng/g	nanogram per gram	1	Y	derived	kg/kg	0	1e-09	1	0	ng/g
32	ng/mg	nanogram per milligram	1	Y	derived	kg/kg	0	1e-06	1	0	ng/mg
33	ug/g	microgram per gram	1	Y	derived	kg/kg	0	1e-06	1	0	ug/g
34	ug/mg	microgram per milligram	1	Y	derived	kg/kg	0	0.001	1	0	ug/mg
35	0.01 ft/ft	foot per hundred foot	1	N	derived	m/m	0	0.01	1	0	0.01 ft/ft
36	1/30 m/m	metre per thirty metre	1	N	derived	m/m	0	1	30	0	1/30 m/m
37	ft/ft	foot per foot	1	N	derived	m/m	0	1	1	0	ft/ft
38	ft/in	foot per inch	1	N	derived	m/m	0	12	1	0	ft/in
39	ft/m	foot per metre	1	N	derived	m/m	0	0.3048	1	0	ft/m
40	ft/mi	foot per mile	1	N	derived	m/m	0	1	5280	0	ft/mi
41	km/cm	kilometre per centimetre	1	Y	derived	m/m	0	100000	1	0	km/cm
42	m/cm	metre per centimetre	1	Y	derived	m/m	0	100	1	0	m/cm
43	m/km	metre per kilometre	1	Y	derived	m/m	0	0.001	1	0	m/km
44	mi/in	mile per inch	1	N	derived	m/m	0	63360	1	0	mi/in
45	in2/ft2	square inch per square foot	1	N	derived	m2/m2	0	1	144	0	in2/ft2
46	in2/in2	square inch per square inch	1	N	derived	m2/m2	0	1	1	0	in2/in2
47	mm2/mm2	square millimetre per square millimetre	1	Y	derived	m2/m2	0	1	1	0	mm2/mm2
48	0.001 bbl/ft3	barrel per thousand cubic foot	1	N	derived	m3/m3	0	0.000159	0.028316846	0	0.001 bbl/ft3
49	0.001 bbl/m3	barrel per thousand cubic metre	1	N	derived	m3/m3	0	0.000159	1	0	0.001 bbl/m3
50	0.001 gal[UK]/bbl	UK gallon per thousand barrel	1	N	derived	m3/m3	0	4.55e-06	0.1589873	0	0.001 gal[UK]/bbl
51	0.001 gal[UK]/gal[UK]	UK gallon per thousand UK gallon	1	N	derived	m3/m3	0	0.001	1	0	0.001 gal[UK]/gal[UK]
52	0.001 gal[US]/bbl	US gallon per thousand barrel	1	N	derived	m3/m3	0	3.79e-06	0.1589873	0	0.001 gal[US]/bbl
53	0.001 gal[US]/ft3	US gallon per thousand cubic foot	1	N	derived	m3/m3	0	3.79e-06	0.028316846	0	0.001 gal[US]/ft3
54	0.001 gal[US]/gal[US]	US gallon per thousand US gallon	1	N	derived	m3/m3	0	0.001	1	0	0.001 gal[US]/gal[US]
55	0.001 pt[UK]/bbl	UK pint per thousand barrel	1	N	derived	m3/m3	0	0.000568	158.98729	0	0.001 pt[UK]/bbl
56	0.01 bbl/bbl	barrel per hundred barrel	1	N	derived	m3/m3	0	0.01	1	0	0.01 bbl/bbl
57	0.1 gal[US]/bbl	US gallon per ten barrel	1	N	derived	m3/m3	0	0.000379	0.1589873	0	0.1 gal[US]/bbl
58	0.1 L/bbl	litre per ten barrel	1	N	derived	m3/m3	0	0.001	1.589873	0	0.1 L/bbl
59	0.1 pt[US]/bbl	US pint per ten barrel	1	N	derived	m3/m3	0	0.000473	1.589873	0	0.1 pt[US]/bbl
60	1000 ft3/bbl	thousand cubic foot per barrel	1	N	derived	m3/m3	0	28.316847	0.1589873	0	1000 ft3/bbl
61	1000 m3/m3	thousand cubic metre per cubic metre	1	N	derived	m3/m3	0	1000	1	0	1000 m3/m3
62	1E-6 acre.ft/bbl	acre foot per million barrel	1	N	derived	m3/m3	0	19100	2.46e+06	0	1E-6 acre.ft/bbl
63	1E6 bbl/(acre.ft)	million barrel per acre foot	1	N	derived	m3/m3	0	2.46e+12	1.91e+10	0	1E6 bbl/(acre.ft)
64	1E-6 bbl/ft3	barrel per million cubic foot	1	N	derived	m3/m3	0	0.1589873	28300	0	1E-6 bbl/ft3
65	1E-6 bbl/m3	barrel per million cubic metre	1	N	derived	m3/m3	0	1.59e-07	1	0	1E-6 bbl/m3
66	1E6 ft3/(acre.ft)	million cubic foot per acre foot	1	N	derived	m3/m3	0	1.44e+12	6.27e+10	0	1E6 ft3/(acre.ft)
67	1E6 ft3/bbl	million cubic foot per barrel	1	N	derived	m3/m3	0	28300	0.1589873	0	1E6 ft3/bbl
68	bbl/(acre.ft)	barrel per acre foot	1	N	derived	m3/m3	0	2.46e+06	1.91e+10	0	bbl/(acre.ft)
69	bbl/bbl	barrel per barrel	1	N	derived	m3/m3	0	1	1	0	bbl/bbl
70	bbl/ft3	barrel per cubic foot	1	N	derived	m3/m3	0	0.1589873	0.028316846	0	bbl/ft3
71	bbl/m3	barrel per cubic metre	1	N	derived	m3/m3	0	0.1589873	1	0	bbl/m3
72	cm3/cm3	cubic centimetre per cubic centimetre	1	Y	derived	m3/m3	0	1	1	0	cm3/cm3
73	cm3/L	cubic centimetre per litre	1	Y	derived	m3/m3	0	0.001	1	0	cm3/L
74	cm3/m3	cubic centimetre per cubic metre	1	Y	derived	m3/m3	0	1e-06	1	0	cm3/m3
75	dm3/m3	cubic decimetre per cubic metre	1	Y	derived	m3/m3	0	0.001	1	0	dm3/m3
76	ft3/bbl	cubic foot per barrel	1	N	derived	m3/m3	0	0.028316846	0.1589873	0	ft3/bbl
77	ft3/ft3	cubic foot per cubic foot	1	N	derived	m3/m3	0	1	1	0	ft3/ft3
78	gal[UK]/ft3	UK gallon per cubic foot	1	N	derived	m3/m3	0	0.00455	0.028316846	0	gal[UK]/ft3
79	gal[US]/bbl	US gallon per barrel	1	N	derived	m3/m3	0	0.00379	0.1589873	0	gal[US]/bbl
80	gal[US]/ft3	US gallon per cubic foot	1	N	derived	m3/m3	0	0.00379	0.028316846	0	gal[US]/ft3
81	L/m3	litre per cubic metre	1	Y	derived	m3/m3	0	0.001	1	0	L/m3
82	m3/(ha.m)	cubic metre per hectare metre	1	Y	derived	m3/m3	0	0.0001	1	0	m3/(ha.m)
83	m3/bbl	cubic metre per barrel	1	N	derived	m3/m3	0	1	0.1589873	0	m3/bbl
84	mL/gal[UK]	millilitre per UK gallon	1	N	derived	m3/m3	0	1e-06	0.00455	0	mL/gal[UK]
85	mL/gal[US]	millilitre per US gallon	1	N	derived	m3/m3	0	1e-06	0.00379	0	mL/gal[US]
86	mL/mL	millilitre per millilitre	1	Y	derived	m3/m3	0	1	1	0	mL/mL
87	kgf/kgf	thousand gram-force per kilogram-force	1	N	derived	N/N	0	1	1	0	kgf/kgf
88	lbf/lbf	pound-force per pound-force	1	N	derived	N/N	0	1	1	0	lbf/lbf
89	ms/s	millisecond per second	1	Y	derived	s/s	0	0.001	1	0	ms/s
90	Btu[IT]/(hp.h)	BTU per horsepower hour	1	N	derived	W/W	0	1060	2.68e+06	0	Btu[IT]/(hp.h)
91	W/kW	watt per kilowatt	1	Y	derived	W/W	0	0.001	1	0	W/kW
92	cEuc	centieuclid	1	Y	prefixed	Euc	0	0.01	1	0	cEuc
93	dEuc	decieuclid	1	Y	prefixed	Euc	0	0.1	1	0	dEuc
94	EEuc	exaeuclid	1	Y	prefixed	Euc	0	1e+18	1	0	EEuc
95	fEuc	femtoeuclid	1	Y	prefixed	Euc	0	1e-15	1	0	fEuc
96	GEuc	gigaeuclid	1	Y	prefixed	Euc	0	1e+09	1	0	GEuc
97	kEuc	kiloeuclid	1	Y	prefixed	Euc	0	1000	1	0	kEuc
98	mEuc	millieuclid	1	Y	prefixed	Euc	0	0.001	1	0	mEuc
99	MEuc	megaeuclid	1	Y	prefixed	Euc	0	1e+06	1	0	MEuc
100	nEuc	nanoeuclid	1	Y	prefixed	Euc	0	1e-09	1	0	nEuc
101	pEuc	picoeuclid	1	Y	prefixed	Euc	0	1e-12	1	0	pEuc
102	TEuc	teraeuclid	1	Y	prefixed	Euc	0	1e+12	1	0	TEuc
103	uEuc	microeuclid	1	Y	prefixed	Euc	0	1e-06	1	0	uEuc
104	Kibyte	kibibyte	1	N	prefixed	bit	0	8192	1	0	Kibyte
105	Mibyte	mebibyte	1	N	prefixed	bit	0	8.388608e+06	1	0	Mibyte
106	1/deltaC	per delta Celsius	1/D	Y	derived	1/deltaK	0	1	1	0	1/deltaC
107	1/deltaF	per delta Fahrenheit	1/D	N	derived	1/deltaK	0	9	5	0	1/deltaF
108	1/deltaR	per delta Rankine	1/D	N	derived	1/deltaK	0	9	5	0	1/deltaR
109	1/deltaK	per delta kelvin	1/D	Y	derived	IS-BASE	0	1	1	0	1/deltaK
110	m/(m.deltaK)	metre per metre delta kelvin	1/D	Y	derived	IS-BASE	0	1	1	0	m/(m.deltaK)
111	m3/(m3.deltaK)	cubic metre per cubic metre delta kelvin	1/D	Y	derived	IS-BASE	0	1	1	0	m3/(m3.deltaK)
112	in/(in.deltaF)	inch per inch delta Fahrenheit	1/D	N	derived	m/(m.deltaK)	0	9	5	0	in/(in.deltaF)
113	mm/(mm.deltaK)	millimetre per millimetre delta kelvin	1/D	Y	derived	m/(m.deltaK)	0	1	1	0	mm/(mm.deltaK)
114	1E-6 m3/(m3.deltaC)	(cubic metre per million cubic metre) per delta Celsius	1/D	N	derived	m3/(m3.deltaK)	0	1e-06	1	0	1E-6 m3/(m3.deltaC)
115	1E-6 m3/(m3.deltaF)	(cubic metre per million cubic metre) per delta Fahrenheit	1/D	N	derived	m3/(m3.deltaK)	0	9e-06	5	0	1E-6 m3/(m3.deltaF)
116	ppm[vol]/deltaC	(part per million [volume basis]) per delta Celsius	1/D	N	derived	m3/(m3.deltaK)	0	1e-06	1	0	ppm[vol]/deltaC
117	ppm[vol]/deltaF	(part per million [volume basis)] per delta Fahrenheit	1/D	N	derived	m3/(m3.deltaK)	0	9e-06	5	0	ppm[vol]/deltaF
118	cu	capture unit	1/L	N	atom	m2/m3	0	0.1	1	0	cu
119	1/angstrom	per angstrom	1/L	Y	derived	1/m	0	1e+10	1	0	1/angstrom
120	1/cm	per centimetre	1/L	Y	derived	1/m	0	100	1	0	1/cm
121	1/ft	per foot	1/L	N	derived	1/m	0	1	0.3048	0	1/ft
122	1/in	per inch	1/L	N	derived	1/m	0	1	0.0254	0	1/in
123	1/mi	per mile	1/L	N	derived	1/m	0	1	1609.344	0	1/mi
124	1/mm	per millimetre	1/L	Y	derived	1/m	0	1000	1	0	1/mm
125	1/nm	per nanometre	1/L	Y	derived	1/m	0	1e+09	1	0	1/nm
126	1/yd	per yard	1/L	N	derived	1/m	0	1	0.9144	0	1/yd
127	1E-9 1/ft	per thousand million foot	1/L	N	derived	1/m	0	1e-09	0.3048	0	1E-9 1/ft
128	b/cm3	barn per cubic centimetre	1/L	Y	derived	1/m	0	1e-22	1	0	b/cm3
129	ft2/in3	square foot per cubic inch	1/L	N	derived	1/m	0	0.09290304	1.64e-05	0	ft2/in3
130	m2/cm3	square metre per cubic centimetre	1/L	Y	derived	1/m	0	1e+06	1	0	m2/cm3
131	1/m	per metre	1/L	Y	derived	IS-BASE	0	1	1	0	1/m
132	m2/m3	square metre per cubic metre	1/L	Y	derived	IS-BASE	0	1	1	0	m2/m3
133	1/ft2	per square foot	1/L2	N	derived	1/m2	0	1	0.09290304	0	1/ft2
134	1/km2	per square kilometre	1/L2	Y	derived	1/m2	0	1e-06	1	0	1/km2
135	1/mi2	per square mile	1/L2	N	derived	1/m2	0	1	2.59e+06	0	1/mi2
136	1/m2	per square metre	1/L2	Y	derived	IS-BASE	0	1	1	0	1/m2
137	m/m3	metre per cubic metre	1/L2	Y	derived	IS-BASE	0	1	1	0	m/m3
138	ft/bbl	foot per barrel	1/L2	N	derived	m/m3	0	0.3048	0.1589873	0	ft/bbl
139	ft/ft3	foot per cubic foot	1/L2	N	derived	m/m3	0	1	0.09290304	0	ft/ft3
140	ft/gal[US]	foot per US gallon	1/L2	N	derived	m/m3	0	0.3048	0.003785412	0	ft/gal[US]
141	km/dm3	kilometre per cubic decimetre	1/L2	Y	derived	m/m3	0	1e+06	1	0	km/dm3
142	km/L	kilometre per litre	1/L2	Y	derived	m/m3	0	1e+06	1	0	km/L
143	mi/gal[UK]	mile per UK gallon	1/L2	N	derived	m/m3	0	1609.344	0.00454609	0	mi/gal[UK]
144	mi/gal[US]	mile per US gallon	1/L2	N	derived	m/m3	0	1609.344	0.003785412	0	mi/gal[US]
145	1/bbl	per barrel	1/L3	N	derived	1/m3	0	1	0.1589873	0	1/bbl
146	1/ft3	per cubic foot	1/L3	N	derived	1/m3	0	1	0.028316846	0	1/ft3
147	1/gal[UK]	per UK gallon	1/L3	N	derived	1/m3	0	1	0.00454609	0	1/gal[UK]
148	1/gal[US]	per US gallon	1/L3	N	derived	1/m3	0	1	0.003785412	0	1/gal[US]
149	1/L	per litre	1/L3	Y	derived	1/m3	0	1000	1	0	1/L
150	1/m3	per cubic metre	1/L3	Y	derived	IS-BASE	0	1	1	0	1/m3
151	1/g	per gram	1/M	Y	derived	1/kg	0	1000	1	0	1/g
152	1/lbm	per pound	1/M	N	derived	1/kg	0	1	0.45359236	0	1/lbm
153	1/kg	per kilogram	1/M	Y	derived	IS-BASE	0	1	1	0	1/kg
154	1/(kg.s)	per (kilogram per second)	1/MT	Y	derived	Bq/kg	0	1	1	0	1/(kg.s)
155	pCi/g	picocurie per gram	1/MT	N	derived	Bq/kg	0	37	1	0	pCi/g
156	Bq/kg	becquerel per kilogram	1/MT	Y	derived	IS-BASE	0	1	1	0	Bq/kg
157	Ci	curie	1/T	Y	atom-allowed	Bq	0	3.7e+10	1	0	Ci
158	Bd	baud	1/T	Y	atom-allowed	IS-BASE	0	1	1	0	Bd
159	Bq	becquerel	1/T	Y	atom-special	IS-BASE	0	1	1	0	Bq
160	Hz	hertz	1/T	Y	atom-special	IS-BASE	0	1	1	0	Hz
161	1/a	per julian-year	1/T	N	derived	1/s	0	1	3.16e+07	0	1/a
162	1/d	per day	1/T	Y	derived	1/s	0	1	86400	0	1/d
163	1/h	per hour	1/T	Y	derived	1/s	0	1	3600	0	1/h
164	1/min	per minute	1/T	Y	derived	1/s	0	1	60	0	1/min
165	1/ms	per millisecond	1/T	Y	derived	1/s	0	1000	1	0	1/ms
166	1/us	per microsecond	1/T	Y	derived	1/s	0	1e+06	1	0	1/us
167	1/wk	per week	1/T	N	derived	1/s	0	1	605000	0	1/wk
168	byte/s	byte per second	1/T	N	derived	bit/s	0	8	1	0	byte/s
169	1/s	per second	1/T	Y	derived	IS-BASE	0	1	1	0	1/s
170	bit/s	bit per second	1/T	Y	derived	IS-BASE	0	1	1	0	bit/s
171	m3/(s.m3)	cubic metre per time cubic metre	1/T	Y	derived	IS-BASE	0	1	1	0	m3/(s.m3)
172	bbl/(d.acre.ft)	barrel per day acre foot	1/T	N	derived	m3/(s.m3)	0	2.46e+06	1.65e+15	0	bbl/(d.acre.ft)
173	GBq	gigabecquerel	1/T	Y	prefixed	Bq	0	1e+09	1	0	GBq
174	MBq	megabecquerel	1/T	Y	prefixed	Bq	0	1e+06	1	0	MBq
175	mCi	thousandth of curie	1/T	N	prefixed	Bq	0	3.7e+07	1	0	mCi
176	nCi	nanocurie	1/T	N	prefixed	Bq	0	37	1	0	nCi
177	pCi	picocurie	1/T	N	prefixed	Bq	0	0.037	1	0	pCi
178	TBq	terabecquerel	1/T	Y	prefixed	Bq	0	1e+12	1	0	TBq
179	uCi	millionth of curie	1/T	N	prefixed	Bq	0	37000	1	0	uCi
180	cHz	centihertz	1/T	Y	prefixed	Hz	0	0.01	1	0	cHz
181	dHz	decihertz	1/T	Y	prefixed	Hz	0	0.1	1	0	dHz
182	EHz	exahertz	1/T	Y	prefixed	Hz	0	1e+18	1	0	EHz
183	fHz	femtohertz	1/T	Y	prefixed	Hz	0	1e-15	1	0	fHz
184	GHz	gigahertz	1/T	Y	prefixed	Hz	0	1e+09	1	0	GHz
185	kHz	kilohertz	1/T	Y	prefixed	Hz	0	1000	1	0	kHz
186	mHz	millihertz	1/T	Y	prefixed	Hz	0	0.001	1	0	mHz
187	MHz	megahertz	1/T	Y	prefixed	Hz	0	1e+06	1	0	MHz
188	nHz	nanohertz	1/T	Y	prefixed	Hz	0	1e-09	1	0	nHz
189	pHz	picohertz	1/T	Y	prefixed	Hz	0	1e-12	1	0	pHz
190	THz	terahertz	1/T	Y	prefixed	Hz	0	1e+12	1	0	THz
191	uHz	microhertz	1/T	Y	prefixed	Hz	0	1e-06	1	0	uHz
192	rad	radian	A	Y	atom-special	IS-BASE	0	1	1	0	rad
193	ccgr	centesimal-second	A	N	atom	rad	0	3.1415	2e+06	0	ccgr
194	cgr	centesimal-minute	A	N	atom	rad	0	3.1415	20000	0	cgr
195	dega	angular degree	A	Y	atom-allowed	rad	0	3.1415	180	0	dega
196	gon	gon	A	N	atom	rad	0	3.1415	200	0	gon
197	mila	angular mil	A	N	atom	rad	0	3.1415	3200	0	mila
198	mina	angular minute	A	Y	atom-allowed	rad	0	3.1415	10800	0	mina
199	rev	revolution	A	N	atom	rad	0	6.283	1	0	rev
200	seca	angular second	A	Y	atom-allowed	rad	0	3.1415	648000	0	seca
201	0.001 seca	angular millisecond	A	N	derived	rad	0	3.1415	6.48e+08	0	0.001 seca
202	krad	kiloradian	A	Y	prefixed	rad	0	1000	1	0	krad
203	mrad	milliradian	A	Y	prefixed	rad	0	0.001	1	0	mrad
204	Mrad	megaradian	A	Y	prefixed	rad	0	1e+06	1	0	Mrad
205	urad	microradian	A	Y	prefixed	rad	0	1e-06	1	0	urad
206	rad/m	radian per metre	A/L	Y	derived	IS-BASE	0	1	1	0	rad/m
207	0.01 dega/ft	angular degree per hundred foot	A/L	N	derived	rad/m	0	3.1415	5490	0	0.01 dega/ft,dega/100ft
208	1/30 dega/ft	angular degree per thirty foot	A/L	N	derived	rad/m	0	3.1415	1650	0	1/30 dega/ft
209	1/30 dega/m	angular degree per thirty metre	A/L	N	derived	rad/m	0	3.1415	5400	0	1/30 dega/m
210	dega/ft	angular degree per foot	A/L	N	derived	rad/m	0	3.1415	54.864	0	dega/ft
211	dega/m	angular degree per metre	A/L	Y	derived	rad/m	0	3.1415	180	0	dega/m
212	rad/ft	radian per foot	A/L	N	derived	rad/m	0	1	0.3048	0	rad/ft
213	rev/ft	revolution per foot	A/L	N	derived	rad/m	0	6.283	0.3048	0	rev/ft
214	rev/m	revolution per metre	A/L	N	derived	rad/m	0	6.283	1	0	rev/m
215	rad/m3	radian per cubic metre	A/L3	Y	derived	IS-BASE	0	1	1	0	rad/m3
216	rad/ft3	radian per cubic foot	A/L3	N	derived	rad/m3	0	1	0.028316846	0	rad/ft3
217	rpm	revolution per minute	A/T	N	atom	rad/s	0	6.283	60	0	rpm
218	rad/s	radian per second	A/T	Y	derived	IS-BASE	0	1	1	0	rad/s
219	dega/h	angular degree per hour	A/T	Y	derived	rad/s	0	3.1415	648000	0	dega/h
220	dega/min	angular degree per minute	A/T	Y	derived	rad/s	0	3.1415	10800	0	dega/min
221	dega/s	angular degree per second	A/T	Y	derived	rad/s	0	3.1415	180	0	dega/s
222	rev/s	revolution per second	A/T	N	derived	rad/s	0	6.283	1	0	rev/s
223	rad/s2	radian per second squared	A/T2	Y	derived	IS-BASE	0	1	1	0	rad/s2
224	rpm/s	(revolution per minute) per second	A/T2	N	derived	rad/s2	0	6.283	60	0	rpm/s
225	deltaC	delta Celsius	D	Y	atom-special	deltaK	0	1	1	0	deltaC
226	deltaF	delta Fahrenheit	D	N	atom	deltaK	0	5	9	0	deltaF
227	deltaR	delta Rankine	D	N	atom	deltaK	0	5	9	0	deltaR
228	deltaK	delta kelvin	D	Y	atom-special	IS-BASE	0	1	1	0	deltaK
229	0.01 deltaF/ft	delta Fahrenheit per hundred foot	D/L	N	derived	deltaK/m	0	5	274.32	0	0.01 deltaF/ft
230	deltaC/ft	delta Celsius per foot	D/L	N	derived	deltaK/m	0	1	0.3048	0	deltaC/ft
231	deltaC/hm	delta Celsius per hectometre	D/L	Y	derived	deltaK/m	0	0.01	1	0	deltaC/hm
232	deltaC/km	delta Celsius per kilometre	D/L	Y	derived	deltaK/m	0	0.001	1	0	deltaC/km
233	deltaC/m	delta Celsius per metre	D/L	Y	derived	deltaK/m	0	1	1	0	deltaC/m
234	deltaF/ft	delta Fahrenheit per foot	D/L	N	derived	deltaK/m	0	5	2.7432	0	deltaF/ft
235	deltaF/m	delta Fahrenheit per metre	D/L	N	derived	deltaK/m	0	5	9	0	deltaF/m
236	deltaK/km	delta kelvin per kilometre	D/L	Y	derived	deltaK/m	0	0.001	1	0	deltaK/km
237	deltaK/m	delta kelvin per metre	D/L	Y	derived	IS-BASE	0	1	1	0	deltaK/m
238	deltaC/h	delta Celsius per hour	D/T	Y	derived	deltaK/s	0	1	3600	0	deltaC/h
239	deltaC/min	delta Celsius per minute	D/T	Y	derived	deltaK/s	0	1	60	0	deltaC/min
240	deltaC/s	delta Celsius per second	D/T	Y	derived	deltaK/s	0	1	1	0	deltaC/s
241	deltaF/h	delta Fahrenheit per hour	D/T	N	derived	deltaK/s	0	5	32400	0	deltaF/h
242	deltaF/min	delta Fahrenheit per minute	D/T	N	derived	deltaK/s	0	5	540	0	deltaF/min
243	deltaF/s	delta Fahrenheit per second	D/T	N	derived	deltaK/s	0	5	9	0	deltaF/s
244	deltaK/s	delta kelvin per second	D/T	Y	derived	IS-BASE	0	1	1	0	deltaK/s
245	deltaC/kPa	delta Celsius per kilopascal	DLT2/M	Y	derived	deltaK/Pa	0	0.001	1	0	deltaC/kPa
246	deltaF/psi	delta Fahrenheit per psi	DLT2/M	N	derived	deltaK/Pa	0	0.00323	40.033993	0	deltaF/psi
247	deltaK/Pa	delta kelvin per Pascal	DLT2/M	Y	derived	IS-BASE	0	1	1	0	deltaK/Pa
248	deltaK/W	delta kelvin per watt	DT3/L2M	Y	derived	IS-BASE	0	1	1	0	deltaK/W
249	deltaC.m2.h/kcal[th]	delta Celsius square metre hour per thousand calory	DT3/M	N	derived	deltaK.m2/W	0	3600	4180	0	deltaC.m2.h/kcal[th]
250	deltaF.ft2.h/Btu[IT]	delta Fahrenheit square foot hour per BTU	DT3/M	N	derived	deltaK.m2/W	0	1670	9500	0	deltaF.ft2.h/Btu[IT]
251	deltaK.m2/kW	delta kelvin square metre per kilowatt	DT3/M	Y	derived	deltaK.m2/W	0	0.001	1	0	deltaK.m2/kW
252	deltaK.m2/W	delta kelvin square metre per watt	DT3/M	Y	derived	IS-BASE	0	1	1	0	deltaK.m2/W
253	A	ampere	I	Y	atom-base	IS-BASE	0	1	1	0	A
254	cA	centiampere	I	Y	prefixed	A	0	0.01	1	0	cA
255	dA	deciampere	I	Y	prefixed	A	0	0.1	1	0	dA
256	EA	exaampere	I	Y	prefixed	A	0	1e+18	1	0	EA
257	fA	femtoampere	I	Y	prefixed	A	0	1e-15	1	0	fA
258	GA	gigaampere	I	Y	prefixed	A	0	1e+09	1	0	GA
259	kA	kiloampere	I	Y	prefixed	A	0	1000	1	0	kA
260	mA	milliampere	I	Y	prefixed	A	0	0.001	1	0	mA
261	MA	megaampere	I	Y	prefixed	A	0	1e+06	1	0	MA
262	nA	nanoampere	I	Y	prefixed	A	0	1e-09	1	0	nA
263	pA	picoampere	I	Y	prefixed	A	0	1e-12	1	0	pA
264	TA	teraampere	I	Y	prefixed	A	0	1e+12	1	0	TA
265	uA	microampere	I	Y	prefixed	A	0	1e-06	1	0	uA
266	Oe	oersted	I/L	N	atom	A/m	0	1000	12.566	0	Oe
267	A/mm	ampere per millimetre	I/L	Y	derived	A/m	0	1000	1	0	A/mm
268	A/m	ampere per metre	I/L	Y	derived	IS-BASE	0	1	1	0	A/m
269	A/cm2	ampere per square centimetre	I/L2	Y	derived	A/m2	0	10000	1	0	A/cm2
270	A/ft2	ampere per square foot	I/L2	N	derived	A/m2	0	1	0.09290304	0	A/ft2
271	A/mm2	ampere per square millimetre	I/L2	Y	derived	A/m2	0	1e+06	1	0	A/mm2
272	mA/cm2	milliampere per square centimetre	I/L2	Y	derived	A/m2	0	10	1	0	mA/cm2
273	mA/ft2	milliampere per square foot	I/L2	N	derived	A/m2	0	0.001	0.09290304	0	mA/ft2
274	uA/cm2	microampere per square centimetre	I/L2	Y	derived	A/m2	0	0.01	1	0	uA/cm2
275	uA/in2	microampere per square inch	I/L2	N	derived	A/m2	0	1e-06	0.000645	0	uA/in2
276	A/m2	ampere per square metre	I/L2	Y	derived	IS-BASE	0	1	1	0	A/m2
277	1/H	per henry	I2T2/L2M	Y	derived	IS-BASE	0	1	1	0	1/H
278	S	siemens	I2T3/L2M	Y	atom-special	IS-BASE	0	1	1	0	S
279	cS	centisiemens	I2T3/L2M	Y	prefixed	S	0	0.01	1	0	cS
280	dS	decisiemens	I2T3/L2M	Y	prefixed	S	0	0.1	1	0	dS
281	ES	exasiemens	I2T3/L2M	Y	prefixed	S	0	1e+18	1	0	ES
282	fS	femtosiemens	I2T3/L2M	Y	prefixed	S	0	1e-15	1	0	fS
283	GS	gigasiemens	I2T3/L2M	Y	prefixed	S	0	1e+09	1	0	GS
284	kS	kilosiemens	I2T3/L2M	Y	prefixed	S	0	1000	1	0	kS
285	mS	millisiemens	I2T3/L2M	Y	prefixed	S	0	0.001	1	0	mS
286	MS	megasiemens	I2T3/L2M	Y	prefixed	S	0	1e+06	1	0	MS
287	nS	nanosiemens	I2T3/L2M	Y	prefixed	S	0	1e-09	1	0	nS
288	pS	picosiemens	I2T3/L2M	Y	prefixed	S	0	1e-12	1	0	pS
289	TS	terasiemens	I2T3/L2M	Y	prefixed	S	0	1e+12	1	0	TS
290	uS	microsiemens	I2T3/L2M	Y	prefixed	S	0	1e-06	1	0	uS
291	S/m	siemens per metre	I2T3/L3M	Y	derived	IS-BASE	0	1	1	0	S/m
292	kS/m	kilosiemens per metre	I2T3/L3M	Y	derived	S/m	0	1000	1	0	kS/m
293	mS/cm	millisiemens per centimetre	I2T3/L3M	Y	derived	S/m	0	0.1	1	0	mS/cm,mmho/cm
294	mS/m	millisiemens per metre	I2T3/L3M	Y	derived	S/m	0	0.001	1	0	mS/m
295	F	farad	I2T4/L2M	Y	atom-special	IS-BASE	0	1	1	0	F
296	cF	centifarad	I2T4/L2M	Y	prefixed	F	0	0.01	1	0	cF
297	dF	decifarad	I2T4/L2M	Y	prefixed	F	0	0.1	1	0	dF
298	EF	exafarad	I2T4/L2M	Y	prefixed	F	0	1e+18	1	0	EF
299	fF	femtofarad	I2T4/L2M	Y	prefixed	F	0	1e-15	1	0	fF
300	GF	gigafarad	I2T4/L2M	Y	prefixed	F	0	1e+09	1	0	GF
301	kF	kilofarad	I2T4/L2M	Y	prefixed	F	0	1000	1	0	kF
302	mF	millifarad	I2T4/L2M	Y	prefixed	F	0	0.001	1	0	mF
303	MF	megafarad	I2T4/L2M	Y	prefixed	F	0	1e+06	1	0	MF
304	nF	nanofarad	I2T4/L2M	Y	prefixed	F	0	1e-09	1	0	nF
305	pF	picofarad	I2T4/L2M	Y	prefixed	F	0	1e-12	1	0	pF
306	TF	terafarad	I2T4/L2M	Y	prefixed	F	0	1e+12	1	0	TF
307	uF	microfarad	I2T4/L2M	Y	prefixed	F	0	1e-06	1	0	uF
308	uF/m	microfarad per metre	I2T4/L3M	Y	derived	F/m	0	1e-06	1	0	uF/m
309	F/m	farad per metre	I2T4/L3M	Y	derived	IS-BASE	0	1	1	0	F/m
310	A.m2	ampere square metre	IL2	Y	derived	IS-BASE	0	1	1	0	A.m2
311	C.m	coulomb metre	ILT	Y	derived	IS-BASE	0	1	1	0	C.m
312	C	coulomb	IT	Y	atom-special	IS-BASE	0	1	1	0	C
313	A.h	ampere hour	IT	Y	derived	C	0	3600	1	0	A.h
314	A.s	ampere second	IT	Y	derived	C	0	1	1	0	A.s
315	cC	centicoulomb	IT	Y	prefixed	C	0	0.01	1	0	cC
316	dC	decicoulomb	IT	Y	prefixed	C	0	0.1	1	0	dC
317	EC	exacoulomb	IT	Y	prefixed	C	0	1e+18	1	0	EC
318	fC	femtocoulomb	IT	Y	prefixed	C	0	1e-15	1	0	fC
319	GC	gigacoulomb	IT	Y	prefixed	C	0	1e+09	1	0	GC
320	kC	kilocoulomb	IT	Y	prefixed	C	0	1000	1	0	kC
321	mC	millicoulomb	IT	Y	prefixed	C	0	0.001	1	0	mC
322	MC	megacoulomb	IT	Y	prefixed	C	0	1e+06	1	0	MC
323	nC	nanocoulomb	IT	Y	prefixed	C	0	1e-09	1	0	nC
324	pC	picocoulomb	IT	Y	prefixed	C	0	1e-12	1	0	pC
325	TC	teracoulomb	IT	Y	prefixed	C	0	1e+12	1	0	TC
326	uC	microcoulomb	IT	Y	prefixed	C	0	1e-06	1	0	uC
327	C/cm2	coulomb per square centimetre	IT/L2	Y	derived	C/m2	0	10000	1	0	C/cm2
328	C/mm2	coulomb per square millimetre	IT/L2	Y	derived	C/m2	0	1e+06	1	0	C/mm2
329	mC/m2	millicoulomb per square metre	IT/L2	Y	derived	C/m2	0	0.001	1	0	mC/m2
330	C/m2	coulomb per square metre	IT/L2	Y	derived	IS-BASE	0	1	1	0	C/m2
331	A.s/m3	ampere second per cubic metre	IT/L3	Y	derived	C/m3	0	1	1	0	A.s/m3
332	C/cm3	coulomb per cubic centimetre	IT/L3	Y	derived	C/m3	0	1e+06	1	0	C/cm3
333	C/mm3	coulomb per cubic millimetre	IT/L3	Y	derived	C/m3	0	1e+09	1	0	C/mm3
334	C/m3	coulomb per cubic metre	IT/L3	Y	derived	IS-BASE	0	1	1	0	C/m3
335	A.s/kg	ampere second per kilogram	IT/M	Y	derived	C/kg	0	1	1	0	A.s/kg
336	C/g	coulomb per gram	IT/M	Y	derived	C/kg	0	1000	1	0	C/g
337	C/kg	coulomb per kilogram	IT/M	Y	derived	IS-BASE	0	1	1	0	C/kg
338	1/uV	per microvolt	IT3/L2M	Y	derived	1/V	0	1e+06	1	0	1/uV
339	1/V	per volt	IT3/L2M	Y	derived	IS-BASE	0	1	1	0	1/V
340	cd	candela	J	Y	atom-base	IS-BASE	0	1	1	0	cd
341	kcd	kilocandela	J	Y	prefixed	cd	0	1000	1	0	kcd
342	cd/m2	candela per square metre	J/L2	Y	derived	IS-BASE	0	1	1	0	cd/m2
343	lm	lumen	JS	Y	atom-special	IS-BASE	0	1	1	0	lm
344	lx	lux	JS/L2	Y	atom-special	IS-BASE	0	1	1	0	lx
345	footcandle	footcandle	JS/L2	N	atom	lx	0	1	0.09290304	0	footcandle
346	lm/m2	lumen per square metre	JS/L2	Y	derived	lx	0	1	1	0	lm/m2
347	klx	kilolux	JS/L2	Y	prefixed	lx	0	1000	1	0	klx
348	lm.s	lumen second	JST	Y	derived	IS-BASE	0	1	1	0	lm.s
349	lx.s	lux second	JST/L2	Y	derived	IS-BASE	0	1	1	0	lx.s
350	footcandle.s	footcandle second	JST/L2	N	derived	lx.s	0	1	0.09290304	0	footcandle.s
351	lm/W	lumen per watt	JST3/L2M	Y	derived	IS-BASE	0	1	1	0	lm/W
352	K	degree kelvin	K	Y	atom-base	IS-BASE	0	1	1	0	K
353	degC	degree Celsius	K	Y	atom-special	K	273.15	1	1	0	degC
354	degF	degree Fahrenheit	K	N	atom	K	2298.35	5	9	0	degF
355	degR	degree Rankine	K	N	atom	K	0	5	9	0	degR
356	m	metre	L	Y	atom-base	IS-BASE	0	1	1	0	m
357	angstrom	angstrom	L	Y	atom-allowed	m	0	1e-10	1	0	angstrom
358	chain	chain	L	N	atom	m	0	20.1168	1	0	chain
359	chain[BnA]	British chain [Benoit 1895 A]	L	N	atom	m	0	20.116783	1	0	chain[BnA]
360	chain[BnB]	British chain [Benoit 1895 B]	L	N	atom	m	0	792	39.370113	0	chain[BnB]
361	chain[Cla]	Clarke chain	L	N	atom	m	0	20.11662	1	0	chain[Cla]
362	chain[Ind37]	Indian Chain [1937]	L	N	atom	m	0	20.116695	1	0	chain[Ind37]
363	chain[Se]	British chain [Sears 1922]	L	N	atom	m	0	792	39.370148	0	chain[Se]
364	chain[SeT]	British chain [Sears 1922 truncated]	L	N	atom	m	0	20.116756	1	0	chain[SeT]
365	chain[US]	US survey chain	L	N	atom	m	0	792	39.37	0	chain[US]
366	fathom	international fathom	L	N	atom	m	0	1.8288	1	0	fathom
367	ft	foot	L	N	atom	m	0	0.3048	1	0	ft
368	ft[BnA]	British foot [Benoit 1895 A]	L	N	atom	m	0	0.9143992	3	0	ft[BnA]
369	ft[BnB]	British foot [Benoit 1895 B]	L	N	atom	m	0	12	39.370113	0	ft[BnB]
370	ft[Br36]	British foot [1936]	L	N	atom	m	0	0.30480075	1	0	ft[Br36]
371	ft[Br65]	British foot [1865]	L	N	atom	m	0	0.9144025	3	0	ft[Br65]
372	ft[Cla]	Clarke foot	L	N	atom	m	0	0.30479726	1	0	ft[Cla]
373	ft[GC]	Gold Coast foot	L	N	atom	m	0	6.3783e+06	2.09262e+07	0	ft[GC]
374	ft[Ind]	indian foot	L	N	atom	m	0	12	39.370144	0	ft[Ind]
375	ft[Ind37]	indian foot [1937]	L	N	atom	m	0	0.30479842	1	0	ft[Ind37]
376	ft[Ind62]	indian foot ]1962]	L	N	atom	m	0	0.3047996	1	0	ft[Ind62]
377	ft[Ind75]	indian foot [1975]	L	N	atom	m	0	0.3047995	1	0	ft[Ind75]
378	ft[Se]	British foot [Sears 1922]	L	N	atom	m	0	12	39.370148	0	ft[Se]
379	ft[SeT]	British foot [Sears 1922 truncated]	L	N	atom	m	0	0.914398	3	0	ft[SeT]
380	ft[US]	US survey foot	L	N	atom	m	0	1200	3937	0	ft[US]
381	fur[US]	furlong US survey	L	N	atom	m	0	792000	3937	0	fur[US]
382	in	inch	L	N	atom	m	0	0.0254	1	0	in
383	in[US]	US survey inch	L	N	atom	m	0	100	3937	0	in[US]
384	link	link	L	N	atom	m	0	20.1168	100	0	link
385	link[BnA]	British link [Benoit 1895 A]	L	N	atom	m	0	0.20116782	1	0	link[BnA]
386	link[BnB]	British link [Benoit 1895 B]	L	N	atom	m	0	7.92	39.370113	0	link[BnB]
387	link[Cla]	Clarke link	L	N	atom	m	0	0.2011662	1	0	link[Cla]
388	link[Se]	British link [Sears 1922]	L	N	atom	m	0	7.92	39.370148	0	link[Se]
389	link[SeT]	British link [Sears 1922 truncated]	L	N	atom	m	0	0.20116755	1	0	link[SeT]
390	link[US]	US survey link	L	N	atom	m	0	7.92	39.37	0	link[US]
391	m[Ger]	German legal metre	L	N	atom	m	0	1.0000136	1	0	m[Ger]
392	1609.344/	mile	L	N	atom	m	0	1609.344	1	0	1609.344/
393	mi[naut]	international nautical mile	L	Y	atom-allowed	m	0	1852	1	0	mi[naut]
394	mi[nautUK]	United Kingdom nautical mile	L	N	atom	m	0	1853	1	0	mi[nautUK]
395	mi[US]	US survey mile	L	N	atom	m	0	6.34e+06	3937	0	mi[US]
396	mil	mil	L	N	atom	m	0	2.54e-05	1	0	mil
397	rod[US]	rod US Survey	L	N	atom	m	0	19800	3937	0	rod[US]
398	yd	yard	L	N	atom	m	0	0.9144	1	0	yd
399	yd[BnA]	British yard [Benoit 1895 A]	L	N	atom	m	0	0.9143992	1	0	yd[BnA]
400	yd[BnB]	British yard [Benoit 1895 B]	L	N	atom	m	0	36	39.370113	0	yd[BnB]
401	yd[Cla]	Clarke yard	L	N	atom	m	0	0.9143918	1	0	yd[Cla]
402	yd[Ind]	Indian yard	L	N	atom	m	0	36	39.370144	0	yd[Ind]
403	yd[Ind37]	Indian yard [1937]	L	N	atom	m	0	0.9143952	1	0	yd[Ind37]
404	yd[Ind62]	Indian yard [1962]	L	N	atom	m	0	0.9143988	1	0	yd[Ind62]
405	yd[Ind75]	Indian yard [1975]	L	N	atom	m	0	0.9143985	1	0	yd[Ind75]
406	yd[Se]	British yard [Sears 1922]	L	N	atom	m	0	36	39.370148	0	yd[Se]
407	yd[SeT]	British yard [Sears 1922 truncated]	L	N	atom	m	0	0.914398	1	0	yd[SeT]
408	yd[US]	US survey yard	L	N	atom	m	0	3600	3937	0	yd[US]
409	m3/m2	cubic metre per square metre	L	Y	derived	IS-BASE	0	1	1	0	m3/m2
410	0.1 ft	tenth of foot	L	N	derived	m	0	0.03048	1	0	0.1 ft
411	0.1 ft[US]	tenth of US survey foot	L	N	derived	m	0	1200	39370	0	0.1 ft[US]
412	0.1 in	tenth of inch	L	N	derived	m	0	0.00254	1	0	0.1 in
413	0.1 yd	tenth of yard	L	N	derived	m	0	0.09144	1	0	0.1 yd
414	1/16 in	sixteenth of inch	L	N	derived	m	0	0.0254	16	0	1/16 in
415	1/2 ft	half of Foot	L	N	derived	m	0	0.3048	2	0	1/2 ft
416	1/32 in	thirty-second of inch	L	N	derived	m	0	0.0254	32	0	1/32 in
417	1/64 in	sixty-fourth of inch	L	N	derived	m	0	0.0254	64	0	1/64 in
418	10 ft	ten foot	L	N	derived	m	0	3.048	1	0	10 ft
419	10 in	ten inch	L	N	derived	m	0	0.254	1	0	10 in
420	10 km	10 kilometre	L	N	derived	m	0	10000	1	0	10 km
421	100 ft	hundred foot	L	N	derived	m	0	30.48	1	0	100 ft
422	100 km	100 kilometre	L	N	derived	m	0	100000	1	0	100 km
423	1000 ft	thousand foot	L	N	derived	m	0	304.8	1	0	1000 ft
424	30 ft	thirty foot	L	N	derived	m	0	9.144	1	0	30 ft
425	30 m	thirty metres	L	N	derived	m	0	30	1	0	30 m
426	1E6 bbl/acre	million barrel per acre	L	N	derived	m3/m2	0	2.46e+12	6.27e+10	0	1E6 bbl/acre
427	bbl/acre	barrel per acre	L	N	derived	m3/m2	0	2.46e+06	6.27e+10	0	bbl/acre
428	ft3/ft2	cubic foot per square foot	L	N	derived	m3/m2	0	0.3048	1	0	ft3/ft2
429	cm	centimetre	L	Y	prefixed	m	0	0.01	1	0	cm
430	dam	dekametre	L	Y	prefixed	m	0	10	1	0	dam
431	dm	decimetre	L	Y	prefixed	m	0	0.1	1	0	dm
432	Em	exametre	L	Y	prefixed	m	0	1e+18	1	0	Em
433	fm	femtometre	L	Y	prefixed	m	0	1e-15	1	0	fm
434	Gm	gigametre	L	Y	prefixed	m	0	1e+09	1	0	Gm
435	hm	hectometre	L	Y	prefixed	m	0	100	1	0	hm
436	km	kilometre	L	Y	prefixed	m	0	1000	1	0	km
437	Mm	megametre	L	Y	prefixed	m	0	1e+06	1	0	Mm
438	mm	millimetre	L	Y	prefixed	m	0	0.001	1	0	mm
439	nm	nanometre	L	Y	prefixed	m	0	1e-09	1	0	nm
440	pm	picometre	L	Y	prefixed	m	0	1e-12	1	0	pm
441	Tm	terametre	L	Y	prefixed	m	0	1e+12	1	0	Tm
442	um	micrometre	L	Y	prefixed	m	0	1e-06	1	0	um
443	m/deltaK	metre per delta kelvin	L/D	Y	derived	IS-BASE	0	1	1	0	m/deltaK
444	ft/deltaF	foot per delta Fahrenheit	L/D	N	derived	m/deltaK	0	2.7432	5	0	ft/deltaF
445	m/kg	metre per kilogram	L/M	Y	derived	IS-BASE	0	1	1	0	m/kg
446	ft/lbm	foot per pound-mass	L/M	N	derived	m/kg	0	0.3048	0.45359236	0	ft/lbm
447	knot	knot	L/T	Y	atom-allowed	m/s	0	1852	3600	0	knot
448	m/s	metre per second	L/T	Y	derived	IS-BASE	0	1	1	0	m/s
449	m3/(s.m2)	cubic metre per second square metre	L/T	Y	derived	IS-BASE	0	1	1	0	m3/(s.m2)
450	1000 ft/h	thousand foot per hour	L/T	N	derived	m/s	0	304.8	3600	0	1000 ft/h
451	1000 ft/s	thousand foot per second	L/T	N	derived	m/s	0	304.8	1	0	1000 ft/s
452	cm/a	centimetre per julian-year	L/T	N	derived	m/s	0	0.01	3.16e+07	0	cm/a
453	cm/s	centimetre per second	L/T	Y	derived	m/s	0	0.01	1	0	cm/s
454	dm/s	decimetre per second	L/T	Y	derived	m/s	0	0.1	1	0	dm/s
455	ft/d	foot per day	L/T	N	derived	m/s	0	0.3048	86400	0	ft/d
456	ft/h	foot per hour	L/T	N	derived	m/s	0	0.3048	3600	0	ft/h
457	ft/min	foot per minute	L/T	N	derived	m/s	0	0.3048	60	0	ft/min
458	ft/ms	foot per millisecond	L/T	N	derived	m/s	0	304.8	1	0	ft/ms
459	ft/s	foot per second	L/T	N	derived	m/s	0	0.3048	1	0	ft/s
460	ft/us	foot per microsecond	L/T	N	derived	m/s	0	304800	1	0	ft/us
461	in/a	inch per julian-year	L/T	N	derived	m/s	0	0.0254	3.16e+07	0	in/a
462	in/min	inch per minute	L/T	N	derived	m/s	0	0.0254	60	0	in/min
463	in/s	inch per second	L/T	N	derived	m/s	0	0.0254	1	0	in/s
464	km/h	kilometre per hour	L/T	Y	derived	m/s	0	1	3.6	0	km/h
465	km/s	kilometre per second	L/T	Y	derived	m/s	0	1000	1	0	km/s
466	m/d	metre per day	L/T	Y	derived	m/s	0	1	86400	0	m/d
467	m/h	metre per hour	L/T	Y	derived	m/s	0	1	3600	0	m/h
468	m/min	metre per minute	L/T	Y	derived	m/s	0	1	60	0	m/min
469	m/ms	metre per millisecond	L/T	Y	derived	m/s	0	1000	1	0	m/ms
470	mi/h	mile per hour	L/T	N	derived	m/s	0	1609.344	3600	0	mi/h
471	mil/a	mil per julian-year	L/T	N	derived	m/s	0	2.54e-05	3.16e+07	0	mil/a
472	mm/a	millimetre per julian-year	L/T	N	derived	m/s	0	0.001	3.16e+07	0	mm/a
473	mm/s	millimetre per second	L/T	Y	derived	m/s	0	0.001	1	0	mm/s
474	nm/s	nanometre per second	L/T	Y	derived	m/s	0	1e-09	1	0	nm/s
475	um/s	micrometre per second	L/T	Y	derived	m/s	0	1e-06	1	0	um/s
476	ft3/(min.ft2)	cubic foot per minute square foot	L/T	N	derived	m3/(s.m2)	0	0.3048	60	0	ft3/(min.ft2)
477	ft3/(s.ft2)	cubic foot per second square foot	L/T	N	derived	m3/(s.m2)	0	0.3048	1	0	ft3/(s.ft2)
478	gal[UK]/(h.ft2)	UK gallon per hour square foot	L/T	N	derived	m3/(s.m2)	0	0.00454609	334.45096	0	gal[UK]/(h.ft2)
479	gal[UK]/(h.in2)	UK gallon per hour square inch	L/T	N	derived	m3/(s.m2)	0	0.00454609	2.322576	0	gal[UK]/(h.in2)
480	gal[UK]/(min.ft2)	UK gallon per minute square foot	L/T	N	derived	m3/(s.m2)	0	0.00454609	5.5741825	0	gal[UK]/(min.ft2)
481	gal[US]/(h.ft2)	US gallon per hour square foot	L/T	N	derived	m3/(s.m2)	0	0.003785412	334.45096	0	gal[US]/(h.ft2)
482	gal[US]/(h.in2)	US gallon per hour square inch	L/T	N	derived	m3/(s.m2)	0	0.003785412	2.322576	0	gal[US]/(h.in2)
483	gal[US]/(min.ft2)	US gallon per minute square foot	L/T	N	derived	m3/(s.m2)	0	0.003785412	5.5741825	0	gal[US]/(min.ft2)
484	Gal	galileo	L/T2	N	atom	m/s2	0	0.01	1	0	Gal
485	gn	gravity	L/T2	N	atom	m/s2	0	9.80665	1	0	gn
486	m/s2	metre per second squared	L/T2	Y	derived	IS-BASE	0	1	1	0	m/s2
487	cm/s2	centimetre per square second	L/T2	Y	derived	m/s2	0	0.01	1	0	cm/s2
488	ft/s2	foot per second squared	L/T2	N	derived	m/s2	0	0.3048	1	0	ft/s2
489	in/s2	inch per second squared	L/T2	N	derived	m/s2	0	0.0254	1	0	in/s2
490	mGal	milligalileo	L/T2	N	prefixed	m/s2	0	1e-05	1	0	mGal
491	mgn	thousandth of gravity	L/T2	N	prefixed	m/s2	0	0.00981	1	0	mgn
492	TD[API]	teradarcy-API	L2	Y	atom-allowed	IS-BASE	0	1	1	0	TD[API]
493	acre	acre	L2	N	atom	m2	0	6.27e+10	1.55e+07	0	acre
494	b	barn	L2	Y	atom-allowed	m2	0	1e-28	1	0	b
495	ha	hectare	L2	Y	atom-allowed	m2	0	10000	1	0	ha
496	section	section	L2	N	atom	m2	0	4.01e+13	1.55e+07	0	section
497	D	darcy	L2	N	atom	TD[API]	0	1e-12	1.01325	0	D
498	D[API]	darcy-API	L2	Y	atom-allowed	TD[API]	0	1e-12	1	0	D[API]
499	m3/m	cubic metre per metre	L2	Y	derived	IS-BASE	0	1	1	0	m3/m
500	cm2	square centimetre	L2	Y	derived	m2	0	0.0001	1	0	cm2
501	km2	square kilometre	L2	Y	derived	m2	0	1e+06	1	0	km2
502	mm2	square millimetre	L2	Y	derived	m2	0	1e-06	1	0	mm2
503	um2	square micrometre	L2	Y	derived	m2	0	1e-12	1	0	um2
504	0.01 dm3/km	cubic decimetre per hundred kilometre	L2	N	derived	m3/m	0	1e-08	1	0	0.01 dm3/km
505	0.01 L/km	litre per hundred kilometre	L2	N	derived	m3/m	0	1e-08	1	0	0.01 L/km
506	bbl/ft	barrel per foot	L2	N	derived	m3/m	0	0.1589873	0.3048	0	bbl/ft
507	bbl/in	barrel per inch	L2	N	derived	m3/m	0	0.1589873	0.0254	0	bbl/in
508	bbl/mi	barrel per mile	L2	N	derived	m3/m	0	0.1589873	1609.344	0	bbl/mi
509	dm3/m	cubic decimetre per metre	L2	Y	derived	m3/m	0	0.001	1	0	dm3/m
510	ft3/ft	cubic foot per foot	L2	N	derived	m3/m	0	0.09290304	1	0	ft3/ft
511	gal[UK]/mi	UK gallon per mile	L2	N	derived	m3/m	0	0.00454609	1609.344	0	gal[UK]/mi
512	gal[US]/ft	US gallon per foot	L2	N	derived	m3/m	0	0.003785412	0.3048	0	gal[US]/ft
513	gal[US]/mi	US gallon per mile	L2	N	derived	m3/m	0	0.003785412	1609.344	0	gal[US]/mi
514	in3/ft	cubic inch per foot	L2	N	derived	m3/m	0	1.64e-05	0.3048	0	in3/ft
515	L/m	litre per metre	L2	Y	derived	m3/m	0	0.001	1	0	L/m
516	m3/km	cubic metre per kilometre	L2	Y	derived	m3/m	0	0.001	1	0	m3/km
517	m2	square metre	L2	Y	derived	IS-BASE	0	1	1	0	m2
518	ft2	square foot	L2	N	derived	m2	0	0.09290304	1	0	ft2
519	in2	square inch	L2	N	derived	m2	0	0.000645	1	0	in2
520	mi[US]2	square US survey mile	L2	N	derived	m2	0	4.01e+13	1.55e+07	0	mi[US]2
521	mi2	square mile	L2	N	derived	m2	0	2.589988e+06	1	0	mi2
522	yd2	square yard	L2	N	derived	m2	0	0.83612734	1	0	yd2
523	mD	millidarcy	L2	N	prefixed	TD[API]	0	1e-15	1.01325	0	mD
524	J/(kg.deltaK)	joule per kilogram delta kelvin	L2/DT2	Y	derived	IS-BASE	0	1	1	0	J/(kg.deltaK)
525	Btu[IT]/(lbm.deltaF)	BTU per pound-mass delta Fahrenheit	L2/DT2	N	derived	J/(kg.deltaK)	0	4186.8	1	0	Btu[IT]/(lbm.deltaF)
526	Btu[IT]/(lbm.deltaR)	BTU per pound-mass delta Rankine	L2/DT2	N	derived	J/(kg.deltaK)	0	4186.8	1	0	Btu[IT]/(lbm.deltaR)
527	cal[th]/(g.deltaK)	calorie per gram delta kelvin	L2/DT2	N	derived	J/(kg.deltaK)	0	4184	1	0	cal[th]/(g.deltaK)
528	J/(g.deltaK)	joule per gram delta kelvin	L2/DT2	Y	derived	J/(kg.deltaK)	0	1000	1	0	J/(g.deltaK)
529	kcal[th]/(kg.deltaC)	thousand calorie per kilogram delta Celsius	L2/DT2	N	derived	J/(kg.deltaK)	0	4184	1	0	kcal[th]/(kg.deltaC)
530	kJ/(kg.deltaK)	kilojoule per kilogram delta kelvin	L2/DT2	Y	derived	J/(kg.deltaK)	0	1000	1	0	kJ/(kg.deltaK)
531	kW.h/(kg.deltaC)	kilowatt hour per kilogram delta Celsius	L2/DT2	Y	derived	J/(kg.deltaK)	0	3.6e+06	1	0	kW.h/(kg.deltaC)
532	m2/kg	square metre per kilogram	L2/M	Y	derived	IS-BASE	0	1	1	0	m2/kg
533	cm2/g	square centimetre per gram	L2/M	Y	derived	m2/kg	0	0.1	1	0	cm2/g
534	ft2/lbm	square foot per pound-mass	L2/M	N	derived	m2/kg	0	0.09290304	0.45359236	0	ft2/lbm
535	m2/g	square metre per gram	L2/M	Y	derived	m2/kg	0	1000	1	0	m2/g
536	m2/mol	square metre per gram-mole	L2/N	Y	derived	IS-BASE	0	1	1	0	m2/mol
537	St	stokes	L2/T	N	atom	m2/s	0	0.0001	1	0	St
538	m2/s	square metre per second	L2/T	Y	derived	IS-BASE	0	1	1	0	m2/s
539	m3/(s.m)	cubic metre per second metre	L2/T	Y	derived	IS-BASE	0	1	1	0	m3/(s.m)
614	rem/h	rem per hour	L2/T3	Y	derived	Sv/s	0	0.01	3600	0	rem/h
540	mol.m2/(mol.s)	mole square metre per mole second	L2/T	Y	derived	IS-BASE	0	1	1	0	mol.m2/(mol.s)
541	Pa.s.m3/kg	pascal second square metre per kilogram	L2/T	Y	derived	IS-BASE	0	1	1	0	Pa.s.m3/kg
542	W.m2.deltaK/(J.deltaK)	watt square metre delta kelvin per joule delta kelvin	L2/T	Y	derived	IS-BASE	0	1	1	0	W.m2.deltaK/(J.deltaK)
543	cm2/s	square centimetre per second	L2/T	Y	derived	m2/s	0	0.0001	1	0	cm2/s
544	ft2/h	square foot per hour	L2/T	N	derived	m2/s	0	0.09290304	3600	0	ft2/h
545	ft2/s	square foot per second	L2/T	N	derived	m2/s	0	0.09290304	1	0	ft2/s
546	in2/s	square inch per second	L2/T	N	derived	m2/s	0	0.000645	1	0	in2/s
547	m2/d	square metre per day	L2/T	Y	derived	m2/s	0	1	86400	0	m2/d
548	m2/h	square metre per hour	L2/T	Y	derived	m2/s	0	1	3600	0	m2/h
549	mm2/s	square millimetre per second	L2/T	Y	derived	m2/s	0	1e-06	1	0	mm2/s
550	1000 ft3/(d.ft)	(thousand cubic foot per day) per foot	L2/T	N	derived	m3/(s.m)	0	28.316847	26300	0	1000 ft3/(d.ft)
551	1000 m3/(d.m)	(thousand cubic metre per day) per metre	L2/T	N	derived	m3/(s.m)	0	1000	86400	0	1000 m3/(d.m),MCMD
552	1000 m3/(h.m)	(thousand cubic metre per hour) per metre	L2/T	N	derived	m3/(s.m)	0	1000	3600	0	1000 m3/(h.m)
553	bbl/(d.ft)	barrel per day foot	L2/T	N	derived	m3/(s.m)	0	0.1589873	26300	0	bbl/(d.ft)
554	ft3/(d.ft)	(cubic foot per day) per foot	L2/T	N	derived	m3/(s.m)	0	0.09290304	86400	0	ft3/(d.ft)
555	gal[UK]/(h.ft)	UK gallon per hour foot	L2/T	N	derived	m3/(s.m)	0	0.00454609	1100	0	gal[UK]/(h.ft)
556	gal[UK]/(h.in)	UK gallon per hour inch	L2/T	N	derived	m3/(s.m)	0	0.00454609	91.44	0	gal[UK]/(h.in)
557	gal[UK]/(min.ft)	UK gallon per minute foot	L2/T	N	derived	m3/(s.m)	0	0.00454609	18.288	0	gal[UK]/(min.ft)
558	gal[US]/(h.ft)	US gallon per hour foot	L2/T	N	derived	m3/(s.m)	0	0.003785412	1100	0	gal[US]/(h.ft)
559	gal[US]/(h.in)	US gallon per hour inch	L2/T	N	derived	m3/(s.m)	0	0.003785412	91.44	0	gal[US]/(h.in)
560	gal[US]/(min.ft)	US gallon per minute foot	L2/T	N	derived	m3/(s.m)	0	0.003785412	18.288	0	gal[US]/(min.ft)
561	m3/(d.m)	(cubic metre per day) per metre	L2/T	Y	derived	m3/(s.m)	0	1	86400	0	m3/(d.m)
562	m3/(h.m)	(cubic metre per hour) per metre	L2/T	Y	derived	m3/(s.m)	0	1	3600	0	m3/(h.m)
563	m3/(s.ft)	(cubic metre per second) per foot	L2/T	N	derived	m3/(s.m)	0	1	0.3048	0	m3/(s.ft)
564	cSt	centistokes	L2/T	N	prefixed	m2/s	0	1e-06	1	0	cSt
565	rd	rad	L2/T2	N	atom	Gy	0	0.01	1	0	rd
566	Gy	gray	L2/T2	Y	atom-special	IS-BASE	0	1	1	0	Gy
567	Sv	sievert	L2/T2	Y	atom-special	IS-BASE	0	1	1	0	Sv
568	rem	rem	L2/T2	Y	atom-allowed	Sv	0	0.01	1	0	rem
569	J/kg	joule per kilogram	L2/T2	Y	derived	IS-BASE	0	1	1	0	J/kg
570	Btu[IT]/lbm	BTU per pound-mass	L2/T2	N	derived	J/kg	0	2326	1	0	Btu[IT]/lbm
571	cal[th]/g	calorie per gram	L2/T2	N	derived	J/kg	0	4184	1	0	cal[th]/g
572	cal[th]/kg	calorie per kilogram	L2/T2	N	derived	J/kg	0	4.184	1	0	cal[th]/kg
573	cal[th]/lbm	calorie per pound-mass	L2/T2	N	derived	J/kg	0	4.184	0.45359236	0	cal[th]/lbm
574	erg/g	erg per gram	L2/T2	N	derived	J/kg	0	0.0001	1	0	erg/g
575	erg/kg	erg per kilogram	L2/T2	N	derived	J/kg	0	1e-07	1	0	erg/kg
576	hp.h/lbm	horsepower hour per pound-mass	L2/T2	N	derived	J/kg	0	2.68e+06	0.45359236	0	hp.h/lbm
577	J/g	joule per gram	L2/T2	Y	derived	J/kg	0	1000	1	0	J/g
578	kcal[th]/g	thousand calorie per gram	L2/T2	N	derived	J/kg	0	4.18e+06	1	0	kcal[th]/g
579	kcal[th]/kg	thousand calorie per kilogram	L2/T2	N	derived	J/kg	0	4184	1	0	kcal[th]/kg
580	kJ/kg	kilojoule per kilogram	L2/T2	Y	derived	J/kg	0	1000	1	0	kJ/kg
581	kW.h/kg	kilowatt hour per kilogram	L2/T2	Y	derived	J/kg	0	3.6e+06	1	0	kW.h/kg
582	lbf.ft/lbm	foot pound-force per pound-mass	L2/T2	N	derived	J/kg	0	1.3558179	0.45359236	0	lbf.ft/lbm
583	MJ/kg	megajoule per kilogram	L2/T2	Y	derived	J/kg	0	1e+06	1	0	MJ/kg
584	MW.h/kg	megawatt hour per kilogram	L2/T2	Y	derived	J/kg	0	3.6e+09	1	0	MW.h/kg
585	cGy	centigray	L2/T2	Y	prefixed	Gy	0	0.01	1	0	cGy
586	crd	hundredth of rad	L2/T2	N	prefixed	Gy	0	0.0001	1	0	crd
587	dGy	decigray	L2/T2	Y	prefixed	Gy	0	0.1	1	0	dGy
588	drd	tenth of rad	L2/T2	N	prefixed	Gy	0	0.001	1	0	drd
589	EGy	exagray	L2/T2	Y	prefixed	Gy	0	1e+18	1	0	EGy
590	Erd	million million million rad	L2/T2	N	prefixed	Gy	0	1e+16	1	0	Erd
591	fGy	femtogray	L2/T2	Y	prefixed	Gy	0	1e-15	1	0	fGy
592	frd	femtorad	L2/T2	N	prefixed	Gy	0	1e-17	1	0	frd
593	GGy	gigagray	L2/T2	Y	prefixed	Gy	0	1e+09	1	0	GGy
594	Grd	thousand million rad	L2/T2	N	prefixed	Gy	0	1e+07	1	0	Grd
595	kGy	kilogray	L2/T2	Y	prefixed	Gy	0	1000	1	0	kGy
596	krd	thousand rad	L2/T2	N	prefixed	Gy	0	10	1	0	krd
597	mGy	milligray	L2/T2	Y	prefixed	Gy	0	0.001	1	0	mGy
598	MGy	megagray	L2/T2	Y	prefixed	Gy	0	1e+06	1	0	MGy
599	mrd	thousandth of rad	L2/T2	N	prefixed	Gy	0	1e-05	1	0	mrd
600	Mrd	million rad	L2/T2	N	prefixed	Gy	0	10000	1	0	Mrd
601	nGy	nanogray	L2/T2	Y	prefixed	Gy	0	1e-09	1	0	nGy
602	nrd	nanorad	L2/T2	N	prefixed	Gy	0	1e-11	1	0	nrd
603	pGy	picogray	L2/T2	Y	prefixed	Gy	0	1e-12	1	0	pGy
604	prd	picorad	L2/T2	N	prefixed	Gy	0	1e-14	1	0	prd
605	TGy	teragray	L2/T2	Y	prefixed	Gy	0	1e+12	1	0	TGy
606	Trd	million million rad	L2/T2	N	prefixed	Gy	0	1e+10	1	0	Trd
607	uGy	microgray	L2/T2	Y	prefixed	Gy	0	1e-06	1	0	uGy
608	urd	millionth of rad	L2/T2	N	prefixed	Gy	0	1e-08	1	0	urd
609	mrem	thousandth of rem	L2/T2	N	prefixed	Sv	0	1e-05	1	0	mrem
610	mSv	millisievert	L2/T2	Y	prefixed	Sv	0	0.001	1	0	mSv
611	Sv/s	sievert per second	L2/T3	Y	derived	IS-BASE	0	1	1	0	Sv/s
612	mrem/h	thousandth of irem per hour	L2/T3	N	derived	Sv/s	0	1e-05	3600	0	mrem/h
613	mSv/h	millisievert per hour	L2/T3	Y	derived	Sv/s	0	0.001	3600	0	mSv/h
615	Sv/h	sievert per hour	L2/T3	Y	derived	Sv/s	0	1	3600	0	Sv/h
616	kg.m2	kilogram square metre	L2M	Y	derived	IS-BASE	0	1	1	0	kg.m2
617	lbm.ft2	pound-mass square foot	L2M	N	derived	kg.m2	0	0.0421	1	0	lbm.ft2
618	J/(mol.deltaK)	joule per gram-mole delta kelvin	L2M/DNT2	Y	derived	IS-BASE	0	1	1	0	J/(mol.deltaK)
619	Btu[IT]/(lbmol.deltaF)	BTU per pound-mass-mole delta Fahrenheit	L2M/DNT2	N	derived	J/(mol.deltaK)	0	4.1868	1	0	Btu[IT]/(lbmol.deltaF)
620	cal[th]/(mol.deltaC)	calorie per gram-mole delta Celsius	L2M/DNT2	N	derived	J/(mol.deltaK)	0	4.184	1	0	cal[th]/(mol.deltaC)
621	kJ/(kmol.deltaK)	kilojoule per kilogram-mole delta kelvin	L2M/DNT2	Y	derived	J/(mol.deltaK)	0	1	1	0	kJ/(kmol.deltaK)
622	J/deltaK	joule per delta kelvin	L2M/DT2	Y	derived	IS-BASE	0	1	1	0	J/deltaK
623	W/deltaK	watt per delta kelvin	L2M/DT3	Y	derived	IS-BASE	0	1	1	0	W/deltaK
624	H	henry	L2M/I2T2	Y	atom-special	IS-BASE	0	1	1	0	H
625	cH	centihenry	L2M/I2T2	Y	prefixed	H	0	0.01	1	0	cH
626	dH	decihenry	L2M/I2T2	Y	prefixed	H	0	0.1	1	0	dH
627	EH	exahenry	L2M/I2T2	Y	prefixed	H	0	1e+18	1	0	EH
628	fH	femtohenry	L2M/I2T2	Y	prefixed	H	0	1e-15	1	0	fH
629	GH	gigahenry	L2M/I2T2	Y	prefixed	H	0	1e+09	1	0	GH
630	kH	kilohenry	L2M/I2T2	Y	prefixed	H	0	1000	1	0	kH
631	mH	millihenry	L2M/I2T2	Y	prefixed	H	0	0.001	1	0	mH
632	MH	megahenry	L2M/I2T2	Y	prefixed	H	0	1e+06	1	0	MH
633	nH	nanohenry	L2M/I2T2	Y	prefixed	H	0	1e-09	1	0	nH
634	TH	terahenry	L2M/I2T2	Y	prefixed	H	0	1e+12	1	0	TH
635	uH	microhenry	L2M/I2T2	Y	prefixed	H	0	1e-06	1	0	uH
636	ohm	ohm	L2M/I2T3	Y	atom-special	IS-BASE	0	1	1	0	ohm
637	cohm	centiohm	L2M/I2T3	Y	prefixed	ohm	0	0.01	1	0	cohm
638	dohm	deciohm	L2M/I2T3	Y	prefixed	ohm	0	0.1	1	0	dohm
639	Eohm	exaohm	L2M/I2T3	Y	prefixed	ohm	0	1e+18	1	0	Eohm
640	fohm	femtoohm	L2M/I2T3	Y	prefixed	ohm	0	1e-15	1	0	fohm
641	Gohm	gigaohm	L2M/I2T3	Y	prefixed	ohm	0	1e+09	1	0	Gohm
642	kohm	kilohm	L2M/I2T3	Y	prefixed	ohm	0	1000	1	0	kohm
643	mohm	milliohm	L2M/I2T3	Y	prefixed	ohm	0	0.001	1	0	mohm
644	Mohm	megohm	L2M/I2T3	Y	prefixed	ohm	0	1e+06	1	0	Mohm
645	nohm	nanoohm	L2M/I2T3	Y	prefixed	ohm	0	1e-09	1	0	nohm
646	pohm	picoohm	L2M/I2T3	Y	prefixed	ohm	0	1e-12	1	0	pohm
647	Tohm	teraohm	L2M/I2T3	Y	prefixed	ohm	0	1e+12	1	0	Tohm
648	uohm	microohm	L2M/I2T3	Y	prefixed	ohm	0	1e-06	1	0	uohm
649	Wb	weber	L2M/IT2	Y	atom-special	IS-BASE	0	1	1	0	Wb
650	cWb	centiweber	L2M/IT2	Y	prefixed	Wb	0	0.01	1	0	cWb
651	dWb	deciweber	L2M/IT2	Y	prefixed	Wb	0	0.1	1	0	dWb
652	EWb	exaweber	L2M/IT2	Y	prefixed	Wb	0	1e+18	1	0	EWb
653	fWb	femtoweber	L2M/IT2	Y	prefixed	Wb	0	1e-15	1	0	fWb
654	GWb	gigaweber	L2M/IT2	Y	prefixed	Wb	0	1e+09	1	0	GWb
655	kWb	kiloweber	L2M/IT2	Y	prefixed	Wb	0	1000	1	0	kWb
656	mWb	milliweber	L2M/IT2	Y	prefixed	Wb	0	0.001	1	0	mWb
657	MWb	megaweber	L2M/IT2	Y	prefixed	Wb	0	1e+06	1	0	MWb
658	nWb	nanoweber	L2M/IT2	Y	prefixed	Wb	0	1e-09	1	0	nWb
659	pWb	picoweber	L2M/IT2	Y	prefixed	Wb	0	1e-12	1	0	pWb
660	TWb	teraweber	L2M/IT2	Y	prefixed	Wb	0	1e+12	1	0	TWb
661	uWb	microweber	L2M/IT2	Y	prefixed	Wb	0	1e-06	1	0	uWb
662	V	volt	L2M/IT3	Y	atom-special	IS-BASE	0	1	1	0	V
663	cV	centivolt	L2M/IT3	Y	prefixed	V	0	0.01	1	0	cV
664	dV	decivolt	L2M/IT3	Y	prefixed	V	0	0.1	1	0	dV
665	fV	femtovolt	L2M/IT3	Y	prefixed	V	0	1e-15	1	0	fV
666	GV	gigavolt	L2M/IT3	Y	prefixed	V	0	1e+09	1	0	GV
667	kV	kilovolt	L2M/IT3	Y	prefixed	V	0	1000	1	0	kV
668	mV	millivolt	L2M/IT3	Y	prefixed	V	0	0.001	1	0	mV
669	MV	megavolt	L2M/IT3	Y	prefixed	V	0	1e+06	1	0	MV
670	nV	nanovolt	L2M/IT3	Y	prefixed	V	0	1e-09	1	0	nV
671	pV	picovolt	L2M/IT3	Y	prefixed	V	0	1e-12	1	0	pV
672	TV	teravolt	L2M/IT3	Y	prefixed	V	0	1e+12	1	0	TV
673	uV	microvolt	L2M/IT3	Y	prefixed	V	0	1e-06	1	0	uV
674	J/mol	joule per gram-mole	L2M/NT2	Y	derived	IS-BASE	0	1	1	0	J/mol
675	Btu[IT]/lbmol	BTU per pound-mass-mole	L2M/NT2	N	derived	J/mol	0	2.326	1	0	Btu[IT]/lbmol
676	kcal[th]/mol	thousand calorie per gram-mole	L2M/NT2	N	derived	J/mol	0	4184	1	0	kcal[th]/mol
677	kJ/kmol	kilojoule per kilogram-mole	L2M/NT2	Y	derived	J/mol	0	1	1	0	kJ/kmol
678	MJ/kmol	megajoule per kilogram-mole	L2M/NT2	Y	derived	J/mol	0	1000	1	0	MJ/kmol
679	W/sr	watt per steradian	L2M/ST3	Y	derived	IS-BASE	0	1	1	0	W/sr
680	J	joule	L2M/T2	Y	atom-special	IS-BASE	0	1	1	0	J
681	Btu[IT]	British thermal unit	L2M/T2	N	atom	J	0	1055.0559	1	0	Btu[IT]
682	Btu[th]	thermochemical British thermal unit	L2M/T2	N	atom	J	0	9490	9	0	Btu[th]
683	Btu[UK]	United Kingdom British thermal unit	L2M/T2	N	atom	J	0	1055.0559	1	0	Btu[UK]
684	cal[IT]	calorie [International Table]	L2M/T2	N	atom	J	0	4.1868	1	0	cal[IT]
685	cal[th]	calorie	L2M/T2	N	atom	J	0	4.184	1	0	cal[th]
686	erg	erg	L2M/T2	N	atom	J	0	1e-07	1	0	erg
687	eV	electronvolt	L2M/T2	Y	atom-allowed	J	0	1.6e-19	1	0	eV
688	quad	quad	L2M/T2	N	atom	J	0	1.06e+18	1	0	quad
689	therm[EC]	European Community therm	L2M/T2	N	atom	J	0	1.06e+08	1	0	therm[EC]
690	therm[UK]	United Kingdom therm	L2M/T2	N	atom	J	0	1.06e+08	1	0	therm[UK]
691	therm[US]	United States therm	L2M/T2	N	atom	J	0	1.05e+08	1	0	therm[US]
692	N.m	newton metre	L2M/T2	Y	derived	IS-BASE	0	1	1	0	N.m,NÂ·m
693	1E6 Btu[IT]	million BTU	L2M/T2	N	derived	J	0	1.06e+09	1	0	1E6 Btu[IT]
694	GW.h	gigawatt hour	L2M/T2	Y	derived	J	0	3.6e+12	1	0	GW.h
695	hp.h	horsepower hour	L2M/T2	N	derived	J	0	2.68e+06	1	0	hp.h
696	hp[metric].h	metric-horsepower hour	L2M/T2	N	derived	J	0	2.65e+06	1	0	hp[metric].h
697	kW.h	kilowatt hour	L2M/T2	Y	derived	J	0	3.6e+06	1	0	kW.h
698	MW.h	megawatt hour	L2M/T2	Y	derived	J	0	3.6e+09	1	0	MW.h
699	TW.h	terrawatt hour	L2M/T2	Y	derived	J	0	3.6e+15	1	0	TW.h
700	1000 lbf.ft	thousand foot pound-force	L2M/T2	N	derived	N.m	0	1355.818	1	0	1000 lbf.ft,kft.lbf
701	daN.m	dekanewton metre	L2M/T2	Y	derived	N.m	0	10	1	0	daN.m
702	dN.m	decinewton metre	L2M/T2	Y	derived	N.m	0	0.1	1	0	dN.m
703	kgf.m	thousand gram-force metre	L2M/T2	N	derived	N.m	0	9.80665	1	0	kgf.m
704	kN.m	kilonewton metre	L2M/T2	Y	derived	N.m	0	1000	1	0	kN.m
705	lbf.ft	foot pound-force	L2M/T2	N	derived	N.m	0	1.3558179	1	0	lbf.ft,ft.lbf
706	lbf.in	inch pound-force	L2M/T2	N	derived	N.m	0	0.11298483	1	0	lbf.in
707	lbm.ft2/s2	pound-mass square foot per second squared	L2M/T2	N	derived	N.m	0	0.04214011	1	0	lbm.ft2/s2
708	pdl.ft	foot poundal	L2M/T2	N	derived	N.m	0	0.04214011	1	0	pdl.ft
709	tonf[US].ft	US ton-force foot	L2M/T2	N	derived	N.m	0	2710	1	0	tonf[US].ft
710	tonf[US].mi	US ton-force mile	L2M/T2	N	derived	N.m	0	1.43e+07	1	0	tonf[US].mi
711	aJ	attojoule	L2M/T2	Y	prefixed	J	0	1e-18	1	0	aJ
712	ccal[th]	hundredth of calorie	L2M/T2	N	prefixed	J	0	0.04184	1	0	ccal[th]
713	ceV	centielectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-21	1	0	ceV
714	cJ	centijoule	L2M/T2	Y	prefixed	J	0	0.01	1	0	cJ
715	dcal[th]	tenth of calorie	L2M/T2	N	prefixed	J	0	0.4184	1	0	dcal[th]
716	deV	decielectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-20	1	0	deV
717	dJ	decijoule	L2M/T2	Y	prefixed	J	0	0.1	1	0	dJ
718	Ecal[th]	million million million calorie	L2M/T2	N	prefixed	J	0	4.18e+18	1	0	Ecal[th]
719	EeV	exaelectronvolt	L2M/T2	Y	prefixed	J	0	0.16	1	0	EeV
720	EJ	exajoule	L2M/T2	Y	prefixed	J	0	1e+18	1	0	EJ
721	fcal[th]	femtocalorie	L2M/T2	N	prefixed	J	0	4.18e-15	1	0	fcal[th]
722	feV	femtoelectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-34	1	0	feV
723	fJ	femtojoule	L2M/T2	Y	prefixed	J	0	1e-15	1	0	fJ
724	Gcal[th]	thousand million calorie	L2M/T2	N	prefixed	J	0	4.18e+09	1	0	Gcal[th]
725	GeV	gigaelectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-10	1	0	GeV
726	GJ	gigajoule	L2M/T2	Y	prefixed	J	0	1e+09	1	0	GJ
727	kcal[th]	thousand calorie	L2M/T2	N	prefixed	J	0	4184	1	0	kcal[th]
728	keV	kiloelectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-16	1	0	keV
729	kJ	kilojoule	L2M/T2	Y	prefixed	J	0	1000	1	0	kJ
730	mcal[th]	thousandth of calorie	L2M/T2	N	prefixed	J	0	0.004184	1	0	mcal[th]
731	Mcal[th]	million calorie	L2M/T2	N	prefixed	J	0	4.18e+06	1	0	Mcal[th]
732	MeV	megaelectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-13	1	0	MeV
733	meV	millielectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-22	1	0	meV
734	mJ	millijoule	L2M/T2	Y	prefixed	J	0	0.001	1	0	mJ
735	MJ	megajoule	L2M/T2	Y	prefixed	J	0	1e+06	1	0	MJ
736	ncal[th]	nanocalorie	L2M/T2	N	prefixed	J	0	4.18e-09	1	0	ncal[th]
737	neV	nanoelectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-28	1	0	neV
738	nJ	nanojoule	L2M/T2	Y	prefixed	J	0	1e-09	1	0	nJ
739	pcal[th]	picocalorie	L2M/T2	N	prefixed	J	0	4.18e-12	1	0	pcal[th]
740	peV	picoelectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-31	1	0	peV
741	pJ	picojoule	L2M/T2	Y	prefixed	J	0	1e-12	1	0	pJ
742	Tcal[th]	million million calorie	L2M/T2	N	prefixed	J	0	4.18e+12	1	0	Tcal[th]
743	TeV	teraelectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-07	1	0	TeV
744	TJ	terajoule	L2M/T2	Y	prefixed	J	0	1e+12	1	0	TJ
745	ucal[th]	millionth of calorie	L2M/T2	N	prefixed	J	0	4.18e-06	1	0	ucal[th]
746	ueV	microelectronvolt	L2M/T2	Y	prefixed	J	0	1.6e-25	1	0	ueV
747	uJ	microjoule	L2M/T2	Y	prefixed	J	0	1e-06	1	0	uJ
748	W	watt	L2M/T3	Y	atom-special	IS-BASE	0	1	1	0	W
749	hp	horsepower	L2M/T3	N	atom	W	0	745.6999	1	0	hp,Hp
750	hp[elec]	electric-horsepower	L2M/T3	N	atom	W	0	746	1	0	hp[elec]
751	hp[hyd]	hydraulic-horsepower	L2M/T3	N	atom	W	0	746.043	1	0	hp[hyd]
752	hp[metric]	metric-horsepower	L2M/T3	N	atom	W	0	735.4988	1	0	hp[metric]
753	tonRefrig	ton-refrigeration	L2M/T3	N	atom	W	0	1.27e+07	3600	0	tonRefrig
754	J/s	joule per second	L2M/T3	Y	derived	IS-BASE	0	1	1	0	J/s
755	1E6 Btu[IT]/h	million BTU per hour	L2M/T3	N	derived	J/s	0	1.06e+09	3600	0	1E6 Btu[IT]/h
756	Btu[IT]/h	BTU per hour	L2M/T3	N	derived	J/s	0	1055.0559	3600	0	Btu[IT]/h
757	Btu[IT]/min	BTU per minute	L2M/T3	N	derived	J/s	0	1055.0559	60	0	Btu[IT]/min
758	Btu[IT]/s	BTU per second	L2M/T3	N	derived	J/s	0	1055.0559	1	0	Btu[IT]/s
759	cal[th]/h	calorie per hour	L2M/T3	N	derived	J/s	0	4.184	3600	0	cal[th]/h
760	EJ/a	exajoule per julian-year	L2M/T3	N	derived	J/s	0	1e+18	3.16e+07	0	EJ/a
761	erg/a	erg per julian-year	L2M/T3	N	derived	J/s	0	1e-07	3.16e+07	0	erg/a
762	kcal[th]/h	thousand calorie per hour	L2M/T3	N	derived	J/s	0	4184	3600	0	kcal[th]/h
763	lbf.ft/min	foot pound-force per minute	L2M/T3	N	derived	J/s	0	1.3558179	60	0	lbf.ft/min
764	lbf.ft/s	foot pound-force per second	L2M/T3	N	derived	J/s	0	1.3558179	1	0	lbf.ft/s
765	MJ/a	megajoule per julian-year	L2M/T3	N	derived	J/s	0	1e+06	3.16e+07	0	MJ/a
766	quad/a	quad per julian-year	L2M/T3	N	derived	J/s	0	1.06e+18	3.16e+07	0	quad/a
767	TJ/a	terajoule per julian-year	L2M/T3	N	derived	J/s	0	1e+12	3.16e+07	0	TJ/a
768	ucal[th]/s	millionth of calorie per second	L2M/T3	N	derived	J/s	0	4.18e-06	1	0	ucal[th]/s
769	cW	centiwatt	L2M/T3	Y	prefixed	W	0	0.01	1	0	cW
770	dW	deciwatt	L2M/T3	Y	prefixed	W	0	0.1	1	0	dW
771	EW	exawatt	L2M/T3	Y	prefixed	W	0	1e+18	1	0	EW
772	fW	femtowatt	L2M/T3	Y	prefixed	W	0	1e-15	1	0	fW
773	GW	gigawatt	L2M/T3	Y	prefixed	W	0	1e+09	1	0	GW
774	kW	kilowatt	L2M/T3	Y	prefixed	W	0	1000	1	0	kW
775	mW	milliwatt	L2M/T3	Y	prefixed	W	0	0.001	1	0	mW
776	MW	megawatt	L2M/T3	Y	prefixed	W	0	1e+06	1	0	MW
777	nW	nanowatt	L2M/T3	Y	prefixed	W	0	1e-09	1	0	nW
778	pW	picowatt	L2M/T3	Y	prefixed	W	0	1e-12	1	0	pW
779	TW	terawatt	L2M/T3	Y	prefixed	W	0	1e+12	1	0	TW
780	uW	microwatt	L2M/T3	Y	prefixed	W	0	1e-06	1	0	uW
781	m/Pa	metre per Pascal	L2T2/M	Y	derived	IS-BASE	0	1	1	0	m/Pa
782	ft/psi	foot per psi	L2T2/M	N	derived	m/Pa	0	0.000197	4.4482217	0	ft/psi
783	m/kPa	metre per kilopascal	L2T2/M	Y	derived	m/Pa	0	0.001	1	0	m/kPa
784	bbl	barrel	L3	N	atom	m3	0	0.1589873	1	0	bbl
785	floz[UK]	UK fluid-ounce	L3	N	atom	m3	0	0.00454609	160	0	floz[UK]
786	floz[US]	US fluid-ounce	L3	N	atom	m3	0	0.003785412	128	0	floz[US]
787	gal[UK]	UK gallon	L3	N	atom	m3	0	0.00454609	1	0	gal[UK]
788	gal[US]	US gallon	L3	N	atom	m3	0	0.003785412	1	0	gal[US]
789	L	litre	L3	Y	atom-allowed	m3	0	0.001	1	0	L
790	pt[UK]	UK pint	L3	N	atom	m3	0	0.00454609	8	0	pt[UK]
791	pt[US]	US pint	L3	N	atom	m3	0	0.003785412	8	0	pt[US]
792	qt[UK]	UK quart	L3	N	atom	m3	0	0.00454609	4	0	qt[UK]
793	qt[US]	US quart	L3	N	atom	m3	0	0.003785412	4	0	qt[US]
794	TD[API].m	teradarcy-API metre	L3	Y	derived	IS-BASE	0	1	1	0	TD[API].m
795	1000 bbl	thousand barrel	L3	N	derived	m3	0	158.98729	1	0	1000 bbl
796	1000 ft3	thousand cubic foot	L3	N	derived	m3	0	28.316847	1	0	1000 ft3
797	1000 gal[UK]	thousand UK gallon	L3	N	derived	m3	0	4.54609	1	0	1000 gal[UK]
798	1000 gal[US]	thousand US gallon	L3	N	derived	m3	0	3.7854118	1	0	1000 gal[US]
799	1000 m3	thousand cubic metre	L3	N	derived	m3	0	1000	1	0	1000 m3
800	1E12 ft3	million million cubic foot	L3	N	derived	m3	0	2.83e+10	1	0	1E12 ft3
801	1E6 bbl	million barrel	L3	N	derived	m3	0	159000	1	0	1E6 bbl
802	1E6 ft3	million cubic foot	L3	N	derived	m3	0	28300	1	0	1E6 ft3
803	1E-6 gal[US]	millionth of US gallon	L3	N	derived	m3	0	3.79e-09	1	0	1E-6 gal[US]
804	1E6 m3	million cubic metre	L3	N	derived	m3	0	1e+06	1	0	1E6 m3
805	1E9 bbl	thousand million barrel	L3	N	derived	m3	0	1.59e+08	1	0	1E9 bbl
806	1E9 ft3	thousand million cubic foot	L3	N	derived	m3	0	2.83e+07	1	0	1E9 ft3
807	acre.ft	acre foot	L3	N	derived	m3	0	1.91e+10	1.55e+07	0	acre.ft
808	cm3	cubic centimetre	L3	Y	derived	m3	0	1e-06	1	0	cm3
809	dm3	cubic decimetre	L3	Y	derived	m3	0	0.001	1	0	dm3
810	ha.m	hectare metre	L3	Y	derived	m3	0	10000	1	0	ha.m
811	km3	cubic kilometre	L3	Y	derived	m3	0	1e+09	1	0	km3
812	mm3	cubic millimetre	L3	Y	derived	m3	0	1e-09	1	0	mm3
813	um2.m	square micrometre metre	L3	Y	derived	m3	0	1e-12	1	0	um2.m
814	D.ft	darcy foot	L3	N	derived	TD[API].m	0	3.05e-13	1.01325	0	D.ft
815	D.m	darcy metre	L3	N	derived	TD[API].m	0	1e-12	1.01325	0	D.m
816	mD.ft	millidarcy foot	L3	N	derived	TD[API].m	0	3.05e-16	1.01325	0	mD.ft
817	mD.m	millidarcy metre	L3	N	derived	TD[API].m	0	1e-15	1.01325	0	mD.m
818	m3	cubic metre	L3	Y	derived	IS-BASE	0	1	1	0	m3
819	ft3	cubic foot	L3	N	derived	m3	0	0.028316846	1	0	ft3,ftÂ³
820	in3	cubic inch	L3	N	derived	m3	0	1.64e-05	1	0	in3
821	mi3	cubic mile	L3	N	derived	m3	0	4.1699999e+09	1	0	mi3
822	yd3	cubic yard	L3	N	derived	m3	0	0.76455486	1	0	yd3
823	hL	hectolitre	L3	Y	prefixed	m3	0	0.1	1	0	hL
824	mL	millilitre	L3	Y	prefixed	m3	0	1e-06	1	0	mL
825	m3/rad	cubic metre per radian	L3/A	Y	derived	IS-BASE	0	1	1	0	m3/rad
826	ft3/rad	cubic foot per radian	L3/A	N	derived	m3/rad	0	0.028316846	1	0	ft3/rad
827	m3/rev	cubic metre per revolution	L3/A	N	derived	m3/rad	0	1	6.283	0	m3/rev
828	m3/kg	cubic metre per kilogram	L3/M	Y	derived	IS-BASE	0	1	1	0	m3/kg
829	0.01 L/kg	litre per hundred kilogram	L3/M	N	derived	m3/kg	0	1e-05	1	0	0.01 L/kg
830	bbl/ton[UK]	barrel per UK ton-mass	L3/M	N	derived	m3/kg	0	0.1589873	1016.04694	0	bbl/ton[UK]
831	bbl/ton[US]	barrel per US ton-mass	L3/M	N	derived	m3/kg	0	0.1589873	907.18475	0	bbl/ton[US]
832	cm3/g	cubic centimetre per gram	L3/M	Y	derived	m3/kg	0	0.001	1	0	cm3/g
833	dm3/kg	cubic decimetre per kilogram	L3/M	Y	derived	m3/kg	0	0.001	1	0	dm3/kg
834	dm3/t	cubic decimetre per ton	L3/M	Y	derived	m3/kg	0	1e-06	1	0	dm3/t
835	ft3/kg	cubic foot per kilogram	L3/M	N	derived	m3/kg	0	0.028316846	1	0	ft3/kg
836	ft3/lbm	cubic foot per pound-mass	L3/M	N	derived	m3/kg	0	0.028316846	0.45359236	0	ft3/lbm
837	ft3/sack[94lbm]	cubic foot per 94-pound-sack	L3/M	N	derived	m3/kg	0	0.028316846	42.637684	0	ft3/sack[94lbm]
838	gal[UK]/lbm	UK gallon per pound-mass	L3/M	N	derived	m3/kg	0	0.00454609	0.45359236	0	gal[UK]/lbm
839	gal[US]/lbm	US gallon per pound-mass	L3/M	N	derived	m3/kg	0	0.003785412	0.45359236	0	gal[US]/lbm
840	gal[US]/sack[94lbm]	US gallon per 94-pound-sack	L3/M	N	derived	m3/kg	0	0.003785412	42.637684	0	gal[US]/sack[94lbm]
841	gal[US]/ton[UK]	US gallon per UK ton-mass	L3/M	N	derived	m3/kg	0	0.003785412	1016.04694	0	gal[US]/ton[UK]
842	gal[US]/ton[US]	US gallon per US ton-mass	L3/M	N	derived	m3/kg	0	0.003785412	907.18475	0	gal[US]/ton[US]
843	L/kg	litre per kilogram	L3/M	Y	derived	m3/kg	0	0.001	1	0	L/kg
844	L/t	litre per tonne	L3/M	Y	derived	m3/kg	0	1e-06	1	0	L/t
845	L/ton[UK]	litre per UK ton-mass	L3/M	N	derived	m3/kg	0	0.001	1016.04694	0	L/ton[UK]
846	m3/g	cubic metre per gram	L3/M	Y	derived	m3/kg	0	1000	1	0	m3/g
847	m3/t	cubic metre per tonne	L3/M	Y	derived	m3/kg	0	0.001	1	0	m3/t
848	m3/ton[UK]	cubic metre per UK ton-mass	L3/M	N	derived	m3/kg	0	1	1016.04694	0	m3/ton[UK]
849	m3/ton[US]	cubic metre per US ton-mass	L3/M	N	derived	m3/kg	0	1	907.18475	0	m3/ton[US]
850	m3/mol	cubic metre per gram-mole	L3/N	Y	derived	IS-BASE	0	1	1	0	m3/mol
986	10 kN	ten kilonewton	LM/T2	N	derived	N	0	10000	1	0	10 kN
851	dm3/kmol	cubic decimetre per kilogram-mole	L3/N	Y	derived	m3/mol	0	1e-06	1	0	dm3/kmol
852	ft3/lbmol	cubic foot per pound-mass-mole	L3/N	N	derived	m3/mol	0	0.028316846	453.59238	0	ft3/lbmol
853	L/kmol	litre per kilogram-mole	L3/N	Y	derived	m3/mol	0	1e-06	1	0	L/kmol
854	L/mol	litre per gram-mole	L3/N	Y	derived	m3/mol	0	0.001	1	0	L/mol
855	m3/kmol	cubic metre per kilogram-mole	L3/N	Y	derived	m3/mol	0	0.001	1	0	m3/kmol
856	m3/s	cubic metre per second	L3/T	Y	derived	IS-BASE	0	1	1	0	m3/s
857	1/30 cm3/min	cubic centimetre per thirty minute	L3/T	N	derived	m3/s	0	1e-06	1800	0	1/30 cm3/min
858	1000 bbl/d	thousand barrel per day	L3/T	N	derived	m3/s	0	158.98729	86400	0	1000 bbl/d
859	1000 ft3/d	thousand cubic foot per day	L3/T	N	derived	m3/s	0	28.316847	86400	0	1000 ft3/d
860	1000 m3/d	thousand cubic metre per day	L3/T	N	derived	m3/s	0	1000	86400	0	1000 m3/d
861	1000 m3/h	thousand cubic metre per hour	L3/T	N	derived	m3/s	0	1000	3600	0	1000 m3/h
862	1E6 bbl/d	million barrel per day	L3/T	N	derived	m3/s	0	159000	86400	0	1E6 bbl/d
863	1E6 ft3/d	million cubic foot per day	L3/T	N	derived	m3/s	0	28300	86400	0	1E6 ft3/d
864	1E6 m3/d	million cubic metre per day	L3/T	N	derived	m3/s	0	1e+06	86400	0	1E6 m3/d
865	bbl/d	barrel per day	L3/T	N	derived	m3/s	0	0.1589873	86400	0	bbl/d
866	bbl/h	barrel per hour	L3/T	N	derived	m3/s	0	0.1589873	3600	0	bbl/h
867	bbl/min	barrel per minute	L3/T	N	derived	m3/s	0	0.1589873	60	0	bbl/min
868	cm3/h	cubic centimetre per hour	L3/T	Y	derived	m3/s	0	1e-06	3600	0	cm3/h
869	cm3/min	cubic centimetre per minute	L3/T	Y	derived	m3/s	0	1e-06	60	0	cm3/min
870	cm3/s	cubic centimetre per second	L3/T	Y	derived	m3/s	0	1e-06	1	0	cm3/s
871	dm3/s	cubic decimetre per second	L3/T	Y	derived	m3/s	0	0.001	1	0	dm3/s
872	ft3/d	cubic foot per day	L3/T	N	derived	m3/s	0	0.028316846	86400	0	ft3/d
873	ft3/h	cubic foot per hour	L3/T	N	derived	m3/s	0	0.028316846	3600	0	ft3/h
874	ft3/min	cubic foot per minute	L3/T	N	derived	m3/s	0	0.028316846	60	0	ft3/min
875	ft3/s	cubic foot per second	L3/T	N	derived	m3/s	0	0.028316846	1	0	ft3/s
876	gal[UK]/d	UK gallon per day	L3/T	N	derived	m3/s	0	0.00455	86400	0	gal[UK]/d
877	gal[UK]/h	UK gallon per hour	L3/T	N	derived	m3/s	0	0.00455	3600	0	gal[UK]/h
878	gal[UK]/min	UK gallon per minute	L3/T	N	derived	m3/s	0	0.00455	60	0	gal[UK]/min
879	gal[US]/d	US gallon per day	L3/T	N	derived	m3/s	0	0.00379	86400	0	gal[US]/d,galUS/D
880	gal[US]/h	US gallon per hour	L3/T	N	derived	m3/s	0	0.00379	3600	0	gal[US]/h
881	gal[US]/min	US gallon per minute	L3/T	N	derived	m3/s	0	0.00379	60	0	gal[US]/min,galUS/min
882	L/h	litre per hour	L3/T	Y	derived	m3/s	0	0.001	3600	0	L/h
883	L/min	litre per minute	L3/T	Y	derived	m3/s	0	0.001	60	0	L/min
884	L/s	litre per second	L3/T	Y	derived	m3/s	0	0.001	1	0	L/s
885	m3/d	cubic metre per day	L3/T	Y	derived	m3/s	0	1	86400	0	m3/d
886	m3/h	cubic metre per hour	L3/T	Y	derived	m3/s	0	1	3600	0	m3/h
887	m3/min	cubic metre per minute	L3/T	Y	derived	m3/s	0	1	60	0	m3/min
888	m3/s2	cubic metre per second squared	L3/T2	Y	derived	IS-BASE	0	1	1	0	m3/s2
889	bbl/d2	(barrel per day) per day	L3/T2	N	derived	m3/s2	0	0.1589873	7.4599997e+09	0	bbl/d2
890	bbl/h2	(barrel per hour) per hour	L3/T2	N	derived	m3/s2	0	0.1589873	1.3e+07	0	bbl/h2
891	dm3/s2	(cubic decimetre per second) per second	L3/T2	Y	derived	m3/s2	0	0.001	1	0	dm3/s2
892	ft3/d2	(cubic foot per day) per day	L3/T2	N	derived	m3/s2	0	0.028316846	7.4599997e+09	0	ft3/d2
893	ft3/h2	(cubic foot per hour) per hour	L3/T2	N	derived	m3/s2	0	0.028316846	1.3e+07	0	ft3/h2
894	ft3/min2	(cubic foot per minute) per minute	L3/T2	N	derived	m3/s2	0	0.028316846	3600	0	ft3/min2
895	ft3/s2	(cubic foot per second) per second	L3/T2	N	derived	m3/s2	0	0.028316846	1	0	ft3/s2
896	gal[UK]/h2	(UK gallon per hour) per hour	L3/T2	N	derived	m3/s2	0	0.00455	1.3e+07	0	gal[UK]/h2
897	gal[UK]/min2	(UK gallon per minute) per minute	L3/T2	N	derived	m3/s2	0	0.00455	3600	0	gal[UK]/min2
898	gal[US]/h2	(US gallon per hour) per hour	L3/T2	N	derived	m3/s2	0	0.00379	1.3e+07	0	gal[US]/h2
899	gal[US]/min2	(US gallon per minute) per minute	L3/T2	N	derived	m3/s2	0	0.00379	3600	0	gal[US]/min2
900	L/s2	(litre per second) per second	L3/T2	Y	derived	m3/s2	0	0.001	1	0	L/s2
901	m3/d2	(cubic metre per day) per day	L3/T2	Y	derived	m3/s2	0	1	7.4599997e+09	0	m3/d2
902	ohm.m	ohm metre	L3M/I2T3	Y	derived	IS-BASE	0	1	1	0	ohm.m,ohmÂ·m
903	kohm.m	kiloohm metre	L3M/I2T3	Y	derived	ohm.m	0	1000	1	0	kohm.m
904	nohm.mil2/ft	nanoohm square mil per foot	L3M/I2T3	N	derived	ohm.m	0	6.45e-19	0.3048	0	nohm.mil2/ft
905	nohm.mm2/m	nanoohm square milimetre per metre	L3M/I2T3	Y	derived	ohm.m	0	1e-15	1	0	nohm.mm2/m
906	ohm.cm	ohm centimetre	L3M/I2T3	Y	derived	ohm.m	0	0.01	1	0	ohm.cm
907	ohm.m2/m	ohm square metre per metre	L3M/I2T3	Y	derived	ohm.m	0	1	1	0	ohm.m2/m
908	Wb.m	weber metre	L3M/IT2	Y	derived	IS-BASE	0	1	1	0	Wb.m
909	N.m2	newton square metre	L3M/T2	Y	derived	IS-BASE	0	1	1	0	N.m2
910	dyne.cm2	dyne square centimetre	L3M/T2	N	derived	N.m2	0	1e-09	1	0	dyne.cm2
911	kgf.m2	thousand gram-force square metre	L3M/T2	N	derived	N.m2	0	9.80665	1	0	kgf.m2
912	kN.m2	kilonewton square metre	L3M/T2	Y	derived	N.m2	0	1000	1	0	kN.m2
913	lbf.in2	pound-force square inch	L3M/T2	N	derived	N.m2	0	0.00287	1	0	lbf.in2
914	mN.m2	millinewton square metre	L3M/T2	Y	derived	N.m2	0	0.001	1	0	mN.m2
915	pdl.cm2	poundal square centimetre	L3M/T2	N	derived	N.m2	0	1.38e-05	1	0	pdl.cm2
916	tonf[UK].ft2	UK ton-force square foot	L3M/T2	N	derived	N.m2	0	925.68744	1	0	tonf[UK].ft2
917	tonf[US].ft2	US ton-force square foot	L3M/T2	N	derived	N.m2	0	826.5066	1	0	tonf[US].ft2
918	m2/(Pa.s)	square metre per pascal second	L3T/M	Y	derived	IS-BASE	0	1	1	0	m2/(Pa.s)
919	TD[API]/(Pa.s)	teradarcy-API per pascal second	L3T/M	Y	derived	IS-BASE	0	1	1	0	TD[API]/(Pa.s)
920	bbl/(ft.psi.d)	barrel per day foot psi	L3T/M	N	derived	m2/(Pa.s)	0	0.000103	117000	0	bbl/(ft.psi.d)
921	ft3/(ft.psi.d)	cubic foot per day foot psi	L3T/M	N	derived	m2/(Pa.s)	0	5.99e-05	384000	0	ft3/(ft.psi.d)
922	m2/(kPa.d)	square metre per kilopascal day	L3T/M	Y	derived	m2/(Pa.s)	0	1	8.64e+07	0	m2/(kPa.d)
923	D/(Pa.s)	darcy per pascal second	L3T/M	N	derived	TD[API]/(Pa.s)	0	1e-12	1.01325	0	D/(Pa.s)
924	D/cP	darcy per centipoise	L3T/M	N	derived	TD[API]/(Pa.s)	0	1e-09	1.01325	0	D/cP
925	mD.ft2/(lbf.s)	millidarcy square foot per pound-force second	L3T/M	N	derived	TD[API]/(Pa.s)	0	9.29e-17	4.5071607	0	mD.ft2/(lbf.s)
926	mD.in2/(lbf.s)	millidarcy square inch per pound-force second	L3T/M	N	derived	TD[API]/(Pa.s)	0	6.45e-19	4.5071607	0	mD.in2/(lbf.s)
927	mD/(Pa.s)	millidarcy per pascal second	L3T/M	N	derived	TD[API]/(Pa.s)	0	1e-15	1.01325	0	mD/(Pa.s)
928	mD/cP	millidarcy per centipoise	L3T/M	N	derived	TD[API]/(Pa.s)	0	1e-12	1.01325	0	mD/cP
929	cm4	centimetre to the fourth power	L4	Y	derived	m4	0	1e-08	1	0	cm4
930	m4	metre to the fourth power	L4	Y	derived	IS-BASE	0	1	1	0	m4
931	in4	inch to the fourth power	L4	N	derived	m4	0	4.16e-07	1	0	in4
932	m4/s	metre to the fourth power per second	L4/T	Y	derived	IS-BASE	0	1	1	0	m4/s
933	1000 bbl.ft/d	thousand barrel foot per day	L4/T	N	derived	m4/s	0	48.459328	86400	0	1000 bbl.ft/d
934	1000 m4/d	thousand (cubic metre per day) metre	L4/T	N	derived	m4/s	0	1000	86400	0	1000 m4/d
935	m3/(Pa.s)	cubic metre per pascal second	L4T/M	Y	derived	IS-BASE	0	1	1	0	m3/(Pa.s)
936	1000 ft3/(psi.d)	(thousand cubic foot per day) per psi	L4T/M	N	derived	m3/(Pa.s)	0	0.018268896	384000	0	1000 ft3/(psi.d)
937	bbl/(kPa.d)	(barrel per day) per kilopascal	L4T/M	N	derived	m3/(Pa.s)	0	0.1589873	8.64e+07	0	bbl/(kPa.d)
938	bbl/(psi.d)	(barrel per day) per psi	L4T/M	N	derived	m3/(Pa.s)	0	0.000103	384000	0	bbl/(psi.d)
939	L/(bar.min)	(litre per minute) per bar	L4T/M	Y	derived	m3/(Pa.s)	0	0.001	6e+06	0	L/(bar.min)
940	m3/(bar.d)	(cubic metre per day) per bar	L4T/M	Y	derived	m3/(Pa.s)	0	1	8.64e+09	0	m3/(bar.d)
941	m3/(bar.h)	(cubic metre per hour) per bar	L4T/M	Y	derived	m3/(Pa.s)	0	1	3.6e+08	0	m3/(bar.h)
942	m3/(bar.min)	(cubic metre per minute) per bar	L4T/M	Y	derived	m3/(Pa.s)	0	1	6e+06	0	m3/(bar.min)
943	m3/(kPa.d)	(cubic metre per day) per kilopascal	L4T/M	Y	derived	m3/(Pa.s)	0	1	8.64e+07	0	m3/(kPa.d)
944	m3/(kPa.h)	(cubic metre per hour) per kilopascal	L4T/M	Y	derived	m3/(Pa.s)	0	1	3.6e+06	0	m3/(kPa.h)
945	m3/(psi.d)	(cubic metre per day) per psi	L4T/M	N	derived	m3/(Pa.s)	0	0.00064516	384000	0	m3/(psi.d)
946	m3/Pa	cubic metre per Pascal	L4T2/M	Y	derived	IS-BASE	0	1	1	0	m3/Pa
947	bbl/psi	barrel per psi	L4T2/M	N	derived	m3/Pa	0	0.000103	4.4482217	0	bbl/psi
948	m3/kPa	cubic metre per kilopascal	L4T2/M	Y	derived	m3/Pa	0	0.001	1	0	m3/kPa
949	kg.m	kilogram metre	LM	Y	derived	IS-BASE	0	1	1	0	kg.m
950	lbm.ft	pound-mass foot	LM	N	derived	kg.m	0	0.13825496	1	0	lbm.ft
951	J.m/(s.m2.deltaK)	joule metre per second square metre delta kelvin	LM/DT3	Y	derived	IS-BASE	0	1	1	0	J.m/(s.m2.deltaK)
952	W/(m.deltaK)	watt per metre delta kelvin	LM/DT3	Y	derived	IS-BASE	0	1	1	0	W/(m.deltaK)
953	Btu[IT].in/(h.ft2.deltaF)	BTU per (hour square foot delta Fahrenheit per inch)	LM/DT3	N	derived	J.m/(s.m2.deltaK)	0	241.18576	1670	0	Btu[IT].in/(h.ft2.deltaF)
954	kJ.m/(h.m2.deltaK)	kilojoule metre per hour square metre delta kelvin	LM/DT3	Y	derived	J.m/(s.m2.deltaK)	0	1	3.6	0	kJ.m/(h.m2.deltaK)
955	Btu[IT]/(h.ft.deltaF)	BTU per hour foot delta Fahrenheit	LM/DT3	N	derived	W/(m.deltaK)	0	9500	5490	0	Btu[IT]/(h.ft.deltaF)
956	cal[th]/(h.cm.deltaC)	calorie per hour centimetre delta Celsius	LM/DT3	N	derived	W/(m.deltaK)	0	4.184	36	0	cal[th]/(h.cm.deltaC)
957	cal[th]/(s.cm.deltaC)	calorie per second centimetre delta Celsius	LM/DT3	N	derived	W/(m.deltaK)	0	418.4	1	0	cal[th]/(s.cm.deltaC)
958	kcal[th]/(h.m.deltaC)	thousand calorie per hour metre delta Celsius	LM/DT3	N	derived	W/(m.deltaK)	0	4180	3600	0	kcal[th]/(h.m.deltaC)
959	uH/m	microhenry per metre	LM/I2T2	Y	derived	H/m	0	1e-06	1	0	uH/m
960	H/m	henry per metre	LM/I2T2	Y	derived	IS-BASE	0	1	1	0	H/m
961	ohm/m	ohm per metre	LM/I2T3	Y	derived	IS-BASE	0	1	1	0	ohm/m
962	uohm/ft	microhm per foot	LM/I2T3	N	derived	ohm/m	0	1e-06	0.3048	0	uohm/ft
963	uohm/m	microhm per metre	LM/I2T3	Y	derived	ohm/m	0	1e-06	1	0	uohm/m
964	Wb/m	weber per metre	LM/IT2	Y	derived	IS-BASE	0	1	1	0	Wb/m
965	Wb/mm	weber per millimetre	LM/IT2	Y	derived	Wb/m	0	1000	1	0	Wb/mm
966	V/m	volt per metre	LM/IT3	Y	derived	IS-BASE	0	1	1	0	V/m
967	mV/ft	millivolt per foot	LM/IT3	N	derived	V/m	0	0.001	0.3048	0	mV/ft
968	mV/m	millivolt per metre	LM/IT3	Y	derived	V/m	0	0.001	1	0	mV/m
969	uV/ft	microvolt per foot	LM/IT3	N	derived	V/m	0	1e-06	0.3048	0	uV/ft
970	uV/m	microvolt per metre	LM/IT3	Y	derived	V/m	0	1e-06	1	0	uV/m
971	kg.m/s	kilogram metre per second	LM/T	Y	derived	IS-BASE	0	1	1	0	kg.m/s
972	lbm.ft/s	foot pound-mass per second	LM/T	N	derived	kg.m/s	0	0.13825496	1	0	lbm.ft/s
973	N	newton	LM/T2	Y	atom-special	IS-BASE	0	1	1	0	N
974	dyne	dyne	LM/T2	N	atom	N	0	1e-05	1	0	dyne
975	gf	gram-force	LM/T2	N	atom	N	0	0.00981	1	0	gf
976	lbf	pound-force	LM/T2	N	atom	N	0	4.4482217	1	0	lbf,lb
977	ozf	ounce-force	LM/T2	N	atom	N	0	4.4482217	16	0	ozf
978	pdl	poundal	LM/T2	N	atom	N	0	0.13825496	1	0	pdl
979	tonf[UK]	UK ton-force	LM/T2	N	atom	N	0	9964.017	1	0	tonf[UK]
980	tonf[US]	US ton-force	LM/T2	N	atom	N	0	8896.443	1	0	tonf[US]
981	J.m/m2	joule metre per square metre	LM/T2	Y	derived	IS-BASE	0	1	1	0	J.m/m2
982	J/m	joule per metre	LM/T2	Y	derived	IS-BASE	0	1	1	0	J/m
983	N.m/m	newton metre per metre	LM/T2	Y	derived	IS-BASE	0	1	1	0	N.m/m
984	kcal[th].m/cm2	thousand calorie metre per square centimetre	LM/T2	N	derived	J.m/m2	0	4.18e+07	1	0	kcal[th].m/cm2
985	MJ/m	megajoule per metre	LM/T2	Y	derived	J/m	0	1e+06	1	0	MJ/m
987	kgf.m/m	thousand gram-force metre per metre	LM/T2	N	derived	N.m/m	0	9.80665	1	0	kgf.m/m
988	lbf.ft/in	foot pound-force per inch	LM/T2	N	derived	N.m/m	0	53.37866	1	0	lbf.ft/in
989	lbf.in/in	pound-force inch per inch	LM/T2	N	derived	N.m/m	0	4.4482217	1	0	lbf.in/in
990	tonf[US].mi/ft	US ton-force mile per foot	LM/T2	N	derived	N.m/m	0	4.7e+07	1	0	tonf[US].mi/ft
991	cN	centinewton	LM/T2	Y	prefixed	N	0	0.01	1	0	cN
992	daN	dekanewton	LM/T2	Y	prefixed	N	0	10	1	0	daN
993	dN	decinewton	LM/T2	Y	prefixed	N	0	0.1	1	0	dN
994	EN	exanewton	LM/T2	Y	prefixed	N	0	1e+18	1	0	EN
995	fN	femtonewton	LM/T2	Y	prefixed	N	0	1e-15	1	0	fN
996	GN	giganewton	LM/T2	Y	prefixed	N	0	1e+09	1	0	GN
997	hN	hectonewton	LM/T2	Y	prefixed	N	0	100	1	0	hN
998	kdyne	kilodyne	LM/T2	N	prefixed	N	0	0.01	1	0	kdyne
999	kgf	thousand gram-force	LM/T2	N	prefixed	N	0	9.80665	1	0	kgf
1000	klbf	thousand pound-force	LM/T2	N	prefixed	N	0	4450	1	0	klbf,klb
1001	kN	kilonewton	LM/T2	Y	prefixed	N	0	1000	1	0	kN
1002	Mgf	million gram-force	LM/T2	N	prefixed	N	0	9810	1	0	Mgf
1003	mN	millinewton	LM/T2	Y	prefixed	N	0	0.001	1	0	mN
1004	MN	meganewton	LM/T2	Y	prefixed	N	0	1e+06	1	0	MN
1005	nN	nanonewton	LM/T2	Y	prefixed	N	0	1e-09	1	0	nN
1006	pN	piconewton	LM/T2	Y	prefixed	N	0	1e-12	1	0	pN
1007	TN	teranewton	LM/T2	Y	prefixed	N	0	1e+12	1	0	TN
1008	uN	micronewton	LM/T2	Y	prefixed	N	0	1e-06	1	0	uN
1009	1/bar	per bar	LT2/M	Y	derived	1/Pa	0	1e-05	1	0	1/bar
1010	1/kPa	per kilopascal	LT2/M	Y	derived	1/Pa	0	0.001	1	0	1/kPa
1011	1/pPa	per picopascal	LT2/M	Y	derived	1/Pa	0	1e+12	1	0	1/pPa
1012	1/psi	per psi	LT2/M	N	derived	1/Pa	0	0.00064516	4.4482217	0	1/psi
1013	1/upsi	per millionth of psi	LT2/M	N	derived	1/Pa	0	645.16	4.4482217	0	1/upsi
1014	1/Pa	per pascal	LT2/M	Y	derived	IS-BASE	0	1	1	0	1/Pa
1015	m3/J	cubic metre per joule	LT2/M	Y	derived	IS-BASE	0	1	1	0	m3/J
1016	dm3/(kW.h)	cubic decimetre per kilowatt hour	LT2/M	Y	derived	m3/J	0	0.001	3.6e+06	0	dm3/(kW.h)
1017	dm3/MJ	cubic decimetre per megajoule	LT2/M	Y	derived	m3/J	0	1e-09	1	0	dm3/MJ
1018	m3/(kW.h)	cubic metre per kilowatt hour	LT2/M	Y	derived	m3/J	0	1	3.6e+06	0	m3/(kW.h)
1019	mm3/J	cubic millimetre per joule	LT2/M	Y	derived	m3/J	0	1e-09	1	0	mm3/J
1020	pt[UK]/(hp.h)	UK pint per horsepower hour	LT2/M	N	derived	m3/J	0	0.000568	2.68e+06	0	pt[UK]/(hp.h)
1021	ct	carat	M	N	atom	kg	0	0.0002	1	0	ct
1022	cwt[UK]	UK hundredweight	M	N	atom	kg	0	50.802345	1	0	cwt[UK]
1023	cwt[US]	US hundredweight	M	N	atom	kg	0	45.359238	1	0	cwt[US]
1024	g	gram	M	Y	atom-base	kg	0	0.001	1	0	g
1025	grain	grain	M	N	atom	kg	0	6.48e-05	1	0	grain
1026	lbm	pound-mass	M	N	atom	kg	0	0.45359236	1	0	lbm
1027	ozm	ounce-mass	M	N	atom	kg	0	0.45359236	16	0	ozm
1028	ozm[troy]	troy ounce-mass	M	N	atom	kg	0	0.031103477	1	0	ozm[troy]
1029	sack[94lbm]	94 pound-mass sack	M	N	atom	kg	0	42.637684	1	0	sack[94lbm]
1030	t	tonne	M	Y	atom-allowed	kg	0	1000	1	0	t
1031	ton[UK]	UK ton-mass	M	N	atom	kg	0	1016.04694	1	0	ton[UK]
1032	ton[US]	US ton-mass	M	N	atom	kg	0	907.18475	1	0	ton[US]
1033	kg	kilogram	M	Y	prefixed	IS-BASE	0	1	1	0	kg
1034	ag	attogram	M	Y	prefixed	kg	0	1e-21	1	0	ag
1035	cg	centigram	M	Y	prefixed	kg	0	1e-05	1	0	cg
1036	Eg	exagram	M	Y	prefixed	kg	0	1e+15	1	0	Eg
1037	fg	femtogram	M	Y	prefixed	kg	0	1e-18	1	0	fg
1038	Gg	gigagram	M	Y	prefixed	kg	0	1e+06	1	0	Gg
1039	hg	hectogram	M	Y	prefixed	kg	0	0.1	1	0	hg
1040	klbm	thousand pound-mass	M	N	prefixed	kg	0	453.59238	1	0	klbm
1041	mg	milligram	M	Y	prefixed	kg	0	1e-06	1	0	mg
1042	Mg	megagram	M	Y	prefixed	kg	0	1000	1	0	Mg
1043	ng	nanogram	M	Y	prefixed	kg	0	1e-12	1	0	ng
1044	pg	picogram	M	Y	prefixed	kg	0	1e-15	1	0	pg
1045	Tg	teragram	M	Y	prefixed	kg	0	1e+09	1	0	Tg
1046	ug	microgram	M	Y	prefixed	kg	0	1e-09	1	0	ug
1047	W/(m3.deltaK)	watt per cubic metre delta kelvin	M/DLT3	Y	derived	IS-BASE	0	1	1	0	W/(m3.deltaK)
1048	Btu[IT]/(h.ft3.deltaF)	BTU per hour cubic foot delta Fahrenheit	M/DLT3	N	derived	W/(m3.deltaK)	0	9500	509.70325	0	Btu[IT]/(h.ft3.deltaF)
1049	Btu[IT]/(s.ft3.deltaF)	(BTU per second) per cubic foot delta Fahrenheit	M/DLT3	N	derived	W/(m3.deltaK)	0	9500	0.14158423	0	Btu[IT]/(s.ft3.deltaF)
1050	kW/(m3.deltaK)	killowatt per cubic metre delta kelvin	M/DLT3	Y	derived	W/(m3.deltaK)	0	1000	1	0	kW/(m3.deltaK)
1051	W/(m2.deltaK)	watt per square metre delta kelvin	M/DT3	Y	derived	IS-BASE	0	1	1	0	W/(m2.deltaK)
1052	Btu[IT]/(h.ft2.deltaF)	BTU per hour square foot delta Fahrenheit	M/DT3	N	derived	W/(m2.deltaK)	0	9500	1670	0	Btu[IT]/(h.ft2.deltaF)
1053	Btu[IT]/(h.ft2.deltaR)	BTU per hour square foot delta Rankine	M/DT3	N	derived	W/(m2.deltaK)	0	9500	1670	0	Btu[IT]/(h.ft2.deltaR)
1054	Btu[IT]/(h.m2.deltaC)	BTU per hour square metre delta Celsius	M/DT3	N	derived	W/(m2.deltaK)	0	1055.0559	3600	0	Btu[IT]/(h.m2.deltaC)
1055	Btu[IT]/(s.ft2.deltaF)	(BTU per second) per square foot delta Fahrenheit	M/DT3	N	derived	W/(m2.deltaK)	0	9500	0.4645152	0	Btu[IT]/(s.ft2.deltaF)
1056	cal[th]/(h.cm2.deltaC)	calorie per hour square centimetre delta Celsius	M/DT3	N	derived	W/(m2.deltaK)	0	41800	3600	0	cal[th]/(h.cm2.deltaC)
1057	cal[th]/(s.cm2.deltaC)	calorie per second square centimetre delta Celsius	M/DT3	N	derived	W/(m2.deltaK)	0	41840	1	0	cal[th]/(s.cm2.deltaC)
1058	J/(s.m2.deltaC)	joule per second square metre delta Celsius	M/DT3	Y	derived	W/(m2.deltaK)	0	1	1	0	J/(s.m2.deltaC)
1059	kcal[th]/(h.m2.deltaC)	thousand calorie per hour square metre delta Celsius	M/DT3	N	derived	W/(m2.deltaK)	0	4180	3600	0	kcal[th]/(h.m2.deltaC)
1060	kJ/(h.m2.deltaK)	kilojoule per hour square metre delta kelvin	M/DT3	Y	derived	W/(m2.deltaK)	0	1000	3600	0	kJ/(h.m2.deltaK)
1061	kW/(m2.deltaK)	kilowatt per square metre delta kelvin	M/DT3	Y	derived	W/(m2.deltaK)	0	1000	1	0	kW/(m2.deltaK)
1062	T/m	tesla per metre	M/ILT2	Y	derived	IS-BASE	0	1	1	0	T/m
1063	gauss/cm	gauss per centimetre	M/ILT2	N	derived	T/m	0	0.01	1	0	gauss/cm
1064	mT/dm	millitesla per decimetre	M/ILT2	Y	derived	T/m	0	0.01	1	0	mT/dm
1065	T	tesla	M/IT2	Y	atom-special	IS-BASE	0	1	1	0	T
1066	gauss	gauss	M/IT2	N	atom	T	0	0.0001	1	0	gauss
1067	cgauss	centigauss	M/IT2	N	prefixed	T	0	1e-06	1	0	cgauss
1068	cT	centitesla	M/IT2	Y	prefixed	T	0	0.01	1	0	cT
1069	dgauss	decigauss	M/IT2	N	prefixed	T	0	1e-05	1	0	dgauss
1070	dT	decitesla	M/IT2	Y	prefixed	T	0	0.1	1	0	dT
1071	Egauss	exagauss	M/IT2	N	prefixed	T	0	1e+14	1	0	Egauss
1072	ET	exatesla	M/IT2	Y	prefixed	T	0	1e+18	1	0	ET
1073	fgauss	femtogauss	M/IT2	N	prefixed	T	0	1e-19	1	0	fgauss
1074	fT	femtotesla	M/IT2	Y	prefixed	T	0	1e-15	1	0	fT
1075	Ggauss	gigagauss	M/IT2	N	prefixed	T	0	100000	1	0	Ggauss
1076	GT	gigatesla	M/IT2	Y	prefixed	T	0	1e+09	1	0	GT
1077	kgauss	kilogauss	M/IT2	N	prefixed	T	0	0.1	1	0	kgauss
1078	kT	kilotesla	M/IT2	Y	prefixed	T	0	1000	1	0	kT
1079	mgauss	milligauss	M/IT2	N	prefixed	T	0	1e-07	1	0	mgauss
1080	Mgauss	megagauss	M/IT2	N	prefixed	T	0	100	1	0	Mgauss
1081	mT	millitesla	M/IT2	Y	prefixed	T	0	0.001	1	0	mT
1082	ngauss	nanogauss	M/IT2	N	prefixed	T	0	1e-13	1	0	ngauss
1083	nT	nanotesla	M/IT2	Y	prefixed	T	0	1e-09	1	0	nT
1084	pgauss	picogauss	M/IT2	N	prefixed	T	0	1e-16	1	0	pgauss
1085	pT	picotesla	M/IT2	Y	prefixed	T	0	1e-12	1	0	pT
1086	Tgauss	teragauss	M/IT2	N	prefixed	T	0	1e+08	1	0	Tgauss
1087	TT	teratesla	M/IT2	Y	prefixed	T	0	1e+12	1	0	TT
1088	ugauss	microgauss	M/IT2	N	prefixed	T	0	1e-10	1	0	ugauss
1089	uT	microtesla	M/IT2	Y	prefixed	T	0	1e-06	1	0	uT
1090	kg/m	kilogram per metre	M/L	Y	derived	IS-BASE	0	1	1	0	kg/m
1091	kg.m/cm2	kilogram metre per square centimetre	M/L	Y	derived	kg/m	0	10000	1	0	kg.m/cm2
1092	klbm/in	thousand pound-mass per inch	M/L	N	derived	kg/m	0	453.59238	0.0254	0	klbm/in
1093	lbm/ft	pound-mass per foot	M/L	N	derived	kg/m	0	0.45359236	0.3048	0	lbm/ft
1094	Mg/in	megagram per inch	M/L	N	derived	kg/m	0	1000	0.0254	0	Mg/in
1095	kg/m2	kilogram per square metre	M/L2	Y	derived	IS-BASE	0	1	1	0	kg/m2
1096	0.01 lbm/ft2	pound-mass per hundred square foot	M/L2	N	derived	kg/m2	0	0.45359236	9.290304	0	0.01 lbm/ft2
1097	lbm/ft2	pound-mass per square foot	M/L2	N	derived	kg/m2	0	0.45359236	0.09290304	0	lbm/ft2
1098	Mg/m2	megagram per square metre	M/L2	Y	derived	kg/m2	0	1000	1	0	Mg/m2
1099	ton[US]/ft2	US ton-mass per square foot	M/L2	N	derived	kg/m2	0	907.18475	0.09290304	0	ton[US]/ft2
1100	kg/(m2.s)	kilogram per square metre second	M/L2T	Y	derived	IS-BASE	0	1	1	0	kg/(m2.s)
1101	g.ft/(cm3.s)	gram foot per cubic centimetre second	M/L2T	N	derived	kg/(m2.s)	0	304.8	1	0	g.ft/(cm3.s)
1102	g.m/(cm3.s)	gram metre per cubic centimetre second	M/L2T	Y	derived	kg/(m2.s)	0	1000	1	0	g.m/(cm3.s)
1103	kPa.s/m	kilopascal second per metre	M/L2T	Y	derived	kg/(m2.s)	0	1000	1	0	kPa.s/m
1104	lbm/(ft2.h)	pound-mass per square foot hour	M/L2T	N	derived	kg/(m2.s)	0	0.45359236	334	0	lbm/(ft2.h)
1105	lbm/(ft2.s)	pound-mass per square foot second	M/L2T	N	derived	kg/(m2.s)	0	0.45359236	0.09290304	0	lbm/(ft2.s)
1106	MPa.s/m	megapascal second per metre	M/L2T	Y	derived	kg/(m2.s)	0	1e+06	1	0	MPa.s/m
1107	N/m3	newton per cubic metre	M/L2T2	Y	derived	IS-BASE	0	1	1	0	N/m3
1108	0.001 psi/ft	psi per thousand foot	M/L2T2	N	derived	N/m3	0	4.4482217	0.19664477	0	0.001 psi/ft
1109	0.01 psi/ft	psi per hundred foot	M/L2T2	N	derived	N/m3	0	4.4482217	0.019664478	0	0.01 psi/ft
1110	atm/ft	standard atmosphere per foot	M/L2T2	N	derived	N/m3	0	101000	0.3048	0	atm/ft
1111	atm/hm	standard atmosphere per hundred metre	M/L2T2	N	derived	N/m3	0	1010	1	0	atm/hm
1112	atm/m	standard atmosphere per metre	M/L2T2	N	derived	N/m3	0	101000	1	0	atm/m
1113	bar/km	bar per kilometre	M/L2T2	Y	derived	N/m3	0	100	1	0	bar/km
1114	bar/m	bar per metre	M/L2T2	Y	derived	N/m3	0	100000	1	0	bar/m
1115	GPa/cm	gigapascal per centimetre	M/L2T2	Y	derived	N/m3	0	1e+11	1	0	GPa/cm
1116	kPa/hm	kilopascal per hectometre	M/L2T2	Y	derived	N/m3	0	10	1	0	kPa/hm
1117	kPa/m	kilopascal per metre	M/L2T2	Y	derived	N/m3	0	1000	1	0	kPa/m
1118	lbf/ft3	pound-force per cubic foot	M/L2T2	N	derived	N/m3	0	4.4482217	0.028316846	0	lbf/ft3,lb/ftÂ³
1119	lbf/gal[US]	pound-force per US gallon	M/L2T2	N	derived	N/m3	0	4.4482217	0.00379	0	lbf/gal[US],lb/galUS
1120	MPa/m	megapascal per metre	M/L2T2	Y	derived	N/m3	0	1e+06	1	0	MPa/m
1121	Pa/m	pascal per metre	M/L2T2	Y	derived	N/m3	0	1	1	0	Pa/m
1122	psi/ft	psi per foot	M/L2T2	N	derived	N/m3	0	4.4482217	0.000197	0	psi/ft
1123	psi/m	psi per metre	M/L2T2	N	derived	N/m3	0	4.4482217	0.00064516	0	psi/m
1124	kg/m3	kilogram per cubic metre	M/L3	Y	derived	IS-BASE	0	1	1	0	kg/m3
1125	0.001 lbm/bbl	pound-mass per thousand barrel	M/L3	N	derived	kg/m3	0	0.45359236	158.98729	0	0.001 lbm/bbl
1126	0.001 lbm/gal[UK]	pound-mass per thousand UK gallon	M/L3	N	derived	kg/m3	0	0.45359236	4.54609	0	0.001 lbm/gal[UK]
1127	0.001 lbm/gal[US]	pound-mass per thousand US gallon	M/L3	N	derived	kg/m3	0	0.45359236	3.7854118	0	0.001 lbm/gal[US]
1128	0.01 grain/ft3	grain per hundred cubic foot	M/L3	N	derived	kg/m3	0	6.48e-05	2.8316846	0	0.01 grain/ft3
1129	0.1 lbm/bbl	pound-mass per ten barrel	M/L3	N	derived	kg/m3	0	0.45359236	1.589873	0	0.1 lbm/bbl
1130	10 Mg/m3	ten thousand kilogram per cubic metre	M/L3	N	derived	kg/m3	0	10000	1	0	10 Mg/m3
1131	g/cm3	gram per cubic centimetre	M/L3	Y	derived	kg/m3	0	1000	1	0	g/cm3
1132	g/dm3	gram per cubic decimetre	M/L3	Y	derived	kg/m3	0	1	1	0	g/dm3
1133	g/gal[UK]	gram per UK gallon	M/L3	N	derived	kg/m3	0	0.001	0.00455	0	g/gal[UK]
1134	g/gal[US]	gram per US gallon	M/L3	N	derived	kg/m3	0	0.001	0.00379	0	g/gal[US]
1135	g/L	gram per litre	M/L3	Y	derived	kg/m3	0	1	1	0	g/L
1136	g/m3	gram per cubic metre	M/L3	Y	derived	kg/m3	0	0.001	1	0	g/m3
1137	grain/ft3	grain per cubic foot	M/L3	N	derived	kg/m3	0	6.48e-05	0.028316846	0	grain/ft3
1138	grain/gal[US]	grain per US gallon	M/L3	N	derived	kg/m3	0	6.48e-05	0.00379	0	grain/gal[US]
1139	kg/dm3	kilogram per cubic decimetre	M/L3	Y	derived	kg/m3	0	1000	1	0	kg/dm3
1140	kg/L	kilogram per litre	M/L3	Y	derived	kg/m3	0	1000	1	0	kg/L
1141	lbm/bbl	pound-mass per barrel	M/L3	N	derived	kg/m3	0	0.45359236	0.1589873	0	lbm/bbl
1142	lbm/ft3	pound-mass per cubic foot	M/L3	N	derived	kg/m3	0	0.45359236	0.028316846	0	lbm/ft3
1143	lbm/gal[UK]	pound-mass per UK gallon	M/L3	N	derived	kg/m3	0	0.45359236	0.00455	0	lbm/gal[UK]
1144	lbm/gal[US]	pound-mass per US gallon	M/L3	N	derived	kg/m3	0	0.45359236	0.00379	0	lbm/gal[US]
1145	lbm/in3	pound-mass per cubic inch	M/L3	N	derived	kg/m3	0	0.45359236	1.64e-05	0	lbm/in3
1146	mg/dm3	milligram per cubic decimetre	M/L3	Y	derived	kg/m3	0	0.001	1	0	mg/dm3
1147	mg/gal[US]	milligram per US gallon	M/L3	N	derived	kg/m3	0	1e-06	0.00379	0	mg/gal[US]
1148	mg/L	milligram per litre	M/L3	Y	derived	kg/m3	0	0.001	1	0	mg/L
1149	Mg/m3	megagram per cubic metre	M/L3	Y	derived	kg/m3	0	1000	1	0	Mg/m3
1150	mg/m3	milligram per cubic metre	M/L3	Y	derived	kg/m3	0	1e-06	1	0	mg/m3
1151	t/m3	tonne per cubic metre	M/L3	Y	derived	kg/m3	0	1000	1	0	t/m3
1152	ug/cm3	microgram per cubic centimetre	M/L3	Y	derived	kg/m3	0	0.001	1	0	ug/cm3
1153	kg/m4	kilogram per metre to the fourth power	M/L4	Y	derived	IS-BASE	0	1	1	0	kg/m4
1154	g/cm4	gram per centimetre to the fourth power	M/L4	Y	derived	kg/m4	0	100000	1	0	g/cm4
1155	kg/dm4	kilogram per decimetre to the fourth power	M/L4	Y	derived	kg/m4	0	10000	1	0	kg/dm4
1156	lbm/(gal[UK].ft)	pound-mass per UK gallon foot	M/L4	N	derived	kg/m4	0	0.45359236	0.00139	0	lbm/(gal[UK].ft)
1157	lbm/(gal[US].ft)	pound-mass per US gallon foot	M/L4	N	derived	kg/m4	0	0.45359236	0.00115	0	lbm/(gal[US].ft)
1158	lbm/ft4	pound-mass per foot to the fourth power	M/L4	N	derived	kg/m4	0	0.45359236	0.00863	0	lbm/ft4
1159	Pa.s2/m3	pascal second squared per cubic metre	M/L4	Y	derived	kg/m4	0	1	1	0	Pa.s2/m3
1160	Pa.s/m3	pascal second per cubic metre	M/L4T	Y	derived	IS-BASE	0	1	1	0	Pa.s/m3
1161	psi.d/bbl	psi day per barrel	M/L4T	N	derived	Pa.s/m3	0	384000	0.000103	0	psi.d/bbl
1162	Pa/m3	pascal per cubic metre	M/L4T2	Y	derived	IS-BASE	0	1	1	0	Pa/m3
1163	psi2.d/(cP.ft3)	psi squared day per centipoise cubic foot	M/L4T2	N	derived	Pa/m3	0	1.71e+09	1.18e-08	0	psi2.d/(cP.ft3)
1164	P	poise	M/LT	N	atom	Pa.s	0	0.1	1	0	P
1165	kg/(m.s)	kilogram per metre second	M/LT	Y	derived	IS-BASE	0	1	1	0	kg/(m.s)
1166	Pa.s	pascal second	M/LT	Y	derived	IS-BASE	0	1	1	0	Pa.s
1167	lbm/(ft.h)	pound-mass per hour foot	M/LT	N	derived	kg/(m.s)	0	0.45359236	1100	0	lbm/(ft.h)
1168	lbm/(ft.s)	pound-mass per second foot	M/LT	N	derived	kg/(m.s)	0	0.45359236	0.3048	0	lbm/(ft.s)
1169	dyne.s/cm2	dyne second per square centimetre	M/LT	N	derived	Pa.s	0	0.1	1	0	dyne.s/cm2
1170	kgf.s/m2	thousand gram-force second per square metre	M/LT	N	derived	Pa.s	0	9.80665	1	0	kgf.s/m2
1171	lbf.s/ft2	pound-force second per square foot	M/LT	N	derived	Pa.s	0	4.4482217	0.09290304	0	lbf.s/ft2
1172	lbf.s/in2	pound-force second per square inch	M/LT	N	derived	Pa.s	0	4.4482217	0.000645	0	lbf.s/in2
1173	mPa.s	millipascal second	M/LT	Y	derived	Pa.s	0	0.001	1	0	mPa.s
1174	N.s/m2	newton second per square metre	M/LT	Y	derived	Pa.s	0	1	1	0	N.s/m2
1175	psi.s	psi second	M/LT	N	derived	Pa.s	0	4.4482217	0.00064516	0	psi.s
1176	cP	centipoise	M/LT	N	prefixed	Pa.s	0	0.001	1	0	cP
1177	dP	decipoise	M/LT	N	prefixed	Pa.s	0	0.01	1	0	dP
1178	EP	exapoise	M/LT	N	prefixed	Pa.s	0	1e+17	1	0	EP
1179	fP	femtopoise	M/LT	N	prefixed	Pa.s	0	1e-16	1	0	fP
1180	GP	gigapoise	M/LT	N	prefixed	Pa.s	0	1e+08	1	0	GP
1181	kP	kilopoise	M/LT	N	prefixed	Pa.s	0	100	1	0	kP
1182	mP	millipoise	M/LT	N	prefixed	Pa.s	0	0.0001	1	0	mP
1183	MP	megapoise	M/LT	N	prefixed	Pa.s	0	100000	1	0	MP
1184	nP	nanopoise	M/LT	N	prefixed	Pa.s	0	1e-10	1	0	nP
1185	pP	picopoise	M/LT	N	prefixed	Pa.s	0	1e-13	1	0	pP
1186	TP	terapoise	M/LT	N	prefixed	Pa.s	0	1e+11	1	0	TP
1187	uP	micropoise	M/LT	N	prefixed	Pa.s	0	1e-07	1	0	uP
1188	Pa	pascal	M/LT2	Y	atom-special	IS-BASE	0	1	1	0	Pa
1189	at	technical atmosphere	M/LT2	N	atom	Pa	0	98100	1	0	at
1190	atm	standard atmosphere	M/LT2	N	atom	Pa	0	101000	1	0	atm
1191	bar	bar	M/LT2	Y	atom-allowed	Pa	0	100000	1	0	bar
1192	cmH2O[4degC]	centimetre of water at 4 degree Celsius	M/LT2	N	atom	Pa	0	98.0638	1	0	cmH2O[4degC]
1193	inH2O[39degF]	inch of water at 39.2 degree Fahrenheit	M/LT2	N	atom	Pa	0	249.082	1	0	inH2O[39degF]
1194	inH2O[60degF]	inch of water at 60 degree Fahrenheit	M/LT2	N	atom	Pa	0	248.84	1	0	inH2O[60degF]
1195	inHg[32degF]	inch of mercury at 32 degree Fahrenheit	M/LT2	N	atom	Pa	0	3390	1	0	inHg[32degF],inHG
1196	inHg[60degF]	inch of mercury at 60 degree Fahrenheit	M/LT2	N	atom	Pa	0	3380	1	0	inHg[60degF]
1197	mmHg[0degC]	millimetres of Mercury at 0 deg C	M/LT2	N	atom	Pa	0	133.322	1	0	mmHg[0degC]
1198	psi	pound-force per square inch	M/LT2	N	atom-special	Pa	0	4.4482217	0.000645	0	psi
1199	torr	torr	M/LT2	N	atom	Pa	0	101000	760	0	torr
1200	umHg[0degC]	micrometre of mercury at 0 degree Celsius	M/LT2	N	atom	Pa	0	0.133322	1	0	umHg[0degC]
1201	J/m3	joule per cubic metre	M/LT2	Y	derived	IS-BASE	0	1	1	0	J/m3
1202	Btu[IT]/bbl	BTU per barrel	M/LT2	N	derived	J/m3	0	1055.0559	0.1589873	0	Btu[IT]/bbl
1203	Btu[IT]/ft3	BTU per cubic foot	M/LT2	N	derived	J/m3	0	1055.0559	0.028316846	0	Btu[IT]/ft3
1204	Btu[IT]/gal[UK]	BTU per UK gallon	M/LT2	N	derived	J/m3	0	1055.0559	0.00455	0	Btu[IT]/gal[UK]
1205	Btu[IT]/gal[US]	BTU per US gallon	M/LT2	N	derived	J/m3	0	1055.0559	0.00379	0	Btu[IT]/gal[US]
1277	g/mol	gram per mole	M/N	Y	derived	kg/mol	0	0.001	1	0	g/mol
1206	cal[th]/cm3	calorie per cubic centimetre	M/LT2	N	derived	J/m3	0	4.18e+06	1	0	cal[th]/cm3
1207	cal[th]/mL	calorie per millilitre	M/LT2	N	derived	J/m3	0	4.18e+06	1	0	cal[th]/mL
1208	cal[th]/mm3	calorie per cubic millimetre	M/LT2	N	derived	J/m3	0	4.18e+09	1	0	cal[th]/mm3
1209	erg/cm3	erg per cubic centimetre	M/LT2	N	derived	J/m3	0	0.1	1	0	erg/cm3
1210	erg/m3	erg per cubic metre	M/LT2	N	derived	J/m3	0	1e-07	1	0	erg/m3
1211	hp.h/bbl	horsepower hour per barrel	M/LT2	N	derived	J/m3	0	2.68e+06	0.1589873	0	hp.h/bbl
1212	J/dm3	joule per cubic decimetre	M/LT2	Y	derived	J/m3	0	1000	1	0	J/dm3
1213	kcal[th]/cm3	thousand calorie per cubic centimetre	M/LT2	N	derived	J/m3	0	4.18e+09	1	0	kcal[th]/cm3
1214	kcal[th]/m3	thousand calorie per cubic metre	M/LT2	N	derived	J/m3	0	4180	1	0	kcal[th]/m3
1215	kJ/dm3	kilojoule per cubic decimetre	M/LT2	Y	derived	J/m3	0	1e+06	1	0	kJ/dm3
1216	kJ/m3	kilojoule per cubic metre	M/LT2	Y	derived	J/m3	0	1000	1	0	kJ/m3
1217	kW.h/dm3	kilowatt hour per cubic decimetre	M/LT2	Y	derived	J/m3	0	3.6e+09	1	0	kW.h/dm3
1218	kW.h/m3	kilowatt hour per cubic metre	M/LT2	Y	derived	J/m3	0	3.6e+06	1	0	kW.h/m3
1219	lbf.ft/bbl	foot pound-force per barrel	M/LT2	N	derived	J/m3	0	1.3558179	0.1589873	0	lbf.ft/bbl
1220	lbf.ft/gal[US]	foot pound-force per US gallon	M/LT2	N	derived	J/m3	0	1.3558179	0.00379	0	lbf.ft/gal[US]
1221	MJ/m3	megajoule per cubic metre	M/LT2	Y	derived	J/m3	0	1e+06	1	0	MJ/m3
1222	MW.h/m3	megawatt hour per cubic metre	M/LT2	Y	derived	J/m3	0	3.6e+09	1	0	MW.h/m3
1223	tonf[US].mi/bbl	US ton-force mile per barrel	M/LT2	N	derived	J/m3	0	1.43e+07	0.1589873	0	tonf[US].mi/bbl
1224	0.01 lbf/ft2	pound-force per hundred square foot	M/LT2	N	derived	Pa	0	4.4482217	9.290304	0	0.01 lbf/ft2
1225	dyne/cm2	dyne per square centimetre	M/LT2	N	derived	Pa	0	0.1	1	0	dyne/cm2
1226	kgf/cm2	thousand gram-force per square centimetre	M/LT2	N	derived	Pa	0	98100	1	0	kgf/cm2
1227	kgf/m2	thousand gram-force per square metre	M/LT2	N	derived	Pa	0	9.80665	1	0	kgf/m2
1228	kgf/mm2	thousand gram-force per square millimetre	M/LT2	N	derived	Pa	0	9.81e+06	1	0	kgf/mm2
1229	kN/m2	kilonewton per square metre	M/LT2	Y	derived	Pa	0	1000	1	0	kN/m2
1230	lbf/ft2	pound-force per square foot	M/LT2	N	derived	Pa	0	4.4482217	0.09290304	0	lbf/ft2
1231	N/m2	newton per square metre	M/LT2	Y	derived	Pa	0	1	1	0	N/m2
1232	N/mm2	newton per square millimetre	M/LT2	Y	derived	Pa	0	1e+06	1	0	N/mm2
1233	tonf[UK]/ft2	UK ton-force per square foot	M/LT2	N	derived	Pa	0	9964.017	0.09290304	0	tonf[UK]/ft2
1234	tonf[US]/ft2	US ton-force per square foot	M/LT2	N	derived	Pa	0	8896.443	0.09290304	0	tonf[US]/ft2
1235	tonf[US]/in2	US ton-force per square inch	M/LT2	N	derived	Pa	0	8896.443	0.000645	0	tonf[US]/in2
1236	cPa	centipascal	M/LT2	Y	prefixed	Pa	0	0.01	1	0	cPa
1237	dPa	decipascal	M/LT2	Y	prefixed	Pa	0	0.1	1	0	dPa
1238	EPa	exapascal	M/LT2	Y	prefixed	Pa	0	1e+18	1	0	EPa
1239	fPa	femtopascal	M/LT2	Y	prefixed	Pa	0	1e-15	1	0	fPa
1240	GPa	gigapascal	M/LT2	Y	prefixed	Pa	0	1e+09	1	0	GPa
1241	hbar	hundred bar	M/LT2	N	prefixed	Pa	0	1e+07	1	0	hbar
1242	kPa	kilopascal	M/LT2	Y	prefixed	Pa	0	1000	1	0	kPa
1243	kpsi	thousand psi	M/LT2	N	prefixed	Pa	0	4450	0.000645	0	kpsi
1244	mbar	thousandth of bar	M/LT2	N	prefixed	Pa	0	100	1	0	mbar
1245	mPa	millipascal	M/LT2	Y	prefixed	Pa	0	0.001	1	0	mPa
1246	MPa	megapascal	M/LT2	Y	prefixed	Pa	0	1e+06	1	0	MPa
1247	Mpsi	million psi	M/LT2	N	prefixed	Pa	0	4.45e+06	0.000645	0	Mpsi
1248	nPa	nanopascal	M/LT2	Y	prefixed	Pa	0	1e-09	1	0	nPa
1249	pPa	picopascal	M/LT2	Y	prefixed	Pa	0	1e-12	1	0	pPa
1250	TPa	terapascal	M/LT2	Y	prefixed	Pa	0	1e+12	1	0	TPa
1251	ubar	millionth of bar	M/LT2	N	prefixed	Pa	0	0.1	1	0	ubar
1252	uPa	micropascal	M/LT2	Y	prefixed	Pa	0	1e-06	1	0	uPa
1253	upsi	millionth of psi	M/LT2	N	prefixed	Pa	0	4.45e-06	0.000645	0	upsi
1254	Pa/s	pascal per second	M/LT3	Y	derived	IS-BASE	0	1	1	0	Pa/s
1255	Pa2/(Pa.s)	pascal squared per pascal second	M/LT3	Y	derived	IS-BASE	0	1	1	0	Pa2/(Pa.s)
1256	W/m3	watt per cubic metre	M/LT3	Y	derived	IS-BASE	0	1	1	0	W/m3
1257	atm/h	standard atmosphere per hour	M/LT3	N	derived	Pa/s	0	101000	3600	0	atm/h
1258	bar/h	bar per hour	M/LT3	Y	derived	Pa/s	0	100000	3600	0	bar/h
1259	kPa/h	kilopascal per hour	M/LT3	Y	derived	Pa/s	0	1000	3600	0	kPa/h
1260	kPa/min	kilopascal per min	M/LT3	Y	derived	Pa/s	0	1000	60	0	kPa/min
1261	MPa/h	megapascal per hour	M/LT3	Y	derived	Pa/s	0	1e+06	3600	0	MPa/h
1262	Pa/h	pascal per hour	M/LT3	Y	derived	Pa/s	0	1	3600	0	Pa/h
1263	psi/h	psi per hour	M/LT3	N	derived	Pa/s	0	4.4482217	2.322576	0	psi/h
1264	psi/min	psi per minute	M/LT3	N	derived	Pa/s	0	4.4482217	0.0387096	0	psi/min
1265	0.001 kPa2/cP	kilopascal squared per thousand centipoise	M/LT3	N	derived	Pa2/(Pa.s)	0	1e+06	1	0	0.001 kPa2/cP
1266	bar2/cP	bar squared per centipoise	M/LT3	N	derived	Pa2/(Pa.s)	0	1e+13	1	0	bar2/cP
1267	kPa2/cP	kilopascal squared per centipoise	M/LT3	N	derived	Pa2/(Pa.s)	0	1e+09	1	0	kPa2/cP
1268	psi2/cP	psi squared per centipoise	M/LT3	N	derived	Pa2/(Pa.s)	0	19.786676	4.16e-10	0	psi2/cP
1269	Btu[IT]/(h.ft3)	BTU per hour cubic foot	M/LT3	N	derived	W/m3	0	1055.0559	101.94065	0	Btu[IT]/(h.ft3)
1270	Btu[IT]/(s.ft3)	(BTU per second) per cubic foot	M/LT3	N	derived	W/m3	0	1055.0559	0.028316846	0	Btu[IT]/(s.ft3)
1271	cal[th]/(h.cm3)	calorie per hour cubic centimetre	M/LT3	N	derived	W/m3	0	4.184	0.0036	0	cal[th]/(h.cm3)
1272	cal[th]/(s.cm3)	calorie per second cubic centimetre	M/LT3	N	derived	W/m3	0	4.18e+06	1	0	cal[th]/(s.cm3)
1273	hp/ft3	horsepower per cubic foot	M/LT3	N	derived	W/m3	0	745.6999	0.028316846	0	hp/ft3
1274	kW/m3	kilowatt per cubic metre	M/LT3	Y	derived	W/m3	0	1000	1	0	kW/m3
1275	uW/m3	microwatt per cubic metre	M/LT3	Y	derived	W/m3	0	1e-06	1	0	uW/m3
1276	kg/mol	kilogram per mole	M/N	Y	derived	IS-BASE	0	1	1	0	kg/mol
1278	lbm/lbmol	pound-mass per pound-mole	M/N	N	derived	kg/mol	0	0.001	1	0	lbm/lbmol
1279	W/(m2.sr)	watt per square metre steradian	M/ST3	Y	derived	IS-BASE	0	1	1	0	W/(m2.sr)
1280	kg/s	kilogram per second	M/T	Y	derived	IS-BASE	0	1	1	0	kg/s
1281	1E6 lbm/a	million pound-mass per julian-year	M/T	N	derived	kg/s	0	454000	3.16e+07	0	1E6 lbm/a
1282	g/s	gram per second	M/T	Y	derived	kg/s	0	0.001	1	0	g/s
1283	kg/d	kilogram per day	M/T	Y	derived	kg/s	0	1	86400	0	kg/d
1284	kg/h	kilogram per hour	M/T	Y	derived	kg/s	0	1	3600	0	kg/h
1285	kg/min	kilogram per min	M/T	Y	derived	kg/s	0	1	60	0	kg/min
1286	lbm/d	pound-mass per day	M/T	N	derived	kg/s	0	0.45359236	86400	0	lbm/d
1287	lbm/h	pound-mass per hour	M/T	N	derived	kg/s	0	0.45359236	3600	0	lbm/h
1288	lbm/min	pound-mass per minute	M/T	N	derived	kg/s	0	0.45359236	60	0	lbm/min
1289	lbm/s	pound-mass per second	M/T	N	derived	kg/s	0	0.45359236	1	0	lbm/s
1290	Mg/a	megagram per julian-year	M/T	N	derived	kg/s	0	1000	3.16e+07	0	Mg/a
1291	Mg/d	megagram per day	M/T	Y	derived	kg/s	0	1000	86400	0	Mg/d
1292	Mg/h	megagram per hour	M/T	Y	derived	kg/s	0	1000	3600	0	Mg/h
1293	Mg/min	megagram per minute	M/T	Y	derived	kg/s	0	1000	60	0	Mg/min
1294	t/a	tonne per julian-year	M/T	N	derived	kg/s	0	1000	3.16e+07	0	t/a
1295	t/d	tonne per day	M/T	Y	derived	kg/s	0	1000	86400	0	t/d
1296	t/h	tonne per hour	M/T	Y	derived	kg/s	0	1000	3600	0	t/h
1297	t/min	tonne per minute	M/T	Y	derived	kg/s	0	1000	60	0	t/min
1298	ton[UK]/a	UK ton-mass per julian-year	M/T	N	derived	kg/s	0	1016.04694	3.16e+07	0	ton[UK]/a
1299	ton[UK]/d	UK ton-mass per day	M/T	N	derived	kg/s	0	1016.04694	86400	0	ton[UK]/d
1300	ton[UK]/h	UK ton-mass per hour	M/T	N	derived	kg/s	0	1016.04694	3600	0	ton[UK]/h
1301	ton[UK]/min	UK ton-mass per minute	M/T	N	derived	kg/s	0	1016.04694	60	0	ton[UK]/min
1302	ton[US]/a	US ton-mass per julian-year	M/T	N	derived	kg/s	0	907.18475	3.16e+07	0	ton[US]/a
1303	ton[US]/d	US ton-mass per day	M/T	N	derived	kg/s	0	907.18475	86400	0	ton[US]/d
1304	ton[US]/h	US ton-mass per hour	M/T	N	derived	kg/s	0	907.18475	3600	0	ton[US]/h
1305	ton[US]/min	US ton-mass per minute	M/T	N	derived	kg/s	0	907.18475	60	0	ton[US]/min
1306	J/m2	joule per square metre	M/T2	Y	derived	IS-BASE	0	1	1	0	J/m2
1307	N/m	newton per metre	M/T2	Y	derived	IS-BASE	0	1	1	0	N/m
1308	erg/cm2	erg per square centimetre	M/T2	N	derived	J/m2	0	0.001	1	0	erg/cm2
1309	J/cm2	joule per square centimetre	M/T2	Y	derived	J/m2	0	10000	1	0	J/cm2
1310	kgf.m/cm2	thousand gram-force metre per square centimetre	M/T2	N	derived	J/m2	0	98066.5	1	0	kgf.m/cm2
1311	lbf.ft/in2	foot pound-force per square inch	M/T2	N	derived	J/m2	0	1.3558179	0.000645	0	lbf.ft/in2
1312	mJ/cm2	millijoule per square centimetre	M/T2	Y	derived	J/m2	0	10	1	0	mJ/cm2
1313	mJ/m2	millijoule per square metre	M/T2	Y	derived	J/m2	0	0.001	1	0	mJ/m2
1314	0.01 lbf/ft	pound-force per hundred foot	M/T2	N	derived	N/m	0	4.4482217	30.48	0	0.01 lbf/ft
1315	1/30 lbf/m	pound-force per thirty metre	M/T2	N	derived	N/m	0	4.4482217	30	0	1/30 lbf/m
1316	1/30 N/m	newton per thirty metre	M/T2	N	derived	N/m	0	1	30	0	1/30 N/m
1317	dyne/cm	dyne per centimetre	M/T2	N	derived	N/m	0	0.001	1	0	dyne/cm
1318	kgf/cm	thousand gram-force per centimetre	M/T2	N	derived	N/m	0	980.665	1	0	kgf/cm
1319	kN/m	kilonewton per metre	M/T2	Y	derived	N/m	0	1000	1	0	kN/m
1320	lbf/ft	pound-force per foot	M/T2	N	derived	N/m	0	4.4482217	0.3048	0	lbf/ft
1321	lbf/in	pound-force per inch	M/T2	N	derived	N/m	0	4.4482217	0.0254	0	lbf/in
1322	mN/km	millinewton per kilometre	M/T2	Y	derived	N/m	0	1e-06	1	0	mN/km
1323	mN/m	millinewton per metre	M/T2	Y	derived	N/m	0	0.001	1	0	mN/m
1324	pdl/cm	poundal per centimetre	M/T2	N	derived	N/m	0	0.13825496	0.01	0	pdl/cm
1325	tonf[UK]/ft	UK ton-force per foot	M/T2	N	derived	N/m	0	9964.017	0.3048	0	tonf[UK]/ft
1326	tonf[US]/ft	US ton-force per foot	M/T2	N	derived	N/m	0	8896.443	0.3048	0	tonf[US]/ft
1327	W/m2	watt per square metre	M/T3	Y	derived	IS-BASE	0	1	1	0	W/m2
1328	Btu[IT]/(h.ft2)	(BTU per hour) per square foot	M/T3	N	derived	W/m2	0	1055.0559	334.45096	0	Btu[IT]/(h.ft2)
1329	Btu[IT]/(s.ft2)	BTU per second square foot	M/T3	N	derived	W/m2	0	1055.0559	0.09290304	0	Btu[IT]/(s.ft2)
1330	cal[th]/(h.cm2)	calorie per hour square centimetre	M/T3	N	derived	W/m2	0	4.184	0.36	0	cal[th]/(h.cm2)
1331	hp/in2	horsepower per square inch	M/T3	N	derived	W/m2	0	745.6999	0.000645	0	hp/in2
1332	hp[hyd]/in2	hydraulic-horsepower per square inch	M/T3	N	derived	W/m2	0	746.043	0.000645	0	hp[hyd]/in2,hhp/in
1333	kW/cm2	kilowatt per square centimetre	M/T3	Y	derived	W/m2	0	1e+07	1	0	kW/cm2
1334	kW/m2	kilowatt per square metre	M/T3	Y	derived	W/m2	0	1000	1	0	kW/m2
1335	mW/m2	milliwatt per square metre	M/T3	Y	derived	W/m2	0	0.001	1	0	mW/m2
1336	ucal[th]/(s.cm2)	millionth of calorie per second square centimetre	M/T3	N	derived	W/m2	0	0.04184	1	0	ucal[th]/(s.cm2)
1337	W/cm2	watt per square centimetre	M/T3	Y	derived	W/m2	0	10000	1	0	W/cm2
1338	W/mm2	watt per square millimetre	M/T3	Y	derived	W/m2	0	1e+06	1	0	W/mm2
1339	GPa2	gigapascal squared	M2/L2T4	Y	derived	Pa2	0	1e+18	1	0	GPa2
1340	kPa2	kilopascal squared	M2/L2T4	Y	derived	Pa2	0	1e+06	1	0	kPa2
1341	kpsi2	(thousand psi) squared	M2/L2T4	N	derived	Pa2	0	1.98e+07	4.16e-07	0	kpsi2
1342	Pa2	pascal squared	M2/L2T4	Y	derived	IS-BASE	0	1	1	0	Pa2
1343	bar2	bar squared	M2/L2T4	Y	derived	Pa2	0	1e+10	1	0	bar2
1344	psi2	psi squared	M2/L2T4	N	derived	Pa2	0	19.786676	4.16e-07	0	psi2
1345	mol	gram-mole	N	Y	atom-base	IS-BASE	0	1	1	0	mol
1346	lbmol	pound-mass-mole	N	N	atom	mol	0	453.59238	1	0	lbmol
1347	kmol	kilogram-mole	N	Y	prefixed	mol	0	1000	1	0	kmol
1348	mmol	milligram-mole	N	Y	prefixed	mol	0	0.001	1	0	mmol
1349	umol	microgram-mole	N	Y	prefixed	mol	0	1e-06	1	0	umol
1350	mol/m2	gram-mole per square metre	N/L2	Y	derived	IS-BASE	0	1	1	0	mol/m2
1351	mol/(s.m2)	gram-mole per second square metre	N/L2T	Y	derived	IS-BASE	0	1	1	0	mol/(s.m2)
1352	lbmol/(h.ft2)	pound-mass-mole per hour square foot	N/L2T	N	derived	mol/(s.m2)	0	453.59238	334.45096	0	lbmol/(h.ft2)
1353	lbmol/(s.ft2)	pound-mass-mole per second square foot	N/L2T	N	derived	mol/(s.m2)	0	453.59238	0.09290304	0	lbmol/(s.ft2)
1354	mol/m3	gram-mole per cubic metre	N/L3	Y	derived	IS-BASE	0	1	1	0	mol/m3
1355	kmol/m3	kilogram-mole per cubic metre	N/L3	Y	derived	mol/m3	0	1000	1	0	kmol/m3
1356	lbmol/ft3	pound-mass-mole per cubic foot	N/L3	N	derived	mol/m3	0	453.59238	0.028316846	0	lbmol/ft3
1357	lbmol/gal[UK]	pound-mass-mole per UK gallon	N/L3	N	derived	mol/m3	0	453.59238	0.00455	0	lbmol/gal[UK]
1358	lbmol/gal[US]	pound-mass-mole per US gallon	N/L3	N	derived	mol/m3	0	453.59238	0.00379	0	lbmol/gal[US]
1359	mol/s	gram-mole per second	N/T	Y	derived	IS-BASE	0	1	1	0	mol/s
1360	kmol/h	kilogram-mole per hour	N/T	Y	derived	mol/s	0	1000	3600	0	kmol/h
1361	kmol/s	kilogram-mole per second	N/T	Y	derived	mol/s	0	1000	1	0	kmol/s
1362	lbmol/h	pound-mass-mole per hour	N/T	N	derived	mol/s	0	453.59238	3600	0	lbmol/h
1363	lbmol/s	pound-mass-mole per second	N/T	N	derived	mol/s	0	453.59238	1	0	lbmol/s
1364	sr	steradian	S	Y	atom-special	IS-BASE	0	1	1	0	sr
1365	s	second	T	Y	atom-base	IS-BASE	0	1	1	0	s
1366	a	julian-year	T	N	atom	s	0	3.16e+07	1	0	a
1367	a[t]	tropical-year	T	N	atom	s	0	3.16e+07	1	0	a[t]
1368	d	day	T	Y	atom-allowed	s	0	86400	1	0	d
1369	h	hour	T	Y	atom-allowed	s	0	3600	1	0	h
1370	min	minute	T	Y	atom-allowed	s	0	60	1	0	min
1371	wk	week	T	N	atom	s	0	605000	1	0	wk
1372	1/2 ms	half of millisecond	T	N	derived	s	0	0.0005	1	0	1/2 ms
1373	100 ka[t]	hundred thousand tropical-year	T	N	derived	s	0	3.16e+12	1	0	100 ka[t]
1374	ca	hundredth of julian-year	T	N	prefixed	s	0	316000	1	0	ca
1375	cs	centisecond	T	Y	prefixed	s	0	0.01	1	0	cs
1376	ds	decisecond	T	Y	prefixed	s	0	0.1	1	0	ds
1377	Ea[t]	million million million tropical-year	T	N	prefixed	s	0	3.16e+25	1	0	Ea[t]
1378	fa	femtojulian-year	T	N	prefixed	s	0	3.16e-08	1	0	fa
1379	Ga[t]	thousand million tropical-year	T	N	prefixed	s	0	3.16e+16	1	0	Ga[t]
1380	hs	hectosecond	T	Y	prefixed	s	0	100	1	0	hs
1381	ka[t]	thousand tropical-year	T	N	prefixed	s	0	3.1600001e+10	1	0	ka[t]
1382	Ma[t]	million tropical-year	T	N	prefixed	s	0	3.16e+13	1	0	Ma[t]
1383	ms	millisecond	T	Y	prefixed	s	0	0.001	1	0	ms
1384	na	nanojulian-year	T	N	prefixed	s	0	0.0315576	1	0	na
1385	ns	nanosecond	T	Y	prefixed	s	0	1e-09	1	0	ns
1386	ps	picosecond	T	Y	prefixed	s	0	1e-12	1	0	ps
1387	Ta[t]	million million tropical-year	T	N	prefixed	s	0	3.16e+19	1	0	Ta[t]
1388	us	microsecond	T	Y	prefixed	s	0	1e-06	1	0	us
1389	s/m	second per metre	T/L	Y	derived	IS-BASE	0	1	1	0	s/m
1390	0.001 h/ft	hour per thousand foot	T/L	N	derived	s/m	0	3600	304.8	0	0.001 h/ft
1391	h/km	hour per kilometre	T/L	Y	derived	s/m	0	3.6	1	0	h/km
1392	min/ft	minute per foot	T/L	N	derived	s/m	0	60	0.3048	0	min/ft
1393	min/m	minute per metre	T/L	Y	derived	s/m	0	60	1	0	min/m
1394	ms/cm	millisecond per centimetre	T/L	Y	derived	s/m	0	0.1	1	0	ms/cm
1395	ms/ft	millisecond per foot	T/L	N	derived	s/m	0	0.001	0.3048	0	ms/ft
1396	ms/in	millisecond per inch	T/L	N	derived	s/m	0	0.001	0.0254	0	ms/in
1397	ms/m	millisecond per metre	T/L	Y	derived	s/m	0	0.001	1	0	ms/m
1398	ns/ft	nanosecond per foot	T/L	N	derived	s/m	0	1e-09	0.3048	0	ns/ft
1399	ns/m	nanosecond per metre	T/L	Y	derived	s/m	0	1e-09	1	0	ns/m
1400	s/cm	second per centimetre	T/L	Y	derived	s/m	0	100	1	0	s/cm
1401	s/ft	second per foot	T/L	N	derived	s/m	0	1	0.3048	0	s/ft
1402	s/in	second per inch	T/L	N	derived	s/m	0	1	0.0254	0	s/in
1403	us/ft	microsecond per foot	T/L	N	derived	s/m	0	1e-06	0.3048	0	us/ft
1404	us/in	microsecond per inch	T/L	N	derived	s/m	0	1e-06	0.0254	0	us/in
1405	us/m	microsecond per metre	T/L	Y	derived	s/m	0	1e-06	1	0	us/m
1406	s/m3	second per cubic metre	T/L3	Y	derived	IS-BASE	0	1	1	0	s/m3
1407	0.001 d/ft3	day per thousand cubic foot	T/L3	N	derived	s/m3	0	86400	28.316847	0	0.001 d/ft3
1408	d/bbl	day per barrel	T/L3	N	derived	s/m3	0	86400	0.1589873	0	d/bbl
1409	d/ft3	day per cubic foot	T/L3	N	derived	s/m3	0	86400	0.028316846	0	d/ft3
1410	d/m3	day per cubic metre	T/L3	Y	derived	s/m3	0	86400	1	0	d/m3
1411	h/ft3	hour per cubic foot	T/L3	N	derived	s/m3	0	3600	0.028316846	0	h/ft3
1412	h/m3	hour per cubic metre	T/L3	Y	derived	s/m3	0	3600	1	0	h/m3
1413	s/ft3	second per cubic foot	T/L3	N	derived	s/m3	0	1	0.028316846	0	s/ft3
1414	s/L	second per litre	T/L3	Y	derived	s/m3	0	1000	1	0	s/L
1415	s/qt[UK]	second per UK quart	T/L3	N	derived	s/m3	0	1	0.00114	0	s/qt[UK]
1416	s/qt[US]	second per US quart	T/L3	N	derived	s/m3	0	1	0.000946	0	s/qt[US],s/qt
1417	s/kg	second per kilogram	T/M	Y	derived	IS-BASE	0	1	1	0	s/kg
1418	kg/J	kilogram per joule	T2/L2	Y	derived	IS-BASE	0	1	1	0	kg/J
1419	kg/(kW.h)	kilogram per kilowatt hour	T2/L2	Y	derived	kg/J	0	1	3.6e+06	0	kg/(kW.h)
1420	kg/MJ	kilogram per megajoule	T2/L2	Y	derived	kg/J	0	1e-06	1	0	kg/MJ
1421	lbm/(hp.h)	pound-mass per horsepower hour	T2/L2	N	derived	kg/J	0	0.45359236	2.68e+06	0	lbm/(hp.h)
1422	mg/J	milligram per joule	T2/L2	Y	derived	kg/J	0	1e-06	1	0	mg/J
1423	1/lbf	per pound-force	T2/LM	N	derived	1/N	0	1	4.4482217	0	1/lbf
1424	1/N	per Newton	T2/LM	Y	derived	IS-BASE	0	1	1	0	1/N
1425	B	bel	none	Y	atom-allowed	IS-BASE	0	1	1	0	B
1426	dAPI	API gravity unit	none	Y	atom-allowed	IS-BASE	0	1	1	0	dAPI
1427	gAPI	API gamma ray unit	none	Y	atom-allowed	IS-BASE	0	1	1	0	gAPI,gamma
1428	nAPI	API neutron unit	none	Y	atom-allowed	IS-BASE	0	1	1	0	nAPI
1429	O	octave	none	Y	atom-allowed	IS-BASE	0	1	1	0	O
1430	dB.mW	decibel milliwatt	none	Y	derived	B.W	0	0.0001	1	0	dB.mW
1431	dB.MW	decibel megawatt	none	Y	derived	B.W	0	100000	1	0	dB.MW
1432	dB.W	decibel watt	none	Y	derived	B.W	0	0.1	1	0	dB.W
1433	dB/ft	decibel per foot	none	N	derived	B/m	0	0.1	0.3048	0	dB/ft
1434	dB/km	decibel per kilometre	none	Y	derived	B/m	0	0.0001	1	0	dB/km
1435	dB/m	decibel per metre	none	Y	derived	B/m	0	0.1	1	0	dB/m
1436	dB/O	decibel per octave	none	Y	derived	B/O	0	0.1	1	0	dB/O
1437	B.W	bel watt	none	Y	derived	IS-BASE	0	1	1	0	B.W
1438	B/m	bel per metre	none	Y	derived	IS-BASE	0	1	1	0	B/m
1439	B/O	bel per octave	none	Y	derived	IS-BASE	0	1	1	0	B/O
1440	V/B	volt per bel	none	Y	derived	IS-BASE	0	1	1	0	V/B
1441	V/dB	volt per decibel	none	Y	derived	V/B	0	10	1	0	V/dB
1442	dB	decibel	none	Y	prefixed	B	0	0.1	1	0	dB
1443	SPM	Strokes  per radian	1	N	derived	IS-BASE	0	0.1	1	0	SPM
1444	N.m/rad	newton metre per radian	L2M/AT2	Y	derived	IS-BASE	0	0.1	1	0	N.m/rad,NÂ·m/rad
1445	N.m.s/rad	newton metre second per radian	L2M/AT	Y	derived	IS-BASE	0	0.1	1	0	N.m.s/rad,NÂ·mÂ·s/rad
1446	lbf.in/rad	pound-force inch per radian	L2M/AT2	N	derived	N.m/rad	0	0.11298483	1	0	lbf.in/rad,lbfÂ·in/rad
1447	lbf.in.s/rad	pound-force inch second per radian	L2M/AT	N	derived	N.m.s/rad	0	0.11298483	1	0	lbf.in.s/rad,lbfÂ·inÂ·s/rad
1448	1000 lbf	thousand pound-force	LM/T2	N	prefixed	N	0	4450	1	0	1000 lbf
1449	c/min	revolution per minute	A/T	N	atom	rad/s	0	6.283	60	0	c/min
1450	psia	pound-force per square inch	M/LT2	N	atom-special	Pa	0	4.4482217	0.000645	0	psia
1451	gpm	US gallon per minute	L3/T	N	derived	m3/s	0	0.00379	60	0	gpm
1452	unitless	unitless	1	N	atom	IS-BASE	0	1	1	0	unitless
1453	DateTime	DateTime	1	N	atom	IS-BASE	0	1	1	0	DateTime
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.user_roles (role_name, username) FROM stdin;
systemadmin	SuperAdmin
rigadmin	RigAdmin
guest	Guest
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sigmastream
--

COPY public.users (username, password, fname, sname, disp_name, company, mobile, email, apikey, delete_status, active_status) FROM stdin;
SuperAdmin	U2lnbWFTdHJlYW0jMQ==	SuperAdministrator	SuperAdministrator	SuperAdmin	SigmaStream	7829856785	superadmin@sigmastream.com	4e00734c650ed7821e2cebad9046d21a	N	Y
RigAdmin	U2lnbWFTdHJlYW0jMQ==	rigadmin	rigadmin	RigAdmin	SigmaStream	7829856785	rigadmin@sigmastream.com	8476509c72164674802e5471f3591435	N	Y
Guest	Z3Vlc3RAMjAyMA==	Guest	Guest	Guest	SigmaStream	7829856785	guest@sigmastream.com	c25b9839fc5c4b84a802042ebd4ff355	N	Y
yellowhammer	null	yellowhammer	yellowhammer	yellowhammer	null	null	null	eWVsbG93aGFtbWVyLnNpZ21hc3RyZWFt	N	Y
BlueCardinal	Qmx1ZUNhcmRpbmFs	BlueCardinal	BlueCardinal	BlueCardinal	BlueCardinal	1234567890	bluecardinal@sigmastream.com	0a10cf14a3a44bec869e41e4ef9a07cd	N	Y
RedCanary	UmVkQ2FuYXJ5	RedCanary	RedCanary	RedCanary	SigmaStream	1234567890	redcanary@sigmastream.com	0502561e76264fc097ac9f3a219f8a20	N	Y
HummingBird	SHVtbWluZ0JpcmQ=	HummingBird	HummingBird	HummingBird	SigmaStream	1234567890	hummingbird@sigmastream.com	a0bed448902440b1a0f8d8814e2a9ad3	N	Y
YHCli	WUhDbGk=	YHCli	YHCli	YHCli	SigmaStream	1234567890	yhcli@sigmastream.com	05f0b05caaba42ca88556d5262c7f7ad	N	Y
PythonClient	U2lnbWFTdHJlYW0jMQ==	PythonClient	PythonClient	PythonClient	SigmaStream	1234567890	pythonclient@sigmastream.com	4643691ff3664ba5be8cdd865c7fc01e	N	Y
WellViewAgent	U2lnbWFTdHJlYW0jMQ==	WellViewAgent	WellViewAgent	WellViewAgent	SigmaStream	1234567890	wellview@sigmastream.com	613db00579354234998bf4f3a092e73e	N	Y
\.


--
-- Name: adaptor_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.adaptor_metadata_id_seq', 1, false);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.assets_id_seq', 4, true);


--
-- Name: attributerules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.attributerules_id_seq', 2950, true);


--
-- Name: attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.attributes_id_seq', 26, true);


--
-- Name: attributevalues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.attributevalues_id_seq', 1, false);


--
-- Name: bha_run_bharunid_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.bha_run_bharunid_seq', 5, true);


--
-- Name: bharun_feed_bharun_feed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.bharun_feed_bharun_feed_id_seq', 4, true);


--
-- Name: channel_identifier_channelidentifierid_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.channel_identifier_channelidentifierid_seq', 684, true);


--
-- Name: chunktransfer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.chunktransfer_id_seq', 1, false);


--
-- Name: config_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.config_config_id_seq', 1, false);


--
-- Name: crs_crs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.crs_crs_id_seq', 441, true);


--
-- Name: entity_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.entity_activity_id_seq', 1, false);


--
-- Name: entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.entity_id_seq', 4, true);


--
-- Name: entity_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.entity_metadata_id_seq', 11, true);


--
-- Name: feed_config_feed_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.feed_config_feed_config_id_seq', 60, true);


--
-- Name: feed_feed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.feed_feed_id_seq', 3, true);


--
-- Name: jobrun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.jobrun_id_seq', 21, true);


--
-- Name: profile_details_profile_detailsid_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.profile_details_profile_detailsid_seq', 1, false);


--
-- Name: profile_profileid_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.profile_profileid_seq', 1, false);


--
-- Name: rig_rigid_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.rig_rigid_seq', 4, true);


--
-- Name: section_sectionid_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.section_sectionid_seq', 5, true);


--
-- Name: standard_mnemonic_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.standard_mnemonic_group_id_seq', 1, true);


--
-- Name: standard_mnemonic_validation_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.standard_mnemonic_validation_rule_id_seq', 1, false);


--
-- Name: standard_mnemonics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.standard_mnemonics_id_seq', 5, true);


--
-- Name: subasset_standard_mnemonic_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.subasset_standard_mnemonic_groups_id_seq', 3, true);


--
-- Name: subasset_standard_mnemonics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.subasset_standard_mnemonics_id_seq', 10, true);


--
-- Name: subassets_wellboreid_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.subassets_wellboreid_seq', 11, true);


--
-- Name: subscription_channel_sub_channel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.subscription_channel_sub_channel_id_seq', 25, true);


--
-- Name: subscription_sub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.subscription_sub_id_seq', 5, true);


--
-- Name: unit_of_measurement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigmastream
--

SELECT pg_catalog.setval('public.unit_of_measurement_id_seq', 1453, true);


--
-- Name: adaptor_metadata adaptor_metadata_name_key; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.adaptor_metadata
    ADD CONSTRAINT adaptor_metadata_name_key UNIQUE (name);


--
-- Name: adaptor_metadata adaptor_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.adaptor_metadata
    ADD CONSTRAINT adaptor_metadata_pkey PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: attributerules attributerules_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.attributerules
    ADD CONSTRAINT attributerules_pkey PRIMARY KEY (id);


--
-- Name: attributes attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.attributes
    ADD CONSTRAINT attributes_pkey PRIMARY KEY (id);


--
-- Name: attributevalues attributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.attributevalues
    ADD CONSTRAINT attributevalues_pkey PRIMARY KEY (id);


--
-- Name: bha_run bha_run_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.bha_run
    ADD CONSTRAINT bha_run_pkey PRIMARY KEY (bharunid);


--
-- Name: bharun_feed bharun_feed_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.bharun_feed
    ADD CONSTRAINT bharun_feed_pkey PRIMARY KEY (bharun_feed_id);


--
-- Name: channel_identifier channel_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.channel_identifier
    ADD CONSTRAINT channel_identifier_pkey PRIMARY KEY (channelidentifierid);


--
-- Name: channel_identifier channel_identifier_shortmnemonic_key; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.channel_identifier
    ADD CONSTRAINT channel_identifier_shortmnemonic_key UNIQUE (shortmnemonic);


--
-- Name: chunktransfer chunktransfer_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.chunktransfer
    ADD CONSTRAINT chunktransfer_pkey PRIMARY KEY (id);


--
-- Name: config config_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.config
    ADD CONSTRAINT config_pkey PRIMARY KEY (config_id);


--
-- Name: crs crs_crs_name_key; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.crs
    ADD CONSTRAINT crs_crs_name_key UNIQUE (crs_name);


--
-- Name: crs crs_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.crs
    ADD CONSTRAINT crs_pkey PRIMARY KEY (crs_id);


--
-- Name: entity_activity entity_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.entity_activity
    ADD CONSTRAINT entity_activity_pkey PRIMARY KEY (id);


--
-- Name: entity_metadata entity_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.entity_metadata
    ADD CONSTRAINT entity_metadata_pkey PRIMARY KEY (id);


--
-- Name: entity entity_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_pkey PRIMARY KEY (id);


--
-- Name: feed_config feed_config_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.feed_config
    ADD CONSTRAINT feed_config_pkey PRIMARY KEY (feed_config_id);


--
-- Name: feed feed_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.feed
    ADD CONSTRAINT feed_pkey PRIMARY KEY (feed_id);


--
-- Name: jobrun jobrun_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.jobrun
    ADD CONSTRAINT jobrun_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (uidwell, uidwellbore, uid);


--
-- Name: logcurve logcurve_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.logcurve
    ADD CONSTRAINT logcurve_pkey PRIMARY KEY (uid);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permission_nm);


--
-- Name: profile_details profile_details_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.profile_details
    ADD CONSTRAINT profile_details_pkey PRIMARY KEY (profile_detailsid);


--
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (profileid);


--
-- Name: appconfig propertykeyconstraint; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.appconfig
    ADD CONSTRAINT propertykeyconstraint UNIQUE (propertykey);


--
-- Name: rig rig_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.rig
    ADD CONSTRAINT rig_pkey PRIMARY KEY (rigid);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_name);


--
-- Name: section section_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (sectionid);


--
-- Name: standard_mnemonic_group standard_mnemonic_group_groupname_key; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.standard_mnemonic_group
    ADD CONSTRAINT standard_mnemonic_group_groupname_key UNIQUE (groupname);


--
-- Name: standard_mnemonic_group standard_mnemonic_group_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.standard_mnemonic_group
    ADD CONSTRAINT standard_mnemonic_group_pkey PRIMARY KEY (id);


--
-- Name: standard_mnemonic_validation_rule standard_mnemonic_validation_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.standard_mnemonic_validation_rule
    ADD CONSTRAINT standard_mnemonic_validation_rule_pkey PRIMARY KEY (id);


--
-- Name: standard_mnemonics standard_mnemonics_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.standard_mnemonics
    ADD CONSTRAINT standard_mnemonics_pkey PRIMARY KEY (id);


--
-- Name: standard_mnemonics standard_mnemonics_standard_mnemonic_group_id_mnemonicname_key; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.standard_mnemonics
    ADD CONSTRAINT standard_mnemonics_standard_mnemonic_group_id_mnemonicname_key UNIQUE (standard_mnemonic_group_id, mnemonicname);


--
-- Name: subasset_standard_mnemonic_groups subasset_standard_mnemonic_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subasset_standard_mnemonic_groups
    ADD CONSTRAINT subasset_standard_mnemonic_groups_pkey PRIMARY KEY (id);


--
-- Name: subasset_standard_mnemonics subasset_standard_mnemonics_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subasset_standard_mnemonics
    ADD CONSTRAINT subasset_standard_mnemonics_pkey PRIMARY KEY (id);


--
-- Name: subassets subassets_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subassets
    ADD CONSTRAINT subassets_pkey PRIMARY KEY (wellboreid);


--
-- Name: subscription_channel subscription_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subscription_channel
    ADD CONSTRAINT subscription_channel_pkey PRIMARY KEY (sub_channel_id);


--
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (sub_id);


--
-- Name: entity_metadata unique_metadata; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.entity_metadata
    ADD CONSTRAINT unique_metadata UNIQUE (entity_id, entity_name, name);


--
-- Name: unit_of_measurement unit_of_measurement_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.unit_of_measurement
    ADD CONSTRAINT unit_of_measurement_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: entity_activity fk_subasset; Type: FK CONSTRAINT; Schema: public; Owner: sigmastream
--

ALTER TABLE ONLY public.entity_activity
    ADD CONSTRAINT fk_subasset FOREIGN KEY (wellboreid) REFERENCES public.subassets(wellboreid) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

