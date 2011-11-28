--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_message; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_message (
    id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL
);


ALTER TABLE public.auth_message OWNER TO postgres;

--
-- Name: auth_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_message_id_seq OWNER TO postgres;

--
-- Name: auth_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_message_id_seq OWNED BY auth_message.id;


--
-- Name: auth_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_message_id_seq', 1, false);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_permission_id_seq', 151, true);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    password character varying(128) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superuser boolean NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_id_seq', 4, true);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 186, true);


--
-- Name: common_burial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_burial (
    obid integer,
    uuid character varying(36) NOT NULL,
    passportid character varying(128),
    date_passport date,
    date_burried date,
    date_discovered date,
    burial_type_id integer,
    military_conflict_id integer,
    date_memorial date,
    date_gosznak date,
    photo character varying(100),
    scheme character varying(100),
    creator_id integer,
    date_of_creation timestamp with time zone NOT NULL,
    info text,
    is_trash boolean DEFAULT false NOT NULL,
    oblocationid integer,
    state_id integer,
    date_closed date,
    date_of_update timestamp with time zone NOT NULL,
    date_gosznak_no_month boolean NOT NULL,
    date_gosznak_no_day boolean NOT NULL,
    names_count smallint NOT NULL,
    date_burried_no_month boolean NOT NULL,
    date_burried_no_day boolean NOT NULL,
    date_discovered_no_month boolean NOT NULL,
    date_discovered_no_day boolean NOT NULL,
    date_memorial_no_month boolean NOT NULL,
    date_memorial_no_day boolean NOT NULL,
    CONSTRAINT common_burial_names_count_check CHECK ((names_count >= 0))
);


ALTER TABLE public.common_burial OWNER TO postgres;

--
-- Name: common_burialcategory; Type: TABLE; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE TABLE common_burialcategory (
    id integer NOT NULL,
    category_id integer NOT NULL,
    burial_id character varying(36) NOT NULL,
    known integer DEFAULT 0 NOT NULL,
    unknown integer DEFAULT 0 NOT NULL,
    updated timestamp with time zone NOT NULL,
    CONSTRAINT common_burialcategory_known_check CHECK ((known >= 0)),
    CONSTRAINT common_burialcategory_unknown_check CHECK ((unknown >= 0))
);


ALTER TABLE public.common_burialcategory OWNER TO ilvar;

--
-- Name: common_burialcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: ilvar
--

CREATE SEQUENCE common_burialcategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_burialcategory_id_seq OWNER TO ilvar;

--
-- Name: common_burialcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ilvar
--

ALTER SEQUENCE common_burialcategory_id_seq OWNED BY common_burialcategory.id;


--
-- Name: common_burialcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ilvar
--

SELECT pg_catalog.setval('common_burialcategory_id_seq', 43, true);


--
-- Name: common_burialeditcause; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_burialeditcause (
    id integer NOT NULL,
    burial_id character varying(36) NOT NULL,
    name character varying(100) NOT NULL,
    number character varying(100) NOT NULL,
    date date NOT NULL,
    date_edit timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.common_burialeditcause OWNER TO postgres;

--
-- Name: common_burialeditcause_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_burialeditcause_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_burialeditcause_id_seq OWNER TO postgres;

--
-- Name: common_burialeditcause_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_burialeditcause_id_seq OWNED BY common_burialeditcause.id;


--
-- Name: common_burialeditcause_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_burialeditcause_id_seq', 1, false);


--
-- Name: common_burialinformationlinks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_burialinformationlinks (
    id integer NOT NULL,
    burial_id character varying(36) NOT NULL,
    link character varying(100) NOT NULL
);


ALTER TABLE public.common_burialinformationlinks OWNER TO postgres;

--
-- Name: common_burialinformationlinks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_burialinformationlinks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_burialinformationlinks_id_seq OWNER TO postgres;

--
-- Name: common_burialinformationlinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_burialinformationlinks_id_seq OWNED BY common_burialinformationlinks.id;


--
-- Name: common_burialinformationlinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_burialinformationlinks_id_seq', 1, false);


--
-- Name: common_burialpictures; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_burialpictures (
    id integer NOT NULL,
    burial_id character varying(36) NOT NULL,
    photo character varying(100),
    comment text
);


ALTER TABLE public.common_burialpictures OWNER TO postgres;

--
-- Name: common_burialpictures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_burialpictures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_burialpictures_id_seq OWNER TO postgres;

--
-- Name: common_burialpictures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_burialpictures_id_seq OWNED BY common_burialpictures.id;


--
-- Name: common_burialpictures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_burialpictures_id_seq', 1, false);


--
-- Name: common_burialtype; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_burialtype (
    id integer NOT NULL,
    obid integer,
    name character varying(100) NOT NULL,
    brief character varying(100)
);


ALTER TABLE public.common_burialtype OWNER TO postgres;

--
-- Name: common_burialtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_burialtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_burialtype_id_seq OWNER TO postgres;

--
-- Name: common_burialtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_burialtype_id_seq OWNED BY common_burialtype.id;


--
-- Name: common_burialtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_burialtype_id_seq', 7, true);


--
-- Name: common_closedburial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_closedburial (
    burial_from_id character varying(36) NOT NULL,
    date date NOT NULL,
    cause_id integer NOT NULL,
    burial_to_id character varying(36) NOT NULL,
    document character varying(100)
);


ALTER TABLE public.common_closedburial OWNER TO postgres;

--
-- Name: common_closurecause; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_closurecause (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_closurecause OWNER TO postgres;

--
-- Name: common_closurecause_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_closurecause_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_closurecause_id_seq OWNER TO postgres;

--
-- Name: common_closurecause_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_closurecause_id_seq OWNED BY common_closurecause.id;


--
-- Name: common_closurecause_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_closurecause_id_seq', 2, true);


--
-- Name: common_comissariat; Type: TABLE; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE TABLE common_comissariat (
    id integer NOT NULL,
    obid integer,
    country_id integer,
    region_id integer,
    city_id integer,
    info text,
    gps_x double precision,
    gps_y double precision,
    gps_z double precision,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_comissariat OWNER TO ilvar;

--
-- Name: common_comissariat_id_seq; Type: SEQUENCE; Schema: public; Owner: ilvar
--

CREATE SEQUENCE common_comissariat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_comissariat_id_seq OWNER TO ilvar;

--
-- Name: common_comissariat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ilvar
--

ALTER SEQUENCE common_comissariat_id_seq OWNED BY common_comissariat.id;


--
-- Name: common_comissariat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ilvar
--

SELECT pg_catalog.setval('common_comissariat_id_seq', 1, false);


--
-- Name: common_deadmancategory; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_deadmancategory (
    id integer NOT NULL,
    obid integer,
    name character varying(100) NOT NULL,
    brief character varying(100),
    ordering smallint NOT NULL,
    CONSTRAINT common_deadmancategory_ordering_check CHECK ((ordering >= 0))
);


ALTER TABLE public.common_deadmancategory OWNER TO postgres;

--
-- Name: common_deadmancategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_deadmancategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_deadmancategory_id_seq OWNER TO postgres;

--
-- Name: common_deadmancategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_deadmancategory_id_seq OWNED BY common_deadmancategory.id;


--
-- Name: common_deadmancategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_deadmancategory_id_seq', 4, true);


--
-- Name: common_deathcause; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_deathcause (
    id integer NOT NULL,
    obid integer,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_deathcause OWNER TO postgres;

--
-- Name: common_deathcause_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_deathcause_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_deathcause_id_seq OWNER TO postgres;

--
-- Name: common_deathcause_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_deathcause_id_seq OWNED BY common_deathcause.id;


--
-- Name: common_deathcause_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_deathcause_id_seq', 8, true);


--
-- Name: common_documentsplace; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_documentsplace (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_documentsplace OWNER TO postgres;

--
-- Name: common_documentsplace_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_documentsplace_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_documentsplace_id_seq OWNER TO postgres;

--
-- Name: common_documentsplace_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_documentsplace_id_seq OWNED BY common_documentsplace.id;


--
-- Name: common_documentsplace_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_documentsplace_id_seq', 18, true);


--
-- Name: common_geocity; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_geocity (
    id integer NOT NULL,
    obid integer,
    region_id integer NOT NULL,
    name character varying(36) NOT NULL
);


ALTER TABLE public.common_geocity OWNER TO postgres;

--
-- Name: common_geocity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_geocity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_geocity_id_seq OWNER TO postgres;

--
-- Name: common_geocity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_geocity_id_seq OWNED BY common_geocity.id;


--
-- Name: common_geocity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_geocity_id_seq', 2418, true);


--
-- Name: common_geocountry; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_geocountry (
    id integer NOT NULL,
    obid integer,
    name character varying(36) NOT NULL
);


ALTER TABLE public.common_geocountry OWNER TO postgres;

--
-- Name: common_geocountry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_geocountry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_geocountry_id_seq OWNER TO postgres;

--
-- Name: common_geocountry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_geocountry_id_seq OWNED BY common_geocountry.id;


--
-- Name: common_geocountry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_geocountry_id_seq', 35, true);


--
-- Name: common_georegion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_georegion (
    id integer NOT NULL,
    obid integer,
    country_id integer NOT NULL,
    name character varying(36) NOT NULL
);


ALTER TABLE public.common_georegion OWNER TO postgres;

--
-- Name: common_georegion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_georegion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_georegion_id_seq OWNER TO postgres;

--
-- Name: common_georegion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_georegion_id_seq OWNED BY common_georegion.id;


--
-- Name: common_georegion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_georegion_id_seq', 355, true);


--
-- Name: common_geostreet; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_geostreet (
    id integer NOT NULL,
    city_id integer NOT NULL,
    name character varying(99) NOT NULL
);


ALTER TABLE public.common_geostreet OWNER TO postgres;

--
-- Name: common_geostreet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_geostreet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_geostreet_id_seq OWNER TO postgres;

--
-- Name: common_geostreet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_geostreet_id_seq OWNED BY common_geostreet.id;


--
-- Name: common_geostreet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_geostreet_id_seq', 1, false);


--
-- Name: common_informationsource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_informationsource (
    id integer NOT NULL,
    obid integer,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_informationsource OWNER TO postgres;

--
-- Name: common_informationsource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_informationsource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_informationsource_id_seq OWNER TO postgres;

--
-- Name: common_informationsource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_informationsource_id_seq OWNED BY common_informationsource.id;


--
-- Name: common_informationsource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_informationsource_id_seq', 14, true);


--
-- Name: common_locationbirth; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_locationbirth (
    obid integer,
    country_id integer,
    region_id integer,
    city_id integer,
    info text,
    person_id character varying(36) NOT NULL,
    gps_x double precision,
    gps_y double precision,
    gps_z double precision
);


ALTER TABLE public.common_locationbirth OWNER TO postgres;

--
-- Name: common_locationburial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_locationburial (
    obid integer,
    country_id integer,
    region_id integer,
    city_id integer,
    info text,
    burial_id character varying(36) NOT NULL,
    gps_x double precision,
    gps_y double precision,
    gps_z double precision
);


ALTER TABLE public.common_locationburial OWNER TO postgres;

--
-- Name: common_memorialstate; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_memorialstate (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_memorialstate OWNER TO postgres;

--
-- Name: common_memorialstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_memorialstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_memorialstate_id_seq OWNER TO postgres;

--
-- Name: common_memorialstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_memorialstate_id_seq OWNED BY common_memorialstate.id;


--
-- Name: common_memorialstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_memorialstate_id_seq', 1, false);


--
-- Name: common_militaryconflict; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_militaryconflict (
    id integer NOT NULL,
    obid integer,
    name character varying(100) NOT NULL,
    brief character varying(100),
    comment text,
    type_id integer
);


ALTER TABLE public.common_militaryconflict OWNER TO postgres;

--
-- Name: common_militaryconflict_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_militaryconflict_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_militaryconflict_id_seq OWNER TO postgres;

--
-- Name: common_militaryconflict_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_militaryconflict_id_seq OWNED BY common_militaryconflict.id;


--
-- Name: common_militaryconflict_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_militaryconflict_id_seq', 7, true);


--
-- Name: common_militaryconflicttype; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_militaryconflicttype (
    id integer NOT NULL,
    "full" character varying(100) NOT NULL,
    brief character varying(100) NOT NULL
);


ALTER TABLE public.common_militaryconflicttype OWNER TO postgres;

--
-- Name: common_militaryconflicttype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_militaryconflicttype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_militaryconflicttype_id_seq OWNER TO postgres;

--
-- Name: common_militaryconflicttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_militaryconflicttype_id_seq OWNED BY common_militaryconflicttype.id;


--
-- Name: common_militaryconflicttype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_militaryconflicttype_id_seq', 1, true);


--
-- Name: common_militaryunit; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_militaryunit (
    id integer NOT NULL,
    obid integer,
    country_id integer,
    region_id integer,
    city_id integer,
    info text,
    name character varying(100) NOT NULL,
    gps_x double precision,
    gps_y double precision,
    gps_z double precision
);


ALTER TABLE public.common_militaryunit OWNER TO postgres;

--
-- Name: common_militaryunit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_militaryunit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_militaryunit_id_seq OWNER TO postgres;

--
-- Name: common_militaryunit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_militaryunit_id_seq OWNED BY common_militaryunit.id;


--
-- Name: common_militaryunit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_militaryunit_id_seq', 602, true);


--
-- Name: common_nationality; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_nationality (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_nationality OWNER TO postgres;

--
-- Name: common_nationality_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_nationality_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_nationality_id_seq OWNER TO postgres;

--
-- Name: common_nationality_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_nationality_id_seq OWNED BY common_nationality.id;


--
-- Name: common_nationality_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_nationality_id_seq', 1, false);


--
-- Name: common_person; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_person (
    obid integer,
    uuid character varying(36) NOT NULL,
    last_name character varying(128) NOT NULL,
    first_name character varying(30) NOT NULL,
    patronymic character varying(30) NOT NULL,
    birth_date date,
    death_date date,
    death_cause_id integer,
    nationality_id integer,
    deadman_category_id integer,
    documents_place_id integer,
    information_source_id integer,
    creator_id integer,
    date_of_creation timestamp with time zone NOT NULL,
    is_trash boolean DEFAULT false NOT NULL,
    oblocationid integer,
    info text,
    burial_id character varying(36),
    birth_date_no_month boolean NOT NULL,
    birth_date_no_day boolean NOT NULL,
    death_date_no_month boolean NOT NULL,
    death_date_no_day boolean NOT NULL,
    mia boolean NOT NULL,
    outside_rb boolean NOT NULL
);


ALTER TABLE public.common_person OWNER TO postgres;

--
-- Name: common_person_closed_burials; Type: TABLE; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE TABLE common_person_closed_burials (
    id integer NOT NULL,
    person_id character varying(36) NOT NULL,
    burial_id character varying(36) NOT NULL
);


ALTER TABLE public.common_person_closed_burials OWNER TO ilvar;

--
-- Name: common_person_closed_burials_id_seq; Type: SEQUENCE; Schema: public; Owner: ilvar
--

CREATE SEQUENCE common_person_closed_burials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_person_closed_burials_id_seq OWNER TO ilvar;

--
-- Name: common_person_closed_burials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ilvar
--

ALTER SEQUENCE common_person_closed_burials_id_seq OWNED BY common_person_closed_burials.id;


--
-- Name: common_person_closed_burials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ilvar
--

SELECT pg_catalog.setval('common_person_closed_burials_id_seq', 226, true);


--
-- Name: common_personcall; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_personcall (
    unit_id integer,
    date date,
    person_id character varying(36) NOT NULL
);


ALTER TABLE public.common_personcall OWNER TO postgres;

--
-- Name: common_personduty; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_personduty (
    unit_id integer,
    rank_id integer,
    post_id integer,
    person_id character varying(36) NOT NULL
);


ALTER TABLE public.common_personduty OWNER TO postgres;

--
-- Name: common_personeditcause; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_personeditcause (
    id integer NOT NULL,
    person_id character varying(36) NOT NULL,
    name character varying(100) NOT NULL,
    number character varying(100) NOT NULL,
    date date NOT NULL,
    date_edit timestamp with time zone NOT NULL,
    file character varying(100)
);


ALTER TABLE public.common_personeditcause OWNER TO postgres;

--
-- Name: common_personeditcause_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_personeditcause_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_personeditcause_id_seq OWNER TO postgres;

--
-- Name: common_personeditcause_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_personeditcause_id_seq OWNED BY common_personeditcause.id;


--
-- Name: common_personeditcause_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_personeditcause_id_seq', 2, true);


--
-- Name: common_personinformationlinks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_personinformationlinks (
    id integer NOT NULL,
    person_id character varying(36) NOT NULL,
    link character varying(100) NOT NULL
);


ALTER TABLE public.common_personinformationlinks OWNER TO postgres;

--
-- Name: common_personinformationlinks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_personinformationlinks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_personinformationlinks_id_seq OWNER TO postgres;

--
-- Name: common_personinformationlinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_personinformationlinks_id_seq OWNED BY common_personinformationlinks.id;


--
-- Name: common_personinformationlinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_personinformationlinks_id_seq', 1, false);


--
-- Name: common_post; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_post (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_post OWNER TO postgres;

--
-- Name: common_post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_post_id_seq OWNER TO postgres;

--
-- Name: common_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_post_id_seq OWNED BY common_post.id;


--
-- Name: common_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_post_id_seq', 98, true);


--
-- Name: common_rank; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_rank (
    id integer NOT NULL,
    obid integer,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_rank OWNER TO postgres;

--
-- Name: common_rank_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_rank_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_rank_id_seq OWNER TO postgres;

--
-- Name: common_rank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_rank_id_seq OWNED BY common_rank.id;


--
-- Name: common_rank_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_rank_id_seq', 138, true);


--
-- Name: common_searchobject; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_searchobject (
    id integer NOT NULL,
    number character varying(100) NOT NULL,
    date date,
    inv_number character varying(100) NOT NULL,
    burial_id character varying(36) NOT NULL,
    link character varying(100) NOT NULL
);


ALTER TABLE public.common_searchobject OWNER TO postgres;

--
-- Name: common_searchobject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE common_searchobject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.common_searchobject_id_seq OWNER TO postgres;

--
-- Name: common_searchobject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE common_searchobject_id_seq OWNED BY common_searchobject.id;


--
-- Name: common_searchobject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('common_searchobject_id_seq', 1, false);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 56, true);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_content_type_id_seq', 50, true);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Name: easy_thumbnails_source; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE easy_thumbnails_source (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone DEFAULT '2009-11-22 14:16:23.523494-05'::timestamp with time zone NOT NULL,
    storage_hash character varying(40) NOT NULL
);


ALTER TABLE public.easy_thumbnails_source OWNER TO postgres;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE easy_thumbnails_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_source_id_seq OWNER TO postgres;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE easy_thumbnails_source_id_seq OWNED BY easy_thumbnails_source.id;


--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('easy_thumbnails_source_id_seq', 1, false);


--
-- Name: easy_thumbnails_thumbnail; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE easy_thumbnails_thumbnail (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone DEFAULT '2009-11-22 14:16:23.523494-05'::timestamp with time zone NOT NULL,
    source_id integer NOT NULL,
    storage_hash character varying(40) NOT NULL
);


ALTER TABLE public.easy_thumbnails_thumbnail OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE easy_thumbnails_thumbnail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_thumbnail_id_seq OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE easy_thumbnails_thumbnail_id_seq OWNED BY easy_thumbnails_thumbnail.id;


--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('easy_thumbnails_thumbnail_id_seq', 1, false);


--
-- Name: sentry_filtervalue; Type: TABLE; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE TABLE sentry_filtervalue (
    id integer NOT NULL,
    key character varying(32) NOT NULL,
    value character varying(200) NOT NULL
);


ALTER TABLE public.sentry_filtervalue OWNER TO ilvar;

--
-- Name: sentry_filtervalue_id_seq; Type: SEQUENCE; Schema: public; Owner: ilvar
--

CREATE SEQUENCE sentry_filtervalue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sentry_filtervalue_id_seq OWNER TO ilvar;

--
-- Name: sentry_filtervalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ilvar
--

ALTER SEQUENCE sentry_filtervalue_id_seq OWNED BY sentry_filtervalue.id;


--
-- Name: sentry_filtervalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ilvar
--

SELECT pg_catalog.setval('sentry_filtervalue_id_seq', 3, true);


--
-- Name: sentry_groupedmessage; Type: TABLE; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE TABLE sentry_groupedmessage (
    id integer NOT NULL,
    logger character varying(64) DEFAULT 'root'::character varying NOT NULL,
    class_name character varying(128),
    level integer DEFAULT 40 NOT NULL,
    message text NOT NULL,
    traceback text,
    view character varying(200),
    checksum character varying(32) NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    times_seen integer DEFAULT 1 NOT NULL,
    last_seen timestamp with time zone DEFAULT '2011-10-11 12:51:01.278358-05'::timestamp with time zone NOT NULL,
    first_seen timestamp with time zone DEFAULT '2011-10-11 12:51:01.279519-05'::timestamp with time zone NOT NULL,
    data text,
    score integer NOT NULL,
    CONSTRAINT sentry_groupedmessage_level_check CHECK ((level >= 0)),
    CONSTRAINT sentry_groupedmessage_status_check CHECK ((status >= 0)),
    CONSTRAINT sentry_groupedmessage_times_seen_check CHECK ((times_seen >= 0))
);


ALTER TABLE public.sentry_groupedmessage OWNER TO ilvar;

--
-- Name: sentry_groupedmessage_id_seq; Type: SEQUENCE; Schema: public; Owner: ilvar
--

CREATE SEQUENCE sentry_groupedmessage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sentry_groupedmessage_id_seq OWNER TO ilvar;

--
-- Name: sentry_groupedmessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ilvar
--

ALTER SEQUENCE sentry_groupedmessage_id_seq OWNED BY sentry_groupedmessage.id;


--
-- Name: sentry_groupedmessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ilvar
--

SELECT pg_catalog.setval('sentry_groupedmessage_id_seq', 6, true);


--
-- Name: sentry_message; Type: TABLE; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE TABLE sentry_message (
    id integer NOT NULL,
    logger character varying(64) DEFAULT 'root'::character varying NOT NULL,
    class_name character varying(128),
    level integer DEFAULT 40 NOT NULL,
    message text NOT NULL,
    traceback text,
    view character varying(200),
    url character varying(200),
    server_name character varying(128) NOT NULL,
    checksum character varying(32) NOT NULL,
    datetime timestamp with time zone DEFAULT '2011-10-11 12:51:01.842919-05'::timestamp with time zone NOT NULL,
    data text,
    group_id integer,
    site character varying(128),
    message_id character varying(32),
    CONSTRAINT sentry_message_level_check CHECK ((level >= 0))
);


ALTER TABLE public.sentry_message OWNER TO ilvar;

--
-- Name: sentry_message_id_seq; Type: SEQUENCE; Schema: public; Owner: ilvar
--

CREATE SEQUENCE sentry_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sentry_message_id_seq OWNER TO ilvar;

--
-- Name: sentry_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ilvar
--

ALTER SEQUENCE sentry_message_id_seq OWNED BY sentry_message.id;


--
-- Name: sentry_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ilvar
--

SELECT pg_catalog.setval('sentry_message_id_seq', 7, true);


--
-- Name: sentry_messagecountbyminute; Type: TABLE; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE TABLE sentry_messagecountbyminute (
    id integer NOT NULL,
    group_id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    times_seen integer DEFAULT 0 NOT NULL,
    CONSTRAINT sentry_messagecountbyminute_times_seen_check CHECK ((times_seen >= 0))
);


ALTER TABLE public.sentry_messagecountbyminute OWNER TO ilvar;

--
-- Name: sentry_messagecountbyminute_id_seq; Type: SEQUENCE; Schema: public; Owner: ilvar
--

CREATE SEQUENCE sentry_messagecountbyminute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sentry_messagecountbyminute_id_seq OWNER TO ilvar;

--
-- Name: sentry_messagecountbyminute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ilvar
--

ALTER SEQUENCE sentry_messagecountbyminute_id_seq OWNED BY sentry_messagecountbyminute.id;


--
-- Name: sentry_messagecountbyminute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ilvar
--

SELECT pg_catalog.setval('sentry_messagecountbyminute_id_seq', 7, true);


--
-- Name: sentry_messagefiltervalue; Type: TABLE; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE TABLE sentry_messagefiltervalue (
    id integer NOT NULL,
    group_id integer NOT NULL,
    times_seen integer DEFAULT 0 NOT NULL,
    key character varying(32) NOT NULL,
    value character varying(200) NOT NULL,
    CONSTRAINT sentry_messagefiltervalue_times_seen_check CHECK ((times_seen >= 0))
);


ALTER TABLE public.sentry_messagefiltervalue OWNER TO ilvar;

--
-- Name: sentry_messagefiltervalue_id_seq; Type: SEQUENCE; Schema: public; Owner: ilvar
--

CREATE SEQUENCE sentry_messagefiltervalue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sentry_messagefiltervalue_id_seq OWNER TO ilvar;

--
-- Name: sentry_messagefiltervalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ilvar
--

ALTER SEQUENCE sentry_messagefiltervalue_id_seq OWNED BY sentry_messagefiltervalue.id;


--
-- Name: sentry_messagefiltervalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ilvar
--

SELECT pg_catalog.setval('sentry_messagefiltervalue_id_seq', 18, true);


--
-- Name: sentry_messageindex; Type: TABLE; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE TABLE sentry_messageindex (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "column" character varying(32) NOT NULL,
    value character varying(128) NOT NULL,
    CONSTRAINT sentry_messageindex_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.sentry_messageindex OWNER TO ilvar;

--
-- Name: sentry_messageindex_id_seq; Type: SEQUENCE; Schema: public; Owner: ilvar
--

CREATE SEQUENCE sentry_messageindex_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sentry_messageindex_id_seq OWNER TO ilvar;

--
-- Name: sentry_messageindex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ilvar
--

ALTER SEQUENCE sentry_messageindex_id_seq OWNED BY sentry_messageindex.id;


--
-- Name: sentry_messageindex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ilvar
--

SELECT pg_catalog.setval('sentry_messageindex_id_seq', 1, false);


--
-- Name: south_migrationhistory; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE south_migrationhistory (
    id integer NOT NULL,
    app_name character varying(255) NOT NULL,
    migration character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.south_migrationhistory OWNER TO postgres;

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE south_migrationhistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.south_migrationhistory_id_seq OWNER TO postgres;

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE south_migrationhistory_id_seq OWNED BY south_migrationhistory.id;


--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('south_migrationhistory_id_seq', 58, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE auth_message ALTER COLUMN id SET DEFAULT nextval('auth_message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ilvar
--

ALTER TABLE common_burialcategory ALTER COLUMN id SET DEFAULT nextval('common_burialcategory_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_burialeditcause ALTER COLUMN id SET DEFAULT nextval('common_burialeditcause_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_burialinformationlinks ALTER COLUMN id SET DEFAULT nextval('common_burialinformationlinks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_burialpictures ALTER COLUMN id SET DEFAULT nextval('common_burialpictures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_burialtype ALTER COLUMN id SET DEFAULT nextval('common_burialtype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_closurecause ALTER COLUMN id SET DEFAULT nextval('common_closurecause_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ilvar
--

ALTER TABLE common_comissariat ALTER COLUMN id SET DEFAULT nextval('common_comissariat_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_deadmancategory ALTER COLUMN id SET DEFAULT nextval('common_deadmancategory_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_deathcause ALTER COLUMN id SET DEFAULT nextval('common_deathcause_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_documentsplace ALTER COLUMN id SET DEFAULT nextval('common_documentsplace_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_geocity ALTER COLUMN id SET DEFAULT nextval('common_geocity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_geocountry ALTER COLUMN id SET DEFAULT nextval('common_geocountry_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_georegion ALTER COLUMN id SET DEFAULT nextval('common_georegion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_geostreet ALTER COLUMN id SET DEFAULT nextval('common_geostreet_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_informationsource ALTER COLUMN id SET DEFAULT nextval('common_informationsource_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_memorialstate ALTER COLUMN id SET DEFAULT nextval('common_memorialstate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_militaryconflict ALTER COLUMN id SET DEFAULT nextval('common_militaryconflict_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_militaryconflicttype ALTER COLUMN id SET DEFAULT nextval('common_militaryconflicttype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_militaryunit ALTER COLUMN id SET DEFAULT nextval('common_militaryunit_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_nationality ALTER COLUMN id SET DEFAULT nextval('common_nationality_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ilvar
--

ALTER TABLE common_person_closed_burials ALTER COLUMN id SET DEFAULT nextval('common_person_closed_burials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_personeditcause ALTER COLUMN id SET DEFAULT nextval('common_personeditcause_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_personinformationlinks ALTER COLUMN id SET DEFAULT nextval('common_personinformationlinks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_post ALTER COLUMN id SET DEFAULT nextval('common_post_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_rank ALTER COLUMN id SET DEFAULT nextval('common_rank_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE common_searchobject ALTER COLUMN id SET DEFAULT nextval('common_searchobject_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE easy_thumbnails_source ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_source_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE easy_thumbnails_thumbnail ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_thumbnail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ilvar
--

ALTER TABLE sentry_filtervalue ALTER COLUMN id SET DEFAULT nextval('sentry_filtervalue_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ilvar
--

ALTER TABLE sentry_groupedmessage ALTER COLUMN id SET DEFAULT nextval('sentry_groupedmessage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ilvar
--

ALTER TABLE sentry_message ALTER COLUMN id SET DEFAULT nextval('sentry_message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ilvar
--

ALTER TABLE sentry_messagecountbyminute ALTER COLUMN id SET DEFAULT nextval('sentry_messagecountbyminute_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ilvar
--

ALTER TABLE sentry_messagefiltervalue ALTER COLUMN id SET DEFAULT nextval('sentry_messagefiltervalue_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ilvar
--

ALTER TABLE sentry_messageindex ALTER COLUMN id SET DEFAULT nextval('sentry_messageindex_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE south_migrationhistory ALTER COLUMN id SET DEFAULT nextval('south_migrationhistory_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_message (id, user_id, message) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add site	6	add_site
17	Can change site	6	change_site
18	Can delete site	6	delete_site
19	Can add log entry	7	add_logentry
20	Can change log entry	7	change_logentry
21	Can delete log entry	7	delete_logentry
22	Can add migration history	8	add_migrationhistory
23	Can change migration history	8	change_migrationhistory
24	Can delete migration history	8	delete_migrationhistory
25	Can add страна	9	add_geocountry
26	Can change страна	9	change_geocountry
27	Can delete страна	9	delete_geocountry
28	Can add регион	10	add_georegion
29	Can change регион	10	change_georegion
30	Can delete регион	10	delete_georegion
31	Can add населенный пункт	11	add_geocity
32	Can change населенный пункт	11	change_geocity
33	Can delete населенный пункт	11	delete_geocity
34	Can add улица	12	add_geostreet
35	Can change улица	12	change_geostreet
36	Can delete улица	12	delete_geostreet
37	Can add воинское звание	13	add_rank
38	Can change воинское звание	13	change_rank
39	Can delete воинское звание	13	delete_rank
40	Can add Причина гибели	14	add_deathcause
41	Can change Причина гибели	14	change_deathcause
42	Can delete Причина гибели	14	delete_deathcause
43	Can add Категория погибшего	15	add_deadmancategory
44	Can change Категория погибшего	15	change_deadmancategory
45	Can delete Категория погибшего	15	delete_deadmancategory
46	Can add Место нахождения документов	16	add_documentsplace
47	Can change Место нахождения документов	16	change_documentsplace
48	Can delete Место нахождения документов	16	delete_documentsplace
49	Can add Тип воинского захоронения	17	add_burialtype
50	Can change Тип воинского захоронения	17	change_burialtype
51	Can delete Тип воинского захоронения	17	delete_burialtype
52	Can add Тип военного конфликта	18	add_militaryconflicttype
53	Can change Тип военного конфликта	18	change_militaryconflicttype
54	Can delete Тип военного конфликта	18	delete_militaryconflicttype
55	Can add Военный конфликт	19	add_militaryconflict
56	Can change Военный конфликт	19	change_militaryconflict
57	Can delete Военный конфликт	19	delete_militaryconflict
58	Can add Источник информации	20	add_informationsource
59	Can change Источник информации	20	change_informationsource
60	Can delete Источник информации	20	delete_informationsource
61	Can add Причина закрытия захоронения	21	add_closurecause
62	Can change Причина закрытия захоронения	21	change_closurecause
63	Can delete Причина закрытия захоронения	21	delete_closurecause
64	Can add Национальность	22	add_nationality
65	Can change Национальность	22	change_nationality
66	Can delete Национальность	22	delete_nationality
67	Can add Должность	23	add_post
68	Can change Должность	23	change_post
69	Can delete Должность	23	delete_post
70	Can add Воинское подразделение	24	add_militaryunit
71	Can change Воинское подразделение	24	change_militaryunit
72	Can delete Воинское подразделение	24	delete_militaryunit
73	Can add Погибший	25	add_person
74	Can change Погибший	25	change_person
75	Can delete Погибший	25	delete_person
76	Can add Место призыва	26	add_personcall
77	Can change Место призыва	26	change_personcall
78	Can delete Место призыва	26	delete_personcall
79	Can add История службы	27	add_personduty
80	Can change История службы	27	change_personduty
81	Can delete История службы	27	delete_personduty
82	Can add Основание для редакирования Воина	28	add_personeditcause
83	Can change Основание для редакирования Воина	28	change_personeditcause
84	Can delete Основание для редакирования Воина	28	delete_personeditcause
85	Can add Ссылка на информационные источники	29	add_personinformationlinks
86	Can change Ссылка на информационные источники	29	change_personinformationlinks
87	Can delete Ссылка на информационные источники	29	delete_personinformationlinks
88	Can add Адрес рождения	30	add_locationbirth
89	Can change Адрес рождения	30	change_locationbirth
90	Can delete Адрес рождения	30	delete_locationbirth
91	Can add Захоронение	31	add_burial
92	Can change Захоронение	31	change_burial
93	Can delete Захоронение	31	delete_burial
94	Can add Захоронения военнослужащего	32	add_personburial
95	Can change Захоронения военнослужащего	32	change_personburial
96	Can delete Захоронения военнослужащего	32	delete_personburial
97	Can add Основание для внесения изменения	33	add_burialeditcause
98	Can change Основание для внесения изменения	33	change_burialeditcause
99	Can delete Основание для внесения изменения	33	delete_burialeditcause
100	Can add Фотография захоронения	34	add_burialpictures
101	Can change Фотография захоронения	34	change_burialpictures
102	Can delete Фотография захоронения	34	delete_burialpictures
103	Can add Ссылка на информационные источники	35	add_burialinformationlinks
104	Can change Ссылка на информационные источники	35	change_burialinformationlinks
105	Can delete Ссылка на информационные источники	35	delete_burialinformationlinks
106	Can add Поисковый объект	36	add_searchobject
107	Can change Поисковый объект	36	change_searchobject
108	Can delete Поисковый объект	36	delete_searchobject
109	Can add Входящие захоронения	37	add_closedburial
110	Can change Входящие захоронения	37	change_closedburial
111	Can delete Входящие захоронения	37	delete_closedburial
112	Can add Адрес захоронения	38	add_locationburial
113	Can change Адрес захоронения	38	change_locationburial
114	Can delete Адрес захоронения	38	delete_locationburial
115	Can add source	39	add_source
116	Can change source	39	change_source
117	Can delete source	39	delete_source
118	Can add thumbnail	40	add_thumbnail
119	Can change thumbnail	40	change_thumbnail
120	Can delete thumbnail	40	delete_thumbnail
121	Can add Состояние памятника	41	add_memorialstate
122	Can change Состояние памятника	41	change_memorialstate
123	Can delete Состояние памятника	41	delete_memorialstate
124	Can add message	42	add_message
125	Can change message	42	change_message
126	Can delete message	42	delete_message
127	Can add grouped message	43	add_groupedmessage
128	Can change grouped message	43	change_groupedmessage
129	Can delete grouped message	43	delete_groupedmessage
130	Can view	43	can_view
131	Can add message	44	add_message
132	Can change message	44	change_message
133	Can delete message	44	delete_message
134	Can add filter value	45	add_filtervalue
135	Can change filter value	45	change_filtervalue
136	Can delete filter value	45	delete_filtervalue
137	Can add message filter value	46	add_messagefiltervalue
138	Can change message filter value	46	change_messagefiltervalue
139	Can delete message filter value	46	delete_messagefiltervalue
140	Can add message count by minute	47	add_messagecountbyminute
141	Can change message count by minute	47	change_messagecountbyminute
142	Can delete message count by minute	47	delete_messagecountbyminute
143	Can add message index	48	add_messageindex
144	Can change message index	48	change_messageindex
145	Can delete message index	48	delete_messageindex
146	Can add Связь категории с захоронением	49	add_burialcategory
147	Can change Связь категории с захоронением	49	change_burialcategory
148	Can delete Связь категории с захоронением	49	delete_burialcategory
149	Can add Военкомат	50	add_comissariat
150	Can change Военкомат	50	change_comissariat
151	Can delete Военкомат	50	delete_comissariat
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined) FROM stdin;
2	mil				sha1$2806e$084dcd6a44eb97aa21686670907af370589fc924	t	t	f	2011-07-19 04:41:13.579779-05	2011-07-15 04:57:39-05
1	robotd			soul@youmemory.org	sha1$379d5$d44aada9e5e22bb614e7d75f45872179a36ea79f	t	t	t	2011-10-03 01:41:05.143572-05	2011-06-26 03:09:41.227747-05
3	ilvar				sha1$5f0f9$a2bc0bf9b22dca86f7f6a530f341293e9ca10062	t	t	t	2011-10-03 01:42:35-05	2011-10-03 01:42:35-05
4	admin			ilvar@mail.ru	sha1$a35c9$5d468c6a1758fee1a43fdaeb3022c1b43f17238f	t	t	t	2011-11-28 14:10:55.870448-05	2011-10-10 08:56:17.687451-05
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
94	2	7
95	2	8
96	2	9
97	2	25
98	2	26
99	2	27
100	2	28
101	2	29
102	2	30
103	2	31
104	2	32
105	2	33
106	2	34
107	2	35
108	2	36
109	2	37
110	2	38
111	2	39
112	2	40
113	2	41
114	2	42
115	2	43
116	2	44
117	2	45
118	2	46
119	2	47
120	2	48
121	2	49
122	2	50
123	2	51
124	2	52
125	2	53
126	2	54
127	2	55
128	2	56
129	2	57
130	2	58
131	2	59
132	2	60
133	2	61
134	2	62
135	2	63
136	2	64
137	2	65
138	2	66
139	2	67
140	2	68
141	2	69
142	2	70
143	2	71
144	2	72
145	2	73
146	2	74
147	2	75
148	2	76
149	2	77
150	2	78
151	2	79
152	2	80
153	2	81
154	2	82
155	2	83
156	2	84
157	2	85
158	2	86
159	2	87
160	2	88
161	2	89
162	2	90
163	2	91
164	2	92
165	2	93
166	2	94
167	2	95
168	2	96
169	2	97
170	2	98
171	2	99
172	2	100
173	2	101
174	2	102
175	2	103
176	2	104
177	2	105
178	2	106
179	2	107
180	2	108
181	2	109
182	2	110
183	2	111
184	2	112
185	2	113
186	2	114
\.


--
-- Data for Name: common_burial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_burial (obid, uuid, passportid, date_passport, date_burried, date_discovered, burial_type_id, military_conflict_id, date_memorial, date_gosznak, photo, scheme, creator_id, date_of_creation, info, is_trash, oblocationid, state_id, date_closed, date_of_update, date_gosznak_no_month, date_gosznak_no_day, names_count, date_burried_no_month, date_burried_no_day, date_discovered_no_month, date_discovered_no_day, date_memorial_no_month, date_memorial_no_day) FROM stdin;
\.


--
-- Data for Name: common_burialcategory; Type: TABLE DATA; Schema: public; Owner: ilvar
--

COPY common_burialcategory (id, category_id, burial_id, known, unknown, updated) FROM stdin;
\.


--
-- Data for Name: common_burialeditcause; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_burialeditcause (id, burial_id, name, number, date, date_edit, user_id) FROM stdin;
\.


--
-- Data for Name: common_burialinformationlinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_burialinformationlinks (id, burial_id, link) FROM stdin;
\.


--
-- Data for Name: common_burialpictures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_burialpictures (id, burial_id, photo, comment) FROM stdin;
\.


--
-- Data for Name: common_burialtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_burialtype (id, obid, name, brief) FROM stdin;
1	5	Воинское кладбище	\N
2	7	Братская могила	\N
3	8	Индивидуальная могила	\N
4	9	Место массов.уничтож.	\N
5	6	Локальные войны	\N
6	47919	Смешанное	\N
7	47928	Иностранное	\N
\.


--
-- Data for Name: common_closedburial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_closedburial (burial_from_id, date, cause_id, burial_to_id, document) FROM stdin;
\.


--
-- Data for Name: common_closurecause; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_closurecause (id, name) FROM stdin;
1	решение Администрации
\.


--
-- Data for Name: common_comissariat; Type: TABLE DATA; Schema: public; Owner: ilvar
--

COPY common_comissariat (id, obid, country_id, region_id, city_id, info, gps_x, gps_y, gps_z, name) FROM stdin;
\.


--
-- Data for Name: common_deadmancategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_deadmancategory (id, obid, name, brief, ordering) FROM stdin;
1	1	Участник сопротивления	\N	1
2	2	Другие	\N	1
3	3	Военнослужащий	\N	1
4	4	Жертва войны	\N	1
\.


--
-- Data for Name: common_deathcause; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_deathcause (id, obid, name) FROM stdin;
1	10	Пpопал без вести
2	11	Погиб в плену
3	12	Умеp от pан
4	13	Приговорен
5	14	Находился в плену
6	15	Погиб в бою
7	16	Расстрелян
8	17	Погиб на фронте
\.


--
-- Data for Name: common_documentsplace; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_documentsplace (id, name) FROM stdin;
10	В.г.науменко
11	4378
12	Цамо оп.18002 д.738 л.83
13	Цамо оп.818883с д.531 л.38 пар. 160/7369
14	Донесение № 31022с-1943, д.51/8, т.5 -2009
15	Дон.№107873 н/с-1945г.;51/8 т.5-2009г.
16	Картотека уч.безв.потерь оф.состава
17	Цамо рф
18	Цамо ф.33 оп.11458 д.602
\.


--
-- Data for Name: common_geocity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_geocity (id, obid, region_id, name) FROM stdin;
1	128	4	Хотимский
2	57	3	Клецкий
3	120	3	Стародорожский
4	47	1	Житковичский
5	61	3	Копыльский
6	102	7	Пинский
7	112	2	Сенненский
8	56	4	Кировский
9	95	2	Оршанский
10	51	7	Ивановский
11	113	4	Славгородский
12	43	2	Дубровенский
13	40	2	Докшицкий
14	7	4	Бобруйский
15	123	2	Толочинский
16	17	2	Витебский
17	68	3	Крупский
18	4	7	Березовский
19	58	4	Климовичский
20	5	5	Берестовицкий
21	18	5	Волковысский
22	46	7	Жабинковский
23	115	3	Слуцкий
24	108	1	Рогачевский
25	130	4	Чаусский
26	27	4	Г.могилев
27	63	1	Кормянский
28	29	7	Ганцевичский
29	6	2	Бешенковичский
30	126	6	Фрунзенский
31	49	6	Заводской
32	62	5	Кореличский
33	135	2	Шарковщинский
34	125	2	Ушачский
35	129	6	Центральный
36	96	4	Осиповичский
37	106	3	Пуховичский
38	53	5	Ивьевский
39	41	4	Дрибинский
40	67	4	Круглянский
41	133	4	Чериковский
42	1	7	Барановичский
43	104	2	Поставский
44	132	3	Червенский
45	24	2	Г.витебск
46	117	5	Сморгонский
47	134	1	Чечерский
48	15	1	Ветковский
49	33	1	Гомельский
50	105	7	Пружанский
51	124	3	Узденский
52	22	4	Г.бобруйск
53	66	4	Кричевский
54	121	3	Столбцовский
55	16	3	Вилейский
56	87	4	Мстиславский
57	42	7	Дрогичинский
58	118	6	Советский
59	11	7	Брестский
60	122	7	Столинский
61	45	1	Ельский
62	37	5	Гродненский
63	2	4	Белыничский
64	70	6	Ленинский
65	36	2	Городокский
66	127	1	Хойникский
67	72	5	Лидский
68	82	4	Могилевский
69	8	3	Борисовский
70	19	3	Воложинский
71	79	7	Малоритский
72	52	7	Ивацевичский
73	75	1	Лоевский
74	48	1	Жлобинский
75	77	3	Любанский
76	119	3	Солигорский
77	71	2	Лепельский
78	13	4	Быховский
79	14	2	Верхнедвинский
80	59	4	Кличевский
81	73	2	Лиозненский
82	111	5	Свислочский
83	38	3	Дзержинский
84	91	5	Новогрудский
85	137	2	Шумилинский
86	31	4	Глусский
87	88	3	Мядельский
88	83	1	Мозырский
89	93	1	Октябрьский
90	116	3	Смолевичский
91	89	1	Наровлянский
92	55	7	Каменецкий
93	94	6	Октябрьский(м)
94	20	5	Вороновский
95	84	3	Молодечненский
96	103	2	Полоцкий
97	9	1	Брагинский
98	90	3	Несвижский
99	35	4	Горецкий
100	69	1	Лельчицкий
101	25	1	Г.гомель
102	114	5	Слонимский
103	80	3	Минский
104	81	2	Миорский
105	86	5	Мостовский
106	39	1	Добрушский
107	78	7	Ляховичский
108	60	7	Кобринский
109	30	2	Глубокский
110	50	5	Зельвенский
111	28	2	Г.полоцк
112	110	1	Светлогорский
113	138	5	Щучинский
114	98	5	Ошмянский
115	64	4	Костюковичский
116	26	5	Г.гродно
117	76	7	Лунинецкий
118	136	4	Шкловский
119	97	5	Островецкий
120	101	1	Петриковский
121	99	6	Партизанский
122	3	3	Березинский
123	100	6	Первомайский
124	54	1	Калинковичский
125	44	5	Дятловский
126	65	4	Краснопольский
127	74	3	Логойский
128	131	2	Чашникский
129	107	1	Речицкий
130	10	2	Браславский
131	109	2	Россонский
132	23	7	Г.брест
133	508	9	Г.барнаул
134	166	9	Алейский
135	177	9	Алтайский
136	239	9	Баевский
137	317	9	Бийский
138	325	9	Благовещенский
139	392	9	Бурлинский
140	399	9	Быстроистокский
141	484	9	Волчихинский
142	735	9	Егорьевский
143	746	9	Ельцовский
144	773	9	Завьяловский
145	780	9	Залесовский
146	807	9	Змеиногорский
147	890	9	Калманский
148	897	9	Каменский
149	990	9	Ключевский
150	1044	9	Косихинский
151	1058	9	Кош-агагский
152	1070	9	Красногорский
153	1091	9	Краснощековский
154	1121	9	Кулундинский
155	1138	9	Курьинский
156	1143	9	Кытмановский
157	1180	9	Локтевский
158	1215	9	Майминский
159	1232	9	Мамонтовский
160	1279	9	Михайловский
161	1377	9	Новигихинский
162	1466	9	Онгудайский
163	1494	9	Павловский
164	1500	9	Панкрушихинский
165	1508	9	Первомайский
166	1528	9	Петропаловский
167	1568	9	Поспелихинский
168	1630	9	Ребрихинский
169	1641	9	Родинский
170	1646	9	Романовский
171	1655	9	Рубцовский
172	1742	9	Славгородский
173	1756	9	Смоленский
174	1761	9	Советский
175	1771	9	Солонешенский
176	1773	9	Солтонский
177	1776	9	Сорокинский
178	1848	9	Табунский
179	1857	9	Тальменский
180	1910	9	Тогульский
181	1923	9	Топчихинский
182	1930	9	Третьяковский
183	1931	9	Троицкий
184	1948	9	Турочакский
185	1958	9	Тюменцевский
186	1969	9	Угловский
187	1980	9	Улаганский
188	2012	9	Усть-калманский
189	2014	9	Усть-канский
190	2015	9	Усть-коксинский
191	2021	9	Усть-пристанский
192	2041	9	Хабарский
193	2076	9	Целинный
194	2092	9	Чарышский
195	2167	9	Шебалинский
196	2184	9	Шипуновский
197	546	10	Г.краснодар
198	143	10	Абинский
199	188	10	Анапский
200	199	10	Апшеронский
201	289	10	Белоглинский
202	298	10	Белореченский
203	378	10	Брюховецкий
204	496	10	Выселковский
205	636	10	Гиагинский
206	701	10	Динской
207	736	10	Ейский
208	869	10	Кавказский
209	908	10	Каневский
210	1032	10	Кореновский
211	1059	10	Кошехабльский
212	1064	10	Красноармейский
213	1068	10	Красногвардейский
214	1106	10	Крымский
215	1132	10	Курганинский
216	1141	10	Кущевский
217	1146	10	Лабинский
218	1158	10	Ленинградский
219	1214	10	Майкопский
220	1392	10	Новокубанский
221	1403	10	Новопокровский
222	1486	10	Отрадненский
223	1586	10	Приморско-ахтарский
224	1709	10	Северский
225	1746	10	Славянский
226	1804	10	Староминский
227	1877	10	Тбилисский
228	1883	10	Темрюкский
229	1900	10	Теучежский
230	1902	10	Тимашевский
231	1906	10	Тихорецкий
232	1935	10	Туапсинский
233	2019	10	Усть-лабинский
234	2190	10	Шовгеновский
235	2203	10	Щербиновский
236	547	11	Г.красноярск
237	139	11	Абанский
238	218	11	Аскизский
239	146	11	Агинский
240	242	11	Байкитский
241	250	11	Балахтинский
242	280	11	Бейский
243	320	11	Бирилюсский
244	337	11	Боготольский
245	338	11	Боградский
246	341	11	Богучанский
247	353	11	Большемуртинский
248	357	11	Большеулуйский
249	695	11	Дзержинский
250	700	11	Диксонский
251	747	11	Емельяновский
252	749	11	Енисейский
253	752	11	Ермаковский
254	828	11	Идринский
255	838	11	Иланский
256	840	11	Илимпийский
257	852	11	Ирбейский
258	877	11	Казачинский
259	909	11	Канский
260	916	11	Каратузский
261	945	11	Кежемский
262	1086	11	Краснотуранский
263	1130	11	Курагинский
264	1235	11	Манский
265	1275	11	Минусинский
266	1305	11	Мотыгинский
267	1328	11	Назаровский
268	1361	11	Нижнеингашский
269	1408	11	Новоселовский
270	1503	11	Партизанский
271	1472	11	Орджоникидзевский
272	1537	11	Пировский
273	1662	11	Рыбинский
274	1695	11	Саянский
275	1706	11	Северо-енисейский
276	1837	11	Сухобузимский
277	1869	11	Тасеевский
278	1876	11	Таштыпский
279	1943	11	Тунгусско-чунский
280	1950	11	Туруханский
281	1959	11	Тюхтетский
282	1975	11	Ужурский
283	2005	11	Усть-абаканский
284	2010	11	Усть-енисейский
285	2031	11	Уярский
286	2054	11	Хатангский
287	2158	11	Шарыповский
288	2185	11	Ширинский
289	2200	11	Шушенский
290	515	12	Г.владивосток
291	195	12	Анучинский
292	846	12	Иманский
293	868	12	Кавалеровский
294	979	12	Кировский
295	1147	12	Лазовский
296	1325	12	Надеждинский
297	1447	12	Октябрьский
298	1455	12	Ольгинский
299	1547	12	Пограничный
300	1555	12	Пожарский
301	1784	12	Спасский
302	1892	12	Тернейский
303	1898	12	Тетюхинский
304	2003	12	Уссурийский
305	2046	12	Ханкайский
306	2052	12	Хасанский
307	2068	12	Хорольский
308	2113	12	Черниговский
309	2137	12	Чугуевский
310	2189	12	Шкотовский
311	2227	12	Яковлевский
312	590	13	Г.ставрополь
313	151	13	Адыге-хабльский
314	169	13	Александровский
315	196	13	Апанасенковский
316	206	13	Арзгирский
317	326	13	Благодарненский
318	633	13	Георгиевский
319	800	13	Зеленчукский
320	833	13	Изобальненский
321	850	13	Ипатовский
322	917	13	Карачаевский
323	1057	13	Кочубеевский
324	1136	13	Курский
325	1156	13	Левокумский
326	1228	13	Малокарачаевский
327	1274	13	Минераловодский
328	1355	13	Нефтекумский
329	1380	13	Новоалександровский
330	1525	13	Петровский
331	1575	13	Предгорный
332	1581	13	Прикубанский
333	1582	13	Прикумский
334	1997	13	Урупский
335	2042	13	Хабезский
336	2192	13	Шпаковский
337	604	14	Г.хабаровск
338	184	14	Амурский
339	230	14	Аяно-майский
340	318	14	Бикинский
341	321	14	Биробиджанский
342	432	14	Верхнебуреинский
343	501	14	Вяземский
344	1021	14	Комсомольский
345	845	14	Им.лазо
346	1160	14	Ленинский
347	1332	14	Нанайский
348	1371	14	Николаевский
349	1433	14	Облученский
350	1489	14	Охотский
351	1754	14	Смидовичский
352	1762	14	Советско-гаванский
353	1949	14	Туруго-чумиканский
354	1984	14	Ульчский
355	2040	14	Хабаровский
356	511	14	Г.биробиджан
357	512	15	Г.благовещенск
358	214	15	Архаринский
359	290	15	Белогорский
360	390	15	Бурейский
361	693	15	Джелтулакский
362	771	15	Завитинский
363	797	15	Зейский
364	822	15	Ивановский
365	1028	15	Константиновский
366	1213	15	Мазановский
367	1648	15	Ромненский
368	1702	15	Свободненский
369	1713	15	Селемджинский
370	1732	15	Серышевский
371	1739	15	Сковородинский
372	1860	15	Тамбовский
373	1953	15	Тыгдинский
374	2183	15	Шимановский
375	505	16	Г.архангельск
376	428	16	Вельский
377	441	16	Верхнетоемский
378	459	16	Вилегодский
379	462	16	Виноградовский
380	922	16	Каргопольский
381	1027	16	Коношский
382	1051	16	Котласский
383	1066	16	Красноборский
384	1162	16	Ленский
385	1165	16	Лешуконский
386	1260	16	Мезенский
387	1431	16	Няндомский
388	1467	16	Онежский
389	1536	16	Пинежский
390	1544	16	Плесецкий
391	1585	16	Приморский
392	2025	16	Устьянский
393	2064	16	Холмогорский
394	2176	16	Шенкурский
395	563	16	Г.нарьян-мар
396	586	16	Г.северодвинск
397	506	17	Г.астрахань
398	467	17	Владимировский
399	475	17	Володарский
400	750	17	Енотаевский
401	837	17	Икрянинский
402	904	17	Камызякский
403	1092	17	Красноярский
404	1167	17	Лиманский
405	1333	17	Наримановский
406	2048	17	Харибалинский
407	2118	17	Черноярский
408	509	18	Г.белгород
409	170	18	Алексеевский
410	283	18	Белгородский
411	362	18	Борисовский
412	406	18	Валуйский
413	416	18	Вейделевский
414	478	18	Волоконовский
415	668	18	Губкинский
416	824	18	Ивнянский
417	1038	18	Корочанский
418	1402	18	Новооскольский
419	1600	18	Прохоровский
420	1623	18	Ракитянский
421	1639	18	Ровеньский
422	1805	18	Старооскольский
423	2124	18	Чернянский
424	2168	18	Шебекинский
425	513	19	Г.брянск
426	372	19	Брасовский
427	379	19	Брянский
428	725	19	Дубровский
429	733	19	Дятьковский
430	768	19	Жуковский
431	918	19	Карачевский
432	985	19	Клетнянский
433	987	19	Климовский
434	989	19	Клинцовский
435	1018	19	Комаричский
436	1252	19	Мглинский
437	1321	19	Навлинский
438	1391	19	Новозыбковский
439	1546	19	Погарский
440	1570	19	Почепский
441	1710	19	Севский
442	1799	19	Стародубский
443	1824	19	Суземский
444	1830	19	Суражский
445	1934	19	Трубчевский
446	1988	19	Унечский
447	516	20	Г.владимир
448	502	20	Вязниковский
449	656	20	Гороховецкий
450	675	20	Гусь-хрустальный
451	902	20	Камешковский
452	974	20	Киржачский
453	998	20	Ковровский
454	1017	20	Кольчугинский
455	1262	20	Меленковский
456	1311	20	Муромский
457	1530	20	Петушинский
458	1715	20	Селивановский
459	1759	20	Собинский
460	1821	20	Судогодский
461	1823	20	Суздальский
462	2217	20	Юрьев-польский
463	517	21	Г.волгоград
464	172	21	Алекссевский
465	397	21	Быковский
466	680	21	Даниловский
467	723	21	Дубовский
468	740	21	Еланский
469	764	21	Жирновский
470	842	21	Иловлинский
471	883	21	Калачевский
472	905	21	Камышинский
473	961	21	Киквидзенский
474	986	21	Клетский
475	1049	21	Котельниковский
476	1052	21	Котовский
477	1124	21	Кумылженский
478	1356	21	Нехаевский
479	1381	21	Новоаннинский
480	1399	21	Новониколаевский
481	1458	21	Ольховский
482	1498	21	Палласовский
483	1656	21	Руднянский
484	1700	21	Светлоярский
485	1722	21	Серафимовичский
486	1787	21	Среднеахтубинский
487	1806	21	Старополтавский
488	1832	21	Суровикинский
489	1999	21	Урюпинский
490	2037	21	Фроловский
491	2123	21	Чернышковский
492	518	21	Г.волжский
493	519	22	Г.вологда
494	231	22	Бабаевский
495	233	22	Бабушкинский
496	291	22	Белозерский
497	414	22	Вашкинский
498	427	22	Великоустюгский
499	445	22	Верховажский
500	468	22	Вожегодский
501	474	22	Вологодский
502	499	22	Вытегорский
503	667	22	Грязовецкий
504	872	22	Кадуйский
505	975	22	Кирилловский
506	954	22	Кигменгско-городецки
507	1258	22	Междуреченский
508	1372	22	Никольский
509	1429	22	Нюксенский
510	1765	22	Сокольский
511	1845	22	Сямженский
512	1864	22	Тарногский
513	1928	22	Тотемский
514	2016	22	Усть-кубанский
515	2027	22	Устюженский
516	2049	22	Харовский
517	2084	22	Чагодощенский
518	2110	22	Череповецкий
519	2171	22	Шекснинский
520	521	23	Г.воронеж
521	192	23	Аннинский
522	330	23	Бобровский
523	342	23	Богучарский
524	363	23	Борисоглебский
525	395	23	Бутурлиновский
526	444	23	Верхнехавский
527	664	23	Грибановский
528	884	23	Калачеевский
529	910	23	Кантемировский
530	1172	23	Лискинский
531	1359	23	Нижнедевицкий
532	1418	23	Новоусманский
533	1420	23	Новохоперский
534	1457	23	Ольховатский
535	1484	23	Острогожский
536	1499	23	Панинский
537	1526	23	Петропавловский
538	1550	23	Подгоренский
539	1626	23	Рамонский
540	1634	23	Репьевский
541	1652	23	Россошанский
542	1720	23	Семилукский
543	1856	23	Таловский
544	1893	23	Терновский
545	2071	23	Хохольский
546	2208	23	Эртильский
547	522	24	Г.горький
548	203	24	Ардатовский
549	205	24	Арзамасский
550	335	24	Богородский
551	349	24	Большеболдинский
552	352	24	Большемурашкинский
553	368	24	Борский
554	396	24	Бутурлинский
555	403	24	Вадский
556	409	24	Варнавинский
557	413	24	Вачский
558	454	24	Ветлужский
559	469	24	Вознесенский
560	487	24	Воротынский
561	488	24	Воскресенский
562	495	24	Выксунский
563	620	24	Гагинский
564	651	24	Городецкий
565	679	24	Дальне-константиновс
566	697	24	Дивеевский
567	992	24	Княгинский
568	997	24	Ковернинский
569	1065	24	Краснобаковский
570	1078	24	Краснооктябрьский
571	1107	24	Кстовский
572	1190	24	Лукьяновский
573	1196	24	Лысковский
574	1320	24	Навашинский
575	1510	24	Перевозский
576	1535	24	Пильнинский
577	1571	24	Починковский
578	1718	24	Семеновский
579	1723	24	Сергачский
580	1733	24	Сеченовский
581	1781	24	Сосновский
582	1749	24	Сласский
583	1920	24	Тонкинский
584	1921	24	Тоншаевский
585	1993	24	Уренский
586	2135	24	Чкаловский
587	2153	24	Шарангский
588	2160	24	Шатковский
589	2165	24	Шахунский
590	507	24	Г.балахна
591	524	24	Г.дзержинск
592	548	24	Г.кулебаки
593	530	25	Г.иваново
594	464	25	Вичугский
595	619	25	Гаврило-пасадский
596	844	25	Ильинский
597	971	25	Кинешемский
598	1194	25	Лухский
599	1496	25	Палехский
600	1522	25	Пестяковский
601	1610	25	Пучежский
602	1642	25	Родниковский
603	1669	25	Савинский
604	1880	25	Тейковский
605	2039	25	Фурмановский
606	2194	25	Шуйский
607	2211	25	Южский
608	2216	25	Юрьевецкий
609	535	26	Г.иркутск
610	163	26	Аларский
611	371	26	Боханский
612	343	26	Бодайбинский
613	373	26	Братский
614	760	26	Жигаловский
615	778	26	Заларинский
616	782	26	Заминский
617	854	26	Иркутский
618	878	26	Казачинско-ленский
619	935	26	Катангский
620	938	26	Качугский
621	973	26	Киренский
622	1117	26	Куйтунский
623	1233	26	Мамско-чуйский
624	1360	26	Нижнеилимский
625	1369	26	Нижнеудинский
626	1459	26	Ольхонский
627	1752	26	Слюдянский
628	1852	26	Тайшетский
629	1939	26	Тулунский
630	2002	26	Усольский
631	2018	26	Усть-кутский
632	2023	26	Усть-удинский
633	2107	26	Черемховский
634	2142	26	Чунский
635	2209	26	Эхирит-булагатский
636	504	26	Г.ангарск
637	539	27	Г.калиниград
638	238	27	Багратионовский
639	630	27	Гвардейский
640	673	27	Гурьевский
641	674	27	Гусевский
642	798	27	Зеленоградский
643	1074	27	Краснознаменский
644	1348	27	Неманский
645	1353	27	Нестеровский
646	1442	27	Озерный
647	1557	27	Полесский
648	1573	27	Правдинский
649	1743	27	Славский
650	2125	27	Черняховский
651	189	28	Андреапольский
652	278	28	Бежецкий
653	302	28	Бельский
654	345	28	Бологовский
655	453	28	Весьегонский
656	500	28	Вышневолоцкий
657	784	28	Западнодвинский
658	815	28	Зубцовский
659	888	28	Калининский
660	894	28	Калядинский
661	940	28	Кашинский
662	950	28	Кесовогорский
663	967	28	Кимрский
664	1022	28	Конаковский
665	1088	28	Краснохолмский
666	1109	28	Кувшиновский
667	1163	28	Лесной
668	1174	28	Лихославльский
669	1220	28	Максатихинский
670	1292	28	Молоковский
671	1347	28	Нелидовский
672	1452	28	Оленинский
673	1482	28	Осташковский
674	1625	28	Рамешковский
675	1637	28	Ржевский
676	1678	28	Сандовский
677	1716	28	Селижаровский
678	1775	28	Сонковский
679	1785	28	Спировский
680	1795	28	Старицкий
681	1925	28	Торжокский
682	1926	28	Торопецкий
683	1972	28	Удомельский
684	540	29	Г.калуга
685	234	29	Бабынинский
686	268	29	Барятинский
687	366	29	Боровский
688	728	29	Думиничский
689	763	29	Жиздринский
690	892	29	Калужский
691	1003	29	Козельский
692	1116	29	Куйбышевский
693	1209	29	Людиновский
694	1230	29	Малоярославецкий
695	1256	29	Медынский
696	1269	29	Мещовский
697	1302	29	Мосальский
698	1783	29	Спас-деменский
699	1836	29	Сухиничский
700	1867	29	Тарусский
701	1970	29	Угодско-заводский
702	1985	29	Ульяновский
703	2036	29	Ферзиковский
704	2056	29	Хвастовичский
705	2221	29	Юхновский
706	567	29	Г.обнинск
707	1527	30	Петропавловск-камчат
708	173	30	Алеутский
709	398	30	Быстринский
710	742	30	Елизовский
711	912	30	Карагинский
712	1272	30	Мильковский
713	1461	30	Олюторский
714	1506	30	Пенжинский
715	1760	30	Соболевский
716	1901	30	Тигильский
717	2007	30	Усть-большерецкий
718	2013	30	Усть-камчатский
719	542	31	Г.кемерово
720	288	31	Беловский
721	830	31	Ижморский
722	948	31	Кемеровский
723	1061	31	Крапивинский
724	1161	31	Ленинск-кузнецкий
725	1240	31	Мариинский
726	1393	31	Новокузнецкий
727	1595	31	Прокопьевский
728	1597	31	Промышленковский
729	1904	31	Тисульский
730	1922	31	Топкинский
731	1960	31	Тяженский
732	2097	31	Чебулинский
733	2214	31	Юргинский
734	2226	31	Яйский
735	2244	31	Яшкинский
736	544	32	Г.киров
737	200	32	Арбажский
738	224	32	Афанасьевский
739	299	32	Белохолуницкий
740	436	32	Верхнекамский
741	449	32	Верхошижемский
742	503	32	Вятско-полянский
743	682	32	Даровский
744	816	32	Зуевский
745	962	32	Кикнурский
746	965	32	Кильмезский
747	978	32	Кирово-чепецкий
748	1050	32	Котельничский
749	1122	32	Куменский
750	1153	32	Лебяжский
751	1189	32	Лузский
752	1224	32	Малмыжский
753	1309	32	Мурашинский
754	1323	32	Нагорский
755	1350	32	Немский
756	1425	32	Нолинский
757	1465	32	Омутнинский
758	1470	32	Опаринский
759	1478	32	Оричевский
760	1533	32	Пижанский
761	1553	32	Подосиновский
762	1679	32	Санчурский
763	1701	32	Свечинский
764	1751	32	Слободской
765	1937	32	Тужинский
766	1989	32	Унинский
767	1994	32	Уржумский
768	2032	32	Фаленский
769	2045	32	Халтуринский
770	2148	32	Шабалинский
771	2218	32	Юрьянский
772	2235	32	Яранский
773	545	33	Г.кострома
774	194	33	Антроповский
775	387	33	Буйский
776	490	33	Вохомский
777	626	33	Галичский
778	873	33	Кадыйский
779	1008	33	Кологривский
780	1047	33	Костромской
781	1083	33	Красносельский
782	1219	33	Макарьевский
783	1236	33	Мантуровский
784	1259	33	Межевский
785	1343	33	Нейский
786	1351	33	Нерехтский
787	1483	33	Островский
788	1492	33	Павинский
789	1504	33	Парфеньевский
790	1562	33	Поназыревский
791	1615	33	Пышугский
792	1767	33	Солигаличский
793	1820	33	Судиславский
794	1834	33	Сусанинский
795	2146	33	Чухломский
796	2159	33	Шарьинский
797	582	34	Г.самара
798	279	34	Безенчукский
799	331	34	Богатовский
800	350	34	Большеглушицкий
801	358	34	Большечерниговский
802	470	34	Волжский
803	856	34	Исаклинский
804	969	34	Кинельский
805	970	34	Кинель-черкасский
806	991	34	Клявлинский
807	1060	34	Кошкинский
808	1354	34	Нефтегорский
809	1520	34	Пестравский
810	1569	34	Похвистневский
811	1579	34	Приволжский
812	1724	34	Сергиевский
813	1792	34	Ставропольский
814	1839	34	Сызранский
815	2058	34	Хворостянский
816	2101	34	Челно-вершинский
817	2177	34	Шенталинский
818	2150	34	Шагонский
819	549	35	Г.курган
820	179	35	Альменевский
821	408	35	Варгашинский
822	678	35	Далматовский
823	919	35	Каргапольский
824	934	35	Катайский
825	951	35	Кетовский
826	1137	35	Куртамышский
827	1154	35	Лебяжьевский
828	1221	35	Макушинский
829	1281	35	Мишкинский
830	1290	35	Мокроусовский
831	1529	35	Петуховский
832	1558	35	Половинский
833	1591	35	Притобольный
834	1692	35	Сафакулевский
835	2151	35	Шадринский
836	2161	35	Шатровский
837	2196	35	Шумихинский
838	2205	35	Щучанский
839	2213	35	Юргамышский
840	550	36	Г.курск
841	641	36	Глушковский
842	658	36	Горшеченский
843	702	36	Дмитриевский
844	758	36	Железногорский
845	811	36	Золотухинский
846	931	36	Касторенский
847	1029	36	Конышевский
848	1031	36	Кореневский
849	1200	36	Льговский
850	1434	36	Обоянский
851	1590	36	Пристенский
852	1665	36	Рыльский
853	1770	36	Солнцевский
854	1819	36	Суджанский
855	1903	36	Тимский
856	2034	36	Фатежский
857	2066	36	Хомутовский
858	2106	36	Черемисиновский
859	2180	36	Шигровский
860	552	37	Г.ленинград
861	339	37	Богситогорский
862	479	37	Волосовский
863	482	37	Волховский
864	492	37	Всеволожский
865	494	37	Выборгский
866	628	37	Гатчинский
867	968	37	Кингисеппский
868	976	37	Киришский
869	1176	37	Лодейнопольский
870	1181	37	Ломоносовский
871	1188	37	Лужский
872	1554	37	Подпорожский
873	1588	37	Приозерский
874	1748	37	Сланцевский
875	1905	37	Тихвинский
876	1927	37	Тосненский
877	553	38	Г.липецк
878	473	38	Воловский
879	666	38	Грязинский
880	681	38	Данковский
881	706	38	Добринский
882	708	38	Добровский
883	712	38	Долгоруковский
884	741	38	Елецкий
885	775	38	Задонский
886	832	38	Измалковский
887	1063	38	Краснинский
888	1152	38	Лебедянский
889	1157	38	Лев-толстовский
890	1168	38	Липецкий
891	1794	38	Становлянский
892	1889	38	Тербунский
893	2001	38	Усманский
894	2061	38	Хлевенский
895	2090	38	Чаплыгинский
896	557	39	Г.магадан
897	186	39	Анадырский
898	313	39	Беринговский
899	319	39	Билибинский
900	862	39	Иультинский
901	1456	39	Ольский
902	1463	39	Омсукчанский
903	1594	39	Провиденский
904	1708	39	Северо-эвенский
905	1788	39	Среднеканский
906	1835	39	Сусуманский
907	1885	39	Тенькинский
908	2053	39	Хасынский
909	2094	39	Чаунский
910	2140	39	Чукотский
911	2223	39	Ягоднинский
912	559	40	Г.москва
913	251	40	Балашихинский
914	477	40	Волоколамский
915	703	40	Дмитровский
916	774	40	Загорский
917	786	40	Зарайский
918	861	40	Истринский
919	941	40	Каширский
920	988	40	Клинский
921	1009	40	Коломенский
922	1183	40	Лотошинский
923	1193	40	Луховицкий
924	1203	40	Люберецкий
925	1287	40	Можайский
926	1317	40	Мытищинский
927	1336	40	Наро-фоминский
928	1422	40	Ногинский
929	1440	40	Одинцовский
930	1475	40	Орехово-зуевский
931	1493	40	Павлово-посадский
932	1552	40	Подольский
933	1612	40	Пушкинский
934	1624	40	Раменский
935	1659	40	Рузский
936	1727	40	Серебряно-прудский
937	1731	40	Серпуховский
938	1769	40	Солнечногорский
939	1817	40	Ступинский
940	1854	40	Талдомский
941	2059	40	Химкинский
942	2128	40	Чеховский
943	2162	40	Шатурский
944	2163	40	Шаховский
945	2202	40	Щелковский
946	560	41	Г.мурманск
947	1016	41	Кольский
948	1175	41	Ловозерский
949	1531	41	Печенгский
950	1895	41	Терский
951	587	41	Г.североморск
952	565	42	Г.новгород
953	269	42	Батецкий
954	365	42	Боровичский
955	404	42	Валдайский
956	480	42	Волотовский
957	688	42	Демянский
958	1097	42	Крестецкий
959	1208	42	Любытинский
960	1227	42	Маловищерский
961	1239	42	Маревский
962	1306	42	Мошенской
963	1376	42	Новгородский
964	1448	42	Окуловский
965	1519	42	Пестовский
966	1551	42	Поддорский
967	1766	42	Солецкий
968	1807	42	Старорусский
969	2057	42	Хвойнинский
970	2065	42	Холмский
971	2139	42	Чудовский
972	566	43	Г.новосибирск
973	237	43	Баганский
974	259	43	Барабинский
975	346	43	Болотнинский
976	429	43	Венгеровский
977	711	43	Доволенский
978	795	43	Здвинский
979	859	43	Искитимский
980	915	43	Карасукский
981	921	43	Каргатский
982	1014	43	Колыванский
983	1054	43	Коченевский
984	1055	43	Кочковский
985	1073	43	Краснозерский
986	1128	43	Купинский
987	1144	43	Кыштовский
988	1248	43	Маслянинский
989	1410	43	Новосибирский
990	1473	43	Ордынский
991	1704	43	Северный
992	1822	43	Сузанский
993	1871	43	Татарский
994	1911	43	Тогучинский
995	1962	43	Убинский
996	2022	43	Усть-таркский
997	2088	43	Чановский
998	2109	43	Черепановский
999	2131	43	Чистоозерный
1000	2141	43	Чулымский
1001	510	43	Г.бердск
1002	569	44	Г.омск
1003	354	44	Большереченский
1004	356	44	Большеуковский
1005	659	44	Горьковский
1006	809	44	Знаменский
1007	858	44	Исилькульский
1008	885	44	Калачинский
1009	1011	44	Колосовский
1010	1034	44	Кормиловский
1011	1104	44	Крутинский
1012	1206	44	Любинский
1013	1247	44	Марьяновский
1014	1303	44	Москалепский
1015	1312	44	Муромцевский
1016	1330	44	Называевский
1017	1365	44	Нижнеомский
1018	1385	44	Нововаршавский
1019	1439	44	Одесский
1020	1446	44	Оконешниковский
1021	1462	44	Омский
1022	1495	44	Павлоградский
1023	1561	44	Полтавский
1024	1660	44	Русско-полянский
1025	1686	44	Саргатский
1026	1712	44	Седельниковский
1027	1850	44	Таврический
1028	1865	44	Тарский
1029	1878	44	Тевризский
1030	1955	44	Тюкалинский
1031	2011	44	Усть-ишимский
1032	2112	44	Черлакский
1033	2179	44	Шербакульский
1034	572	45	Г.оренбург
1035	141	45	Абдулинский
1036	150	45	Адамовский
1037	154	45	Акбулакский
1038	216	45	Асекеевский
1039	303	45	Беляевский
1040	382	45	Бугурусланский
1041	384	45	Бузулукский
1042	625	45	Гайский
1043	662	45	Грачевский
1044	716	45	Домбаровский
1045	839	45	Илекский
1046	943	45	Кваркенский
1047	1108	45	Кувандыкский
1048	1135	45	Курманаевский
1049	1250	45	Матвеевский
1050	1401	45	Новоорский
1051	1409	45	Новосергиевский
1052	1474	45	Оренбургский
1053	1511	45	Переволоцкий
1054	1563	45	Пономаревский
1055	1671	45	Сакмарский
1056	1682	45	Саракташский
1057	1699	45	Светлинский
1058	1774	45	Соль-илецкий
1059	1777	45	Сорочинский
1060	1875	45	Ташлинский
1061	1929	45	Тоцкий
1062	1956	45	Тюльганский
1063	2157	45	Шарлыкский
1064	571	46	Г.орел
1065	347	46	Болховский
1066	447	46	Верховский
1067	638	46	Глазуновский
1068	713	46	Должанский
1069	779	46	Залегощенский
1070	1013	46	Колпнянский
1071	1103	46	Кромский
1072	1166	46	Ливенский
1073	1225	46	Малоархангельский
1074	1316	46	Мценский
1075	1390	46	Новодеревеньковский
1076	1411	46	Новосильский
1077	1479	46	Орловский
1078	1556	46	Покровский
1079	1698	46	Свердловский
1080	1995	46	Урицкий
1081	2070	46	Хотынецкий
1082	2149	46	Шаблыкинский
1083	573	47	Г.пенза
1084	274	47	Башмаковский
1085	276	47	Беднодемьяновский
1086	281	47	Бековский
1087	286	47	Белинский
1088	402	47	Вадинский
1089	652	47	Городищенский
1090	801	47	Земетчинский
1091	860	47	Иссинский
1092	901	47	Камешкирский
1093	1015	47	Колышлейский
1094	1024	47	Кондольский
1095	1114	47	Кузнецкий
1096	1182	47	Лопатинский
1097	1191	47	Лунинский
1098	1291	47	Мокшанский
1099	1334	47	Наровчатский
1100	1339	47	Неверкинский
1101	1364	47	Нижнеломовский
1102	1505	47	Пачелмский
1103	1507	47	Пензенский
1104	1726	47	Сердобский
1105	1780	47	Сосновоборский
1106	1859	47	Тамалинский
1107	2175	47	Шемышейский
1108	574	48	Г.пермь
1109	263	48	Бардымский
1110	312	48	Березовский
1111	431	48	Верещагинский
1112	623	48	Гайнский
1113	646	48	Горнозаводской
1114	710	48	Добрянский
1115	743	48	Еловский
1116	911	48	Карагайский
1117	982	48	Кишертский
1118	1043	48	Косинский
1119	1053	48	Кочевский
1120	1067	48	Красновишерский
1121	1112	48	Куединский
1122	1111	48	Кудымкарский
1123	1126	48	Кунгурский
1124	1198	48	Лысьвенский
1125	1428	48	Нытвенский
1126	1481	48	Осинский
1127	1487	48	Оханский
1128	1491	48	Очерский
1129	1517	48	Пермский
1130	1734	48	Сивинский
1131	1768	48	Соликамский
1132	1825	48	Суксунский
1133	1977	48	Уинский
1134	2086	48	Чайковский
1135	2093	48	Частинский
1136	2105	48	Чердынский
1137	2121	48	Чернушинский
1138	2144	48	Чусовской
1139	2215	48	Юрлинский
1140	2220	48	Юсьвинский
1141	577	49	Г.псков
1142	277	49	Бежаницкий
1143	423	49	Великолукский
1144	631	49	Гдовский
1145	686	49	Дедовичский
1146	705	49	Дновский
1147	1069	49	Красногородский
1148	1127	49	Куньинский
1149	1179	49	Локнянский
1150	1338	49	Невельский
1151	1405	49	Новоржевский
1152	1412	49	Новосокольнический
1153	1471	49	Опочецкий
1154	1497	49	Палкинский
1155	1532	49	Печорский
1156	1545	49	Плюсский
1157	1567	49	Порховский
1158	1602	49	Псковский
1159	1607	49	Пустошкинский
1160	1611	49	Пушкино-горский
1161	1613	49	Пыталовский
1162	1703	49	Себежский
1163	1815	49	Струго-красненский
1164	2000	49	Усвятский
1165	580	50	Г.ростов на дону
1166	153	50	Азовский
1167	156	50	Аксайский
1168	236	50	Багаевский
1169	292	50	Белокалитвинский
1170	435	50	Верхнедонский
1171	455	50	Вешенский
1172	734	50	Егорлыкский
1173	770	50	Заветинский
1174	803	50	Зерноградский
1175	806	50	Зимовниковский
1176	939	50	Кашарский
1177	1085	50	Красносулинский
1178	1245	50	Мартыновский
1179	1249	50	Матвеево-курганский
1180	1270	50	Миллеровский
1181	1273	50	Милютинский
1182	1300	50	Морозовский
1183	1319	50	Мясниковский
1184	1344	50	Неклиновский
1185	1432	50	Обливский
1186	1523	50	Песчанокопский
1187	1596	50	Пролетарский
1188	1632	50	Ремонтненский
1189	1674	50	Сальский
1190	1719	50	Семикаракорский
1191	1862	50	Тарасовский
1192	1874	50	Тацинский
1193	2009	50	Усть-донецкий
1194	2077	50	Целинский
1195	2080	50	Цимлянский
1196	2126	50	Чертковский
1197	581	51	Г.рязань
1198	753	51	Ермишинский
1199	789	51	Захаровский
1200	871	51	Кадомский
1201	928	51	Касимовский
1202	984	51	Клепиковский
1203	1030	51	Кораблинский
1204	1271	51	Милославский
1205	1389	51	Новодеревенский
1206	1539	51	Пителинский
1207	1598	51	Пронский
1208	1663	51	Рыбновский
1209	1666	51	Ряжский
1210	1667	51	Рязанский
1211	1680	51	Сапожковский
1212	1681	51	Сараевский
1213	1690	51	Сасовский
1214	1741	51	Скопинский
1215	1800	51	Старожиловский
1216	2029	51	Ухоловский
1217	2147	51	Чучковский
1218	2166	51	Шацкий
1219	2182	51	Шиловский
1220	584	52	Г.саратов
1221	207	52	Аркадакский
1222	220	52	Аткарский
1223	240	52	Базарно-карабулакски
1224	249	52	Балаковский
1225	252	52	Балашовский
1226	255	52	Балтайский
1227	486	52	Вольский
1228	691	52	Дергачевский
1229	730	52	Духовницкий
1230	737	52	Екатериновский
1231	754	52	Ершовский
1232	823	52	Ивантеевский
1233	1075	52	Краснокутский
1234	1079	52	Краснопартизанский
1235	1197	52	Лысогорский
1236	1244	52	Марксовский
1237	1384	52	Новобурасский
1238	1416	52	Новоузенский
1239	1443	52	Озинский
1240	1512	52	Перелюбский
1241	1540	52	Питерский
1242	1603	52	Пугачевский
1243	1654	52	Ртищевский
1244	1676	52	Самойловский
1245	1684	52	Саратовский
1246	1872	52	Татищевский
1247	1947	52	Турковский
1248	2035	52	Федоровский
1249	2055	52	Хвалынский
1250	2206	52	Энгельский
1251	615	53	Г.южно-сахалинск
1252	168	53	Александров-сахалинс
1253	191	53	Анивский
1254	714	53	Долинский
1255	1039	53	Корсаковский
1256	1133	53	Курильский
1257	1218	53	Макаровский
1258	1423	53	Ногликский
1259	1488	53	Охинский
1260	1566	53	Поронайский
1261	1707	53	Северо-курильский
1262	1755	53	Смирныховский
1263	1916	53	Томаринский
1264	1954	53	Тымовский
1265	1967	53	Углегорский
1266	2210	53	Южно-курильский
1267	585	54	Г.свердловск
1268	162	54	Алапаевский
1269	211	54	Артемовский
1270	212	54	Артинский
1271	147	54	Агитский
1272	241	54	Байкаловский
1273	301	54	Белоярский
1274	332	54	Богдановичский
1275	440	54	Верхнесалдинский
1276	448	54	Верхотурский
1277	627	54	Гаринский
1278	853	54	Ирбитский
1279	906	54	Камышловский
1280	1087	54	Красноуфимский
1281	1340	54	Невьянский
1282	1366	54	Нижнесергинский
1283	1395	54	Новолялинский
1284	1580	54	Пригородный
1285	1614	54	Пышминский
1286	1631	54	Режевский
1287	1730	54	Серовский
1288	1750	54	Слободо-туринский
1289	1838	54	Сухоложский
1290	1841	54	Сысертский
1291	1847	54	Таборинский
1292	1849	54	Тавдинский
1293	1855	54	Талицкий
1294	1936	54	Тугулымский
1295	1946	54	Туринский
1296	2152	54	Шалинский
1297	589	55	Г.смоленск
1298	417	55	Велижский
1299	635	55	Гжатский
1300	687	55	Демидовский
1301	717	55	Дорогобужский
1302	731	55	Духовщинский
1303	745	55	Ельнинский
1304	1297	55	Монастырщинский
1305	1650	55	Рославльский
1306	1693	55	Сафоновский
1307	1843	55	Сычевский
1308	1971	55	Угранский
1309	2060	55	Хиславичский
1310	2063	55	Холм-жирковский
1311	2198	55	Шумячский
1312	2240	55	Ярцевский
1313	593	56	Г.тамбов
1314	359	56	Бондарский
1315	759	56	Жердевский
1316	847	56	Инжавинский
1317	980	56	Кирсановский
1318	1280	56	Мичуринский
1319	1238	56	Мардовский
1320	1301	56	Моршанский
1321	1315	56	Мучкапский
1322	1370	56	Никифоровский
1323	1542	56	Пичаевский
1324	1627	56	Рассказовский
1325	1636	56	Ржаксинский
1326	1677	56	Сампурский
1327	1811	56	Староюрьевский
1328	1913	56	Токаревский
1329	1963	56	Уваровский
1330	1987	56	Уметский
1331	595	57	Г.томск
1332	217	57	Асиновский
1333	247	57	Бакчарский
1334	437	57	Верхнекетский
1335	817	57	Зырянский
1336	920	57	Каргасокский
1337	1001	57	Кожевниковский
1338	1012	57	Колпашевский
1339	1100	57	Кривошеинский
1340	1293	57	Молчановский
1341	1501	57	Парабельский
1342	1879	57	Тегульдетский
1343	1919	57	Томский
1344	2085	57	Чаинский
1345	2170	57	Шегарский
1346	596	58	Г.тула
1347	171	58	Алексинский
1348	209	58	Арсеньевский
1349	285	58	Белевский
1350	334	58	Богородицкий
1351	430	58	Веневский
1352	721	58	Дубенский
1353	756	58	Ефремовский
1354	783	58	Заокский
1355	966	58	Кимовский
1356	972	58	Киреевский
1357	1134	58	Куркинский
1358	1398	58	Новомосковский
1359	1441	58	Одоевский
1360	1543	58	Плавский
1361	1818	58	Суворовский
1362	1888	58	Тепло-огоревский
1363	1976	58	Узловский
1364	2119	58	Чернский
1365	2201	58	Щекинский
1366	2242	58	Ясногорский
1367	527	58	Г.донской
1368	598	59	Г.тюмень
1369	140	59	Абатский
1370	208	59	Армизонский
1371	305	59	Бердюжский
1372	401	59	Вагайский
1373	458	59	Викуловский
1374	645	59	Голышмановский
1375	772	59	Заводоуковский
1376	857	59	Исетский
1377	865	59	Ишимский
1378	875	59	Казанский
1379	1023	59	Кондинский
1380	1082	59	Красноселькупский
1381	1327	59	Надымский
1382	1357	59	Нижневартовский
1383	1368	59	Нижнетавдинский
1384	1464	59	Омутинский
1385	1592	59	Приуральский
1386	1605	59	Пуровский
1387	1747	59	Сладковский
1388	1831	59	Сургутский
1389	1851	59	Тазовский
1390	1909	59	Тобольский
1391	1957	59	Тюменский
1392	1964	59	Уватский
1393	1991	59	Упоровский
1394	2047	59	Ханты-мансийский
1395	2199	59	Шурышкарский
1396	2229	59	Ялуторовский
1397	2231	59	Ямальский
1398	2236	59	Ярковский
1399	601	60	Г.ульяновск
1400	267	60	Барышский
1401	456	60	Вешкаймский
1402	848	60	Инзенский
1403	925	60	Карсунский
1404	1115	60	Кузоватовский
1405	1216	60	Майнский
1406	1261	60	Мелекесский
1407	1396	60	Новомалыклинский
1408	1413	60	Новоспасский
1409	1618	60	Радищевский
1410	1721	60	Сенгилеевский
1411	1802	60	Старокулаткинский
1412	1803	60	Старомайнский
1413	1833	60	Сурский
1414	1891	60	Тереньгульский
1415	2079	60	Цильнинский
1416	2104	60	Чердаклинский
1417	609	61	Г.челябинск
1418	145	61	Агаповский
1419	202	61	Аргаяшский
1420	229	61	Ашинсский
1421	374	61	Брединский
1422	410	61	Варненский
1423	442	61	Верхнеуральский
1424	755	61	Еткульский
1425	926	61	Карталинский
1426	929	61	Каслинский
1427	933	61	Катав-ивановский
1428	957	61	Кизильский
1429	1125	61	Кунашакский
1430	1139	61	Кусинский
1431	1322	61	Нагайбакский
1432	1430	61	Нязепетровский
1433	1691	61	Саткинский
1434	1965	61	Увельский
1435	1978	61	Уйский
1436	2095	61	Чебаркульский
1437	2127	61	Чесменский
1438	613	62	Г.чита
1439	160	62	Акшинский
1440	254	62	Балейский
1441	360	62	Борзинский
1442	727	62	Дульдургинский
1443	769	62	Забайкальский
1444	882	62	Каларский
1445	886	62	Калганский
1446	927	62	Карымский
1447	1090	62	Красночикойский
1448	1142	62	Кыринский
1449	1285	62	Могойтуйский
1450	1286	62	Могочинский
1451	1352	62	Нерчинский
1452	1453	62	Оловянинский
1453	1468	62	Ононский
1454	1577	62	Приаргунский
1455	1790	62	Сретенский
1456	1941	62	Тунгиро-олекминский
1457	1942	62	Тунгокоченский
1458	1982	62	Улетовский
1459	2122	62	Чернышевский
1460	2133	62	Читинский
1461	2173	62	Шелопугинский
1462	2181	62	Шилкинский
1463	617	63	Г.ярославль
1464	355	63	Большесельский
1465	375	63	Брейтовский
1587	246	67	Баксанский
1466	618	63	Гаврилов-ямской
1467	1205	63	Любимский
1468	1318	63	Мышкинский
1469	1345	63	Некоузский
1470	1346	63	Некрасовский
1471	1514	63	Переславский
1472	1572	63	Пошехонский
1473	1653	63	Ростовский
1474	1951	63	Тутаевский
1475	1968	63	Угличский
1476	2238	63	Ярославский
1477	602	64	Г.уфа
1478	142	64	Абзелиловский
1479	181	64	Альшеевский
1480	213	64	Архангельский
1481	219	64	Аскинский
1482	223	64	Аургазинский
1483	243	64	Баймакский
1484	245	64	Бакалинский
1485	257	64	Балтачевский
1486	284	64	Белебеевский
1487	293	64	Белокатайский
1488	297	64	Белорецкий
1489	316	64	Бижбулякский
1490	322	64	Бирский
1491	324	64	Благоварский
1492	383	64	Буздякский
1493	389	64	Бураевский
1494	391	64	Бурзянский
1495	629	64	Гафурийский
1496	677	64	Давлекановский
1497	726	64	Дуванский
1498	732	64	Дюртюлинский
1499	804	64	Зианчуринский
1500	805	64	Зилаирский
1501	825	64	Иглинский
1502	841	64	Илишевский
1503	864	64	Ишимбайский
1504	891	64	Калтасинский
1505	913	64	Караидельский
1506	924	64	Кармаскалинский
1507	953	64	Кигинский
1508	1110	64	Кугарчинский
1509	1123	64	Кумертауский
1510	1140	64	Кушнаренковский
1511	1263	64	Мелеузовский
1512	1268	64	Мечетлинский
1513	1282	64	Миякинский
1514	1427	64	Нуримановский
1515	1673	64	Салаватский
1516	1812	64	Стерлибашевский
1517	1813	64	Стерлитамакский
1518	1873	64	Татышлинский
1519	1938	64	Туймазинский
1520	2028	64	Уфимский
1521	2030	64	Учалинский
1522	2044	64	Хайбуллинский
1523	2099	64	Чекмагушевский
1524	2134	64	Чишминский
1525	2154	64	Шаранский
1526	2233	64	Янаульский
1527	600	65	Г.улан-уде
1528	262	65	Баргузинский
1529	271	65	Баунтовский
1530	323	65	Бичурский
1531	694	65	Джидинский
1532	751	65	Еравнинский
1533	776	65	Заиграевский
1534	777	65	Закаменский
1535	867	65	Кабанский
1536	956	65	Кижингинский
1537	1145	65	Кяхтинский
1538	1314	65	Мухоршибирский
1539	1445	65	Окинский
1540	1578	65	Прибайкальский
1541	1705	65	Северо-байкальский
1542	1714	65	Селенгинский
1543	1944	65	Тункинский
1544	1981	65	Улан-удэнский
1545	2067	65	Хоринский
1546	558	66	Г.махачкала
1547	149	66	Агульский
1548	159	66	Акушинский
1549	225	66	Ахвахский
1550	226	66	Ахтынский
1551	232	66	Бабаюртовский
1552	370	66	Ботлихский
1553	386	66	Буйнакский
1554	634	66	Гергебильский
1555	671	66	Гумбетовский
1556	672	66	Гунибский
1557	683	66	Дахадаевский
1558	690	66	Дербентский
1559	879	66	Казбековский
1560	880	66	Кайтагский
1561	932	66	Касумкентский
1562	942	66	Каякентский
1563	958	66	Кизилюртовский
1564	959	66	Кизлярский
1565	1120	66	Кулинский
1566	1131	66	Курахский
1567	1149	66	Лакский
1568	1155	66	Левашинский
1569	1211	66	Магарамкентский
1570	1394	66	Новолакский
1571	1421	66	Ногайский
1572	1661	66	Рутульский
1573	1725	66	Сергокалинский
1574	1846	66	Табасаранский
1575	1866	66	Тарумовский
1576	1908	66	Тляратинский
1577	1990	66	Унцукульский
1578	2051	66	Хасавюртовский
1579	2043	66	Хавский
1580	2073	66	Хунзахский
1581	2081	66	Цумадинский
1582	2082	66	Цунтинский
1583	2091	66	Чародинский
1584	533	66	Г.избербаш
1585	541	66	Г.каспийск
1586	562	67	Г.нальчик
1588	813	67	Зольский
1589	1217	67	Майский
1590	1599	67	Прохладненский
1591	1992	67	Урванский
1592	2098	67	Чегемский
1593	597	67	Г.тырныауз
1594	614	68	Г.элиста
1595	654	68	Городовиковский
1596	836	68	Ики-бурульский
1597	930	68	Каспийский
1598	1587	68	Приозерный
1599	1593	68	Приютненский
1600	1689	68	Сарпинский
1601	2116	68	Черноземельный
1602	2219	68	Юстинский
1603	2243	68	Яшалтинский
1604	2245	68	Яшкульский
1605	575	69	Г.петрозаводск
1606	295	69	Беломорский
1607	887	69	Калевальский
1608	949	69	Кемский
1609	1025	69	Кондопожский
1610	1184	69	Лоухский
1611	1255	69	Медвежьегорский
1612	1307	69	Муезерский
1613	1454	69	Олонецкий
1614	1541	69	Питкяранский
1615	1589	69	Прионежский
1616	1601	69	Пряжинский
1617	1604	69	Пудожский
1618	1711	69	Сегежский
1619	1778	69	Сортавальский
1620	1829	69	Суоярвский
1621	592	70	Г.сыктывкар
1622	829	70	Ижемский
1623	993	70	Княжпогостский
1624	1007	70	Койгородский
1625	1041	70	Корткеросский
1626	1583	70	Прилузский
1627	1840	70	Сыктывдвинский
1628	1842	70	Сысольский
1629	1932	70	Троицко-печорский
1630	1973	70	Удорский
1631	2008	70	Усть-вымский
1632	2017	70	Усть-куломский
1633	2024	70	Усть-цилемский
1634	520	70	Г.воркута
1635	534	70	Г.инта
1636	603	70	Г.ухта
1637	537	71	Г.йошкар-ола
1638	647	71	Горномарийский
1639	793	71	Звениговский
1640	963	71	Килемарский
1641	1113	71	Куженерский
1642	1242	71	Мари-турекский
1643	1254	71	Медведевский
1644	1299	71	Моркинский
1645	1414	71	Новоторъяльский
1646	1480	71	Оршанский
1647	1502	71	Параньгинский
1648	1729	71	Сернурский
1649	583	72	Г.саранск
1650	221	72	Атюрьевский
1651	222	72	Атяшевский
1652	348	72	Большеберезниковский
1653	351	72	Большеигнатовский
1654	744	72	Ельниковский
1655	814	72	Зубово-полянский
1656	849	72	Инсарский
1657	863	72	Ичалковский
1658	999	72	Ковылкинский
1659	1056	72	Кочкуровский
1660	1084	72	Краснослободский
1661	1210	72	Лямбирский
1662	1649	72	Ромодановский
1663	1658	72	Рузаевский
1664	1810	72	Старошайговский
1665	1882	72	Темниковский
1666	1884	72	Теньгушевский
1667	1924	72	Торбеевский
1668	2087	72	Чамзинский
1669	570	73	Г.орджоникидзе
1670	161	73	Алагирский
1671	204	73	Ардонский
1672	698	73	Дигорский
1673	851	73	Ирафский
1674	1289	73	Моздокский
1675	1574	73	Правобережный
1676	538	74	Г.казань
1677	148	74	Агрызский
1678	152	74	Азнакаевский
1679	157	74	Аксубаевский
1680	158	74	Актанышский
1681	178	74	Алькеевский
1682	180	74	Альметьевский
1683	197	74	Апастовский
1684	210	74	Арский
1685	235	74	Бавлинский
1686	256	74	Балтасинский
1687	381	74	Бугульминский
1688	385	74	Буинский
1689	443	74	Верхнеуслонский
1690	497	74	Высокогорский
1691	720	74	Дрожжановский
1692	738	74	Елабужский
1693	799	74	Зеленодольский
1694	903	74	Камско-устьинский
1695	1118	74	Кукморский
1696	1148	74	Лаишевский
1697	1159	74	Лениногорский
1698	1231	74	Мамадышский
1699	1266	74	Мензелинский
1700	1313	74	Муслюмовский
1701	1362	74	Нижнекамский
1702	1521	74	Пестречинский
1703	1664	74	Рыбно-слободский
1704	1668	74	Сабинский
1705	1687	74	Сармановский
1706	1899	74	Тетюшский
1707	2100	74	Челнинский
1708	2108	74	Черемшанский
1709	2132	74	Чистопольский
1710	561	74	Г.набережные челны
1711	551	75	Г.кызыл
1712	244	75	Бай-тайгинский
1713	265	75	Барун-хемчикский
1714	696	75	Дзун-хемчикский
1715	866	75	Каа-хемский
1716	1438	75	Овюрский
1717	1534	75	Пий-хемский
1718	1861	75	Тандинский
1719	1896	75	Тес-хемский
1720	1912	75	Тоджинский
1721	1983	75	Улуг-хемский
1722	2207	75	Эрзинский
1723	532	76	Г.ижевск
1724	176	76	Алнашский
1725	253	76	Балезинский
1726	400	76	Вавожский
1727	489	76	Воткинский
1728	637	76	Глазовский
1729	661	76	Граховский
1730	685	76	Дебесский
1731	827	76	Игринский
1732	895	76	Камбарский
1733	914	76	Каракулинский
1734	946	76	Кезский
1735	960	76	Кизнерский
1736	983	76	Киясовский
1737	1229	76	Малопургинский
1738	1288	76	Можгинский
1739	1683	76	Сарапульский
1740	1717	76	Селтинский
1741	1844	76	Сюмсинский
1742	1966	76	Увинский
1743	2156	76	Шарканский
1744	2212	76	Юкаменский
1745	2228	76	Якшур-бодьинский
1746	2239	76	Ярский
1747	523	77	Г.грозный
1748	228	77	Ачхой-мартановский
1749	415	77	Веденский
1750	665	77	Грозненский
1751	669	77	Гудермесский
1752	1222	77	Малгобекский
1753	1326	77	Надтеречный
1754	1329	77	Назрановский
1755	1337	77	Наурский
1756	1424	77	Ножай-юртовский
1757	1827	77	Сунженский
1758	1998	77	Урус-мартановский
1759	2172	77	Шелковский
1760	608	171	Г.чебоксары
1761	164	171	Алатырский
1762	174	171	Аликовский
1763	270	171	Батыревский
1764	493	171	Вурнарский
1765	818	171	Ибресинский
1766	907	171	Канашский
1767	1005	171	Козловский
1768	1089	171	Красночетайский
1769	1241	171	Мариинско-посадский
1770	1298	171	Моргаушский
1771	1565	171	Порецкий
1772	1996	171	Урмарский
1773	2078	171	Цивильский
1774	2096	171	Чебоксарский
1775	2174	171	Шемуршинский
1776	2195	171	Шумерлинский
1777	2225	171	Ядринский
1778	2230	171	Яльчикский
1779	2234	171	Янтиковский
1780	616	79	Г.якутск
1781	144	79	Абыйский
1782	165	79	Алданский
1783	175	79	Аллаиховский
1784	183	79	Амгинский
1785	185	79	Анабарский
1786	388	79	Булунский
1787	433	79	Верхневилюйский
1788	438	79	Верхнеколымский
1789	450	79	Верхоянский
1790	460	79	Вилюйский
1791	649	79	Горный
1792	761	79	Жиганский
1793	995	79	Кобяйский
1794	1253	79	Мегино-кангаласский
1795	1277	79	Мирнинский
1796	1294	79	Момский
1797	1331	79	Намский
1798	1363	79	Нижнеколымский
1799	1444	79	Оймяконский
1800	1450	79	Олекминский
1801	1451	79	Оленекский
1802	1789	79	Среднеколымский
1803	1828	79	Сунтарский
1804	1918	79	Томпонский
1805	2006	79	Усть-алданский
1806	2020	79	Усть-майский
1807	2026	79	Усть-янский
1808	2143	79	Чурапчинский
1809	514	95	Г.винница
1810	264	95	Барский
1811	315	95	Бершадский
1812	461	95	Винницкий
1813	624	95	Гайсинский
1814	766	95	Жмеринский
1815	843	95	Ильинецкий
1816	876	95	Казатинский
1817	889	95	Калиновский
1818	1105	95	Крыжопольский
1819	1169	95	Липовецкий
1820	1173	95	Литинский
1821	1284	95	Могилев-подольский
1822	1310	95	Мурованокуриловецкий
1823	1349	95	Немировский
1824	1524	95	Песчанский
1825	1548	95	Погребищенский
1826	1887	95	Тепликский
1827	1917	95	Томашпольский
1828	1933	95	Тростянецкий
1829	1940	95	Тульчинский
1830	1952	95	Тывровский
1831	2062	95	Хмельницкий
1832	2129	95	Чечельницкий
1833	2155	95	Шаргородский
1834	2232	95	Ямпольский
1835	555	96	Г.луцк
1836	465	96	Владимир-волынский
1837	657	96	Гороховский
1838	819	96	Иваничевский
1839	900	96	Камень-каширский
1840	952	96	Киверцовский
1841	996	96	Ковельский
1842	1178	96	Локачинский
1843	1195	96	Луцкий
1844	1204	96	Любешовский
1845	1207	96	Любомльский
1846	1234	96	Маневичский
1847	1628	96	Ратновский
1848	1643	96	Рожищенский
1849	1798	96	Старовыжевский
1850	1945	96	Турийский
1851	525	97	Г.днепропетровск
1852	198	97	Апостоловский
1853	412	97	Васильковский
1854	434	97	Верхнеднепровский
1855	704	97	Днепропетровский
1856	1099	97	Криворожский
1857	1101	97	Криничанский
1858	1212	97	Магдалиновский
1859	1373	97	Никопольский
1860	1616	97	Пятихатский
1861	1736	97	Синельниковский
1862	1772	97	Солонянский
1863	1782	97	Софиевский
1864	1915	97	Томаковский
1865	2075	97	Царичанский
1866	2186	97	Широковский
1867	526	98	Г.донецк
1868	182	98	Амвросиевский
1869	425	98	Великоновоселковский
1870	471	98	Волновахский
1871	709	98	Добропольский
1872	1076	98	Краснолиманский
1873	1246	98	Марьинский
1874	1378	98	Новоазовский
1875	1518	98	Першотравневый
1876	1797	98	Старобешевский
1877	1881	98	Тельмановский
1878	2164	98	Шахтерский
1879	2241	98	Ясиноватский
1880	528	99	Г.житомир
1881	190	99	Андрушевский
1882	260	99	Барановский
1883	304	99	Бердичевский
1884	476	99	Володарско-волынский
1885	748	99	Емильчинский
1886	765	99	Житомирский
1887	1036	99	Коростенский
1888	1037	99	Коростышевский
1889	1187	99	Лугинский
1890	1201	99	Любарский
1891	1223	99	Малинский
1892	1335	99	Народичский
1893	1388	99	Новоград-волынский
1894	1437	99	Овручский
1895	1449	99	Олевский
1896	1564	99	Попельнянский
1897	1619	99	Радомышльский
1898	1657	99	Ружинский
1899	2103	99	Червоноармейский
1900	2138	99	Чудновский
1901	599	100	Г.ужгород
1902	307	100	Береговский
1903	420	100	Великоберезнянский
1904	472	100	Воловецкий
1905	855	100	Иршавский
1906	1257	100	Межгорский
1907	1308	100	Мукачевский
1908	1516	100	Перечинский
1909	1629	100	Раховский
1910	1696	100	Свалявский
1911	1961	100	Тячевский
1912	1974	100	Ужгородский
1913	2074	100	Хустский
1914	529	101	Г.запорожье
1915	155	101	Акимовский
1916	306	101	Бердянский
1917	411	101	Васильевский
1918	452	101	Веселовский
1919	485	101	Вольнянский
1920	670	101	Гуляйпольский
1921	785	101	Запорожский
1922	899	101	Каменско-днепровский
1923	1264	101	Мелитопольский
1924	1476	101	Ореховский
1925	1559	101	Пологовский
1926	1576	101	Приазовский
1927	1914	101	Токмакский
1928	531	102	Г.ивано-франковск
1929	336	102	Богородчанский
1930	446	102	Верховинский
1931	650	102	Городенковский
1932	821	102	Иваново-франковский
1933	893	102	Калушский
1934	1010	102	Коломыйский
1935	1045	102	Косовский
1936	1324	102	Надворнянский
1937	1640	102	Рогатинский
1938	1644	102	Рожнятовский
1939	1758	102	Снятынский
1940	1907	102	Тлумачский
1941	543	103	Г.киев
1942	266	103	Барышевский
1943	300	103	Белоцерковский
1944	340	103	Богуславский
1945	364	103	Бориспольский
1946	367	103	Бородянский
1947	376	103	Броварский
1948	820	103	Иванковский
1949	870	103	Кагарлыкский
1950	955	103	Киево-святошинский
1951	1278	103	Мироновский
1952	1435	103	Обуховский
1953	1515	103	Переслав-хмельницкий
1954	1622	103	Ракитнянский
1955	1738	103	Сквирский
1956	1791	103	Ставищенский
1957	1863	103	Таращанский
1958	1897	103	Тетиевский
1959	2033	103	Фастовский
1960	2115	103	Чернобыльский
1961	2224	103	Яготинский
1962	536	103	Г.ирпень
1963	167	104	Александрийский
1964	328	104	Бобринецкий
1965	622	104	Гайворонский
1966	643	104	Голованевский
1967	707	104	Добровеличковский
1968	977	104	Кировоградский
1969	1020	104	Компанеевский
1970	1093	104	Кремгэсовский
1971	1226	104	Маловисковский
1972	1374	104	Новгородковский
1973	1382	104	Новоархангельский
1974	1397	104	Новомиргородский
1975	1417	104	Новоукраинский
1976	1460	104	Ольшанский
1977	1469	104	Онуфриевский
1978	2004	104	Устиновский
1979	588	105	Г.симферополь
1980	273	105	Бахчисарайский
1981	692	105	Джанкойский
1982	1080	105	Красноперекопский
1983	1358	105	Нижнегорский
1984	1621	105	Раздольненский
1985	1672	105	Сакский
1986	1735	105	Симферопольский
1987	2117	105	Черноморский
1988	554	106	Г.луганск
1989	193	106	Антрацитовский
1990	287	106	Беловодский
1991	294	106	Белокуракинский
1992	1072	106	Краснодонский
1993	1095	106	Кременский
1994	1171	106	Лисичанский
1995	1192	106	Лутугинский
1996	1243	106	Марковский
1997	1265	106	Меловский
1998	1379	106	Новоайдарский
1999	1404	106	Новопсковский
2000	1509	106	Перевальский
2001	1697	106	Сватовский
2002	1745	106	Славяносербский
2003	1793	106	Станично-луганский
2004	1796	106	Старобельский
2005	556	107	Г.львов
2006	377	107	Бродовский
2007	394	107	Бусский
2008	655	107	Городокский
2009	719	107	Дрогобычский
2010	762	107	Жидачовский
2011	812	107	Золочевский
2012	898	107	Каменско-бугский
2013	1304	107	Мостисский
2014	1513	107	Перемышлянский
2015	1606	107	Пустомытовский
2016	1617	107	Радеховский
2017	1675	107	Самборский
2018	1740	107	Сколевский
2019	1763	107	Сокальский
2020	1808	107	Старосамборский
2021	1816	107	Стрыйский
2022	2222	107	Яворовский
2023	564	108	Г.николаев
2024	201	108	Арбузинский
2025	275	108	Баштанский
2026	309	108	Березанский
2027	310	108	Березнеговатский
2028	451	108	Веселиновский
2029	491	108	Врадиевский
2030	715	108	Доманевский
2031	739	108	Еланецкий
2032	767	108	Жовтневый
2033	874	108	Казанковский
2034	1098	108	Кривоозерский
2035	1383	108	Новобугский
2036	1400	108	Новоодесский
2037	1490	108	Очаковский
2038	1757	108	Снигиревский
2039	568	109	Г.одесса
2040	187	109	Ананьевский
2041	215	109	Арцизский
2042	258	109	Балтский
2043	282	109	Белгород-днестровски
2044	344	109	Болградский
2045	424	109	Великомихайловский
2046	831	109	Измаильский
2047	964	109	Килийский
2048	1000	109	Кодымский
2049	1019	109	Коминтерновский
2050	1077	109	Красноокнянский
2051	1202	109	Любашевский
2052	1436	109	Овидиопольский
2053	1620	109	Раздельнянский
2054	1670	109	Савранский
2055	1685	109	Саратский
2056	1868	109	Тарутинский
2057	1870	109	Татарбунарский
2058	2038	109	Фрунзовский
2059	2187	109	Ширяевский
2060	578	109	Г.рени
2061	576	110	Г.полтава
2062	419	110	Великобагачанский
2063	621	110	Гадячский
2064	639	110	Глобинский
2065	663	110	Гребенковский
2066	699	110	Диканьский
2067	802	110	Зеньковский
2068	923	110	Карловский
2069	994	110	Кобелякский
2070	1004	110	Козельщинский
2071	1048	110	Котелевский
2072	1096	110	Кременчугский
2073	1185	110	Лохвицкий
2074	1186	110	Лубенский
2075	1251	110	Машевский
2076	1276	110	Миргородский
2077	1406	110	Новосанжарский
2078	1477	110	Оржицкий
2079	1538	110	Пирятинский
2080	1635	110	Решетиловский
2081	2120	110	Чернухинский
2082	2145	110	Чутовский
2083	2188	110	Шишацкий
2084	579	111	Г.ровно
2085	311	111	Березновский
2086	466	111	Владимирецкий
2087	660	111	Гошанский
2088	722	111	Дубновский
2089	724	111	Дубровицкий
2090	787	111	Заречненский
2091	796	111	Здолбуновский
2092	1033	111	Корецкий
2093	1046	111	Костопольский
2094	1283	111	Млиновский
2095	1485	111	Острожский
2096	1638	111	Ровенский
2097	1645	111	Рокитновский
2098	1688	111	Сарненский
2099	591	112	Г.сумы
2100	227	112	Ахтырский
2101	296	112	Белопольский
2102	393	112	Бурынский
2103	426	112	Великописаревский
2104	640	112	Глуховский
2105	1026	112	Конотопский
2106	1081	112	Краснопольский
2107	1102	112	Кролевецкий
2108	1151	112	Лебединский
2109	1170	112	Липоводолинский
2110	1341	112	Недригайловский
2111	1608	112	Путивльский
2112	1647	112	Роменский
2113	1728	112	Середино-будский
2114	1826	112	Сумский
2115	2191	112	Шосткинский
2116	594	113	Г.тернополь
2117	308	113	Бережанский
2118	369	113	Борщевский
2119	380	113	Бугачский
2120	676	113	Гусятинский
2121	781	113	Залещицкий
2122	791	113	Збаражский
2123	792	113	Зборовский
2124	1006	113	Козовский
2125	1094	113	Кременецкий
2126	1150	113	Лановецкий
2127	1295	113	Монастырисский
2128	1549	113	Подволочисский
2129	1890	113	Теребовлянский
2130	1894	113	Тернопольский
2131	2136	113	Чортковский
2132	2197	113	Шумский
2133	605	114	Г.харьков
2134	248	114	Балаклейский
2135	261	114	Барвенковский
2136	327	114	Близнюковский
2137	333	114	Богодуховский
2138	405	114	Валковский
2139	421	114	Великобурлукский
2140	483	114	Волчанский
2141	684	114	Двуречанский
2142	790	114	Зачепиловский
2143	808	114	Змиевский
2144	834	114	Изюмский
2145	944	114	Кегичевский
2146	1071	114	Красноградский
2147	1129	114	Купянский
2148	1177	114	Лозовский
2149	1386	114	Нововодолажский
2150	1694	114	Сахновщинский
2151	2050	114	Харьковский
2152	2169	114	Шевченковский
2153	606	115	Г.херсон
2154	314	115	Бериславский
2155	418	115	Велико-александровск
2156	422	115	Великолепетихский
2157	439	115	Верхнерогачикский
2158	498	115	Высокопольский
2159	632	115	Генический
2160	644	115	Голопристанский
2161	648	115	Горностаевский
2162	881	115	Каланчакский
2163	937	115	Каховский
2164	1367	115	Нижнесерогозский
2165	1387	115	Нововоронцовский
2166	1415	115	Новотроицкий
2167	1737	115	Скадовский
2168	2083	115	Цюрупинский
2169	2089	115	Чаплинский
2170	607	116	Г.хмельницкий
2171	463	116	Виньковецкий
2172	481	116	Волочисский
2173	689	116	Деражнянский
2174	729	116	Дунаевецкий
2175	835	116	Изяславский
2176	896	116	Каменец-подольский
2177	1062	116	Красиловский
2178	1164	116	Летичевский
2179	1419	116	Новоушицкий
2180	1560	116	Полонский
2181	1744	116	Славутский
2182	1801	116	Староконстантиновски
2183	1809	116	Старосинявский
2184	1886	116	Теофипольский
2185	2102	116	Чемеровецкий
2186	2178	116	Шепетовский
2187	2237	116	Ярмолинецкий
2188	610	117	Г.черкассы
2189	718	117	Драбовский
2190	757	117	Жашковский
2191	794	117	Звенигородский
2192	810	117	Золотоношский
2193	936	117	Катеринопольский
2194	1040	117	Корсунь-шевченковски
2195	1199	117	Лысянский
2196	1237	117	Маньковский
2197	1296	117	Монастырищенский
2198	1753	117	Смелянский
2199	1858	117	Тальновский
2200	1986	117	Уманский
2201	2072	117	Христиновский
2202	2111	117	Черкасский
2203	2114	117	Чернобаевский
2204	2130	117	Чигиринский
2205	2193	117	Шполянский
2206	611	118	Г.чернигов
2207	272	118	Бахмачский
2208	329	118	Бобровицкий
2209	361	118	Борзнянский
2210	407	118	Варвинский
2211	653	118	Городнянский
2212	826	118	Игнянский
2213	1002	118	Козелецкий
2214	1035	118	Коропский
2215	1042	118	Корюковский
2216	1119	118	Куликовский
2217	1267	118	Менский
2218	1342	118	Нежинский
2219	1375	118	Новгород-северский
2220	1426	118	Носовский
2221	1584	118	Прилукский
2222	1633	118	Репкинский
2223	1779	118	Сосницкий
2224	1786	118	Сребнянский
2225	1853	118	Талалаевский
2226	2204	118	Щорский
2227	612	119	Г.черновцы
2228	457	119	Вижницкий
2229	642	119	Глыбокский
2230	788	119	Заставновский
2231	947	119	Кельменецкий
2232	981	119	Кицманский
2233	1407	119	Новоселицкий
2234	1609	119	Путильский
2235	1764	119	Сокирянский
2236	1814	119	Сторожинецкий
2237	2069	119	Хотинский
2238	12	1	Буда-кошелевский
2239	85	6	Московский
2240	2246	7	Г.барановичи
2241	2247	104	Подвысоцкий
2242	2248	64	Юмагузинский
2243	2249	99	Потиевский
2244	2250	7	-
2245	2251	2	-
2246	2252	1	-
2247	2253	5	-
2248	2254	3	-
2249	2255	4	-
2250	2256	85	-
2251	2257	9	-
2252	2258	15	-
2253	2259	16	-
2254	2260	17	-
2255	2261	64	-
2256	2262	18	-
2257	2263	19	-
2258	2264	65	-
2259	2265	20	-
2260	2266	21	-
2261	2267	22	-
2262	2268	23	-
2263	2269	66	-
2264	2270	84	-
2265	2271	25	-
2266	2272	80	-
2267	2273	26	-
2268	2274	67	-
2269	2275	27	-
2270	2276	68	-
2271	2277	29	-
2272	2278	30	-
2273	2279	81	-
2274	2280	69	-
2275	2281	31	-
2276	2282	32	-
2277	2283	70	-
2278	2284	86	-
2279	2285	87	-
2280	2286	33	-
2281	2287	10	-
2282	2288	11	-
2283	2289	35	-
2284	2290	36	-
2285	2291	37	-
2286	2292	38	-
2287	2293	39	-
2288	2294	71	-
2289	2295	72	-
2290	2296	40	-
2291	2297	41	-
2292	2298	88	-
2293	2299	24	-
2294	2300	42	-
2295	2301	43	-
2296	2302	44	-
2297	2303	45	-
2298	2304	46	-
2299	2305	47	-
2300	2306	48	-
2301	2307	12	-
2302	2308	49	-
2303	2309	50	-
2304	2310	51	-
2305	2311	34	-
2306	2312	83	-
2307	2313	52	-
2308	2314	53	-
2309	2315	54	-
2310	2316	73	-
2311	2317	55	-
2312	2318	13	-
2313	2319	89	-
2314	2320	56	-
2315	2321	74	-
2316	2322	28	-
2317	2323	57	-
2318	2324	75	-
2319	2325	58	-
2320	2326	59	-
2321	2327	76	-
2322	2328	60	-
2323	2329	90	-
2324	2330	14	-
2325	2331	91	-
2326	2332	61	-
2327	2333	77	-
2328	2334	62	-
2329	2335	171	-
2330	2336	78	-
2331	2337	92	-
2332	2338	93	-
2333	2339	79	-
2334	2340	94	-
2335	2341	63	-
2336	2342	82	-
2337	2343	124	-
2338	2344	341	-
2339	2345	95	-
2340	2346	96	-
2341	2347	97	-
2342	2348	98	-
2343	2349	99	-
2344	2350	100	-
2345	2351	101	-
2346	2352	102	-
2347	2353	103	-
2348	2354	104	-
2349	2355	105	-
2350	2356	106	-
2351	2357	107	-
2352	2358	108	-
2353	2359	109	-
2354	2360	110	-
2355	2361	111	-
2356	2362	112	-
2357	2363	113	-
2358	2364	114	-
2359	2365	115	-
2360	2366	116	-
2361	2367	117	-
2362	2368	118	-
2363	2369	119	-
2364	2370	137	-
2365	2371	140	-
2366	2372	138	-
2367	2373	139	-
2368	2374	141	-
2369	2375	342	-
2370	2376	125	-
2371	2377	126	-
2372	2378	127	-
2373	2379	128	-
2374	2380	129	-
2375	2381	130	-
2376	2382	131	-
2377	2383	132	-
2378	2384	133	-
2379	2385	134	-
2380	2386	135	-
2381	2387	136	-
2382	2388	343	-
2383	2389	343	-
2384	2390	344	-
2385	2391	148	-
2386	2392	147	-
2387	2393	149	-
2388	2394	150	-
2389	2395	151	-
2390	2396	152	-
2391	2397	153	-
2392	2398	154	-
2393	2399	155	-
2394	2400	156	-
2395	2401	157	-
2396	2402	158	-
2397	2403	159	-
2398	2404	160	-
2399	2405	161	-
2400	2406	162	-
2401	2407	163	-
2402	2408	164	-
2403	2409	165	-
2404	2410	345	-
2405	2411	346	-
2406	2412	347	-
2407	2413	348	-
2408	2414	349	-
2409	2415	350	-
2410	2416	352	-
2411	2417	351	-
2412	2418	353	-
2413	2420	354	-
2414	2421	355	-
2415	2422	8	Неизвестен
2418	92	2	Г. Новополоцк
2417	2424	2	Г.Орша
2416	2423	7	Г.Пинск
\.


--
-- Data for Name: common_geocountry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_geocountry (id, obid, name) FROM stdin;
1	1	Беларусь
2	22	Польша
3	5	Бельгия
4	25	Словакия
5	33	Эстония
6	32	Чехия
7	18	Молдавия
8	28	Узбекистан
9	29	Украина
10	2	Австрия
11	16	Латвия
12	3	Азербайджан
13	19	Молдова
14	4	Армения
15	14	Казахстан
16	30	Финляндия
17	8	Венгрия
18	13	Италия
19	10	Грузия
20	9	Германия
21	17	Литва
22	12	Испания
23	27	Тукменистан
24	26	Таджикистан
25	6	Болгария
26	21	Норвегия
27	15	Кыргызстан
28	34	Югославия
29	24	Румыния
30	31	Франция
31	11	Дания
32	7	Великобритания
33	23	Россия
34	20	Неизвестно
35	35	-
\.


--
-- Data for Name: common_georegion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_georegion (id, obid, country_id, name) FROM stdin;
1	4	1	Гомельская
2	2	1	Витебская
3	6	1	Минская
4	7	1	Могилевская
5	5	1	Гродненская
6	3	1	Г.минск
7	1	1	Брестская
8	182	34	Неизвестно
9	16	33	Алтайский
10	134	33	Краснодарский
11	135	33	Красноярский
12	216	33	Приморский
13	256	33	Ставропольский
14	300	33	Хабаровский
15	18	33	Амурская
16	21	33	Архангельская
17	22	33	Астраханская
18	30	33	Белгородская
19	37	33	Брянская
20	54	33	Владимирская
21	55	33	Волгоградская
22	56	33	Вологодская
23	58	33	Воронежская
24	184	33	Нижегородская
25	87	33	Ивановская
26	93	33	Иркутская
27	102	33	Калининградская
28	274	33	Тверская
29	104	33	Калужская
30	105	33	Камчатская
31	116	33	Кемеровская
32	121	33	Кировская
33	129	33	Костромская
34	241	33	Самарская
35	142	33	Курганская
36	144	33	Курская
37	151	33	Ленинградская
38	155	33	Липецкая
39	163	33	Магаданская
40	176	33	Московская
41	177	33	Мурманская
42	189	33	Новгородская
43	191	33	Новосибирская
44	196	33	Омская
45	199	33	Оренбургская
46	200	33	Орловская
47	207	33	Пензенская
48	208	33	Пермская
49	217	33	Псковская
50	231	33	Ростовская
51	235	33	Рязанская
52	243	33	Саратовская
53	244	33	Сахалинская
54	246	33	Свердловская
55	254	33	Смоленская
56	268	33	Тамбовская
57	279	33	Томская
58	283	33	Тульская
59	285	33	Тюменская
60	289	33	Ульяновская
61	313	33	Челябинская
62	321	33	Читинская
63	341	33	Ярославская
64	29	33	Башкортостан
65	38	33	Бурятия
66	65	33	Дагестан
67	98	33	Кабардино-балкарская
68	103	33	Калмыкия
69	110	33	Карелия
70	125	33	Коми
71	169	33	Марийская
72	174	33	Мордовская
73	248	33	Северо-осетинская
74	270	33	Татарстан
75	281	33	Тува
76	287	33	Удмуртия
77	318	33	Чеченская
78	323	33	Чувашская
79	339	33	Якутия
80	90	33	Ингушская
81	109	33	Карачаево-черкесская
82	175	33	Москва
83	242	33	Санкт-петербург
84	78	33	Еврейская ао
85	10	33	Агинский бурятск.ао
86	126	33	Коми-пермятский ао
87	128	33	Корякский ао
88	183	33	Ненецкий ао
89	263	33	Таймырский ао
90	292	33	Усть-ордын.бурятский
91	301	33	Ханты-мансийский ао
92	324	33	Чукотский ао
93	332	33	Эвенкийский ао
94	340	33	Ямало-ненецкий ао
95	53	9	Винницкая
96	57	9	Волынская
97	72	9	Днепропетровская
98	75	9	Донецкая
99	82	9	Житомирская
100	83	9	Закарпатская
101	85	9	Запорожская
102	88	9	Ивано-франковская
103	118	9	Киевская
104	120	9	Кировоградская
105	138	9	Крымская
106	158	9	Луганская
107	160	9	Львовская
108	187	9	Николаевская
109	195	9	Одесская
110	212	9	Полтавская
111	229	9	Ровенская
112	260	9	Сумская
113	277	9	Тернопольская
114	302	9	Харьковская
115	304	9	Херсонская
116	306	9	Хмельницкая
117	314	9	Черкасская
118	315	9	Черниговская
119	316	9	Черновицкая
120	8	19	Абхазия
121	11	19	Аджария
122	335	19	Юго-осетинская
123	181	12	Нахичевань
124	178	12	Нагорный-карабах
125	19	8	Андижанская
126	39	8	Бухарская
127	71	8	Джизакская
128	108	8	Каракалпакия
129	113	8	Кашкадарьинская
130	179	8	Намаганская
131	240	8	Самаркандская
132	261	8	Сурхандарьинская
133	262	8	Сырдарьинская
134	273	8	Ташкентская
135	295	8	Ферганская
136	307	8	Хорезмская
137	62	24	Горно-бадакшанская
138	140	24	Кулябская
139	143	24	Курган-тюбинская
140	150	24	Ленинабадская
141	308	24	Худжанская
142	68	27	Джалал-абадская
143	95	27	Иссык_кульская
144	180	27	Нарынская
145	201	27	Ошская
146	264	27	Таласская
147	15	15	Алма-атинская
148	13	15	Актюбинская
149	59	15	Восточ-казахстанская
150	64	15	Гурьевская
151	69	15	Джамбульская
152	70	15	Джезказганская
153	107	15	Карагандинская
154	117	15	Кзыл-ординская
155	124	15	Кокчетавская
156	145	15	Кустанайская
157	168	15	Мангышлакская
158	202	15	Павлодарская
159	249	15	Сев-казахстанская
160	250	15	Семипалатинская
161	265	15	Талды-курганская
162	284	15	Тургайская
163	291	15	Уральская
164	309	15	Целиноградская
165	320	15	Чимкентская
166	23	23	Ашхабадская
167	133	23	Красноводская
168	170	23	Марыйская
169	272	23	Ташаузская
170	312	23	Чарджоуская
171	322	33	Чувашия
172	156	21	Литва
173	50	21	Вильнюс
174	12	21	Акмянский
175	14	21	Алитусский
176	20	21	Аникшчяйский
177	33	21	Биржайский
178	43	21	Варенский
179	49	21	Вилкавишкский
180	51	21	Вильнюсский
181	86	21	Зарасайский
182	89	21	Игналинский
183	91	21	Ионавский
184	92	21	Ионишкский
185	100	21	Кайшядорский
186	106	21	Капсукский
187	111	21	Каунасский
188	114	21	Кедайнский
189	115	21	Кельмеский
190	123	21	Клайпедский
191	136	21	Кретингский
192	141	21	Купишкский
193	147	21	Лаздийский
194	165	21	Мажейкский
195	173	21	Молетский
196	204	21	Пакруойский
197	205	21	Паневежский
198	206	21	Пасвальский
199	209	21	Плунгеский
200	215	21	Пренайский
201	220	21	Радвилишкский
202	223	21	Расейнский
203	230	21	Рокшикский
204	252	21	Скуодасский
205	271	21	Таурагский
206	276	21	Тельшяйский
207	280	21	Тракайский
208	288	21	Укмергский
209	293	21	Утенский
210	325	21	Шакяйский
211	327	21	Швенченский
212	328	21	Шилальский
213	329	21	Шилутский
214	330	21	Ширвинтский
215	326	21	Шауляйский
216	333	21	Эйшишкский
217	337	21	Юрбаркский
218	149	11	Латвия
219	227	11	Рига
220	17	11	Алуксненский
221	26	11	Балвский
222	27	11	Бауский
223	41	11	Валкский
224	42	11	Валмиерский
225	48	11	Вентспилсский
226	63	11	Гулбенский
227	67	11	Даугавпилсский
228	73	11	Добельский
229	80	11	Екабпилсский
230	81	11	Елгавский
231	132	11	Краславский
232	139	11	Кулдигский
233	153	11	Лиепайский
234	154	11	Лимбажский
235	159	11	Лудзенский
236	164	11	Мадонский
237	194	11	Огрский
238	214	11	Прейльский
239	224	11	Резекненский
240	228	11	Рижский
241	239	11	Салдусский
242	258	11	Стучкинский
243	267	11	Талсинский
244	282	11	Тукумский
245	310	11	Цесисский
246	338	11	Юрмала
247	334	5	Эстония
248	266	5	Таллин
249	40	5	Валгаский
250	52	5	Вильяндиский
251	60	5	Выруский
252	97	5	Йыгеваский
253	119	5	Кингисеппский
254	131	5	Кохтла-ярвеский
255	203	5	Пайдеский
256	218	5	Пыльваский
257	219	5	Пярнуский
258	221	5	Раквереский
259	222	5	Раплаский
260	269	5	Тартуский
261	299	5	Хаапсалуский
262	303	5	Харьюский
263	305	5	Хийумааский
264	172	7	Молдавия
265	122	7	Кишенев
266	36	7	Бричанский
267	61	7	Глодянский
268	74	7	Дондюшанский
269	76	7	Дрокиевский
270	77	7	Дубоссарский
271	79	7	Единецкий
272	99	7	Кагульский
273	101	7	Каларашский
274	112	7	Каушанский
275	127	7	Комратский
276	130	7	Котовский
277	137	7	Криулянский
278	148	7	Лазовский
279	152	7	Леовский
280	188	7	Ниспоренский
281	190	7	Новоаненский
282	198	7	Оргеевский
283	225	7	Резинский
284	233	7	Рыбницкий
285	234	7	Рышканский
286	255	7	Сорокский
287	257	7	Страшенский
288	259	7	Суворовский
289	275	7	Теленештский
290	278	7	Тираспольский
291	290	7	Унгенский
292	294	7	Фалештский
293	297	7	Флорештский
294	311	7	Чадыр-лунгский
295	319	7	Чимишлийский
296	31	3	Бельгия
297	34	25	Болгария
298	45	32	Великобритания
299	47	17	Венгрия
300	66	31	Дания
301	94	22	Испания
302	96	18	Италия
303	192	26	Норвегия
304	232	29	Румыния
305	253	4	Словакия
306	296	16	Финляндия
307	298	30	Франция
308	317	6	Чехия
309	336	28	Югославия
310	24	20	Бавария
311	25	20	Баден-вюртемберг
312	28	20	Бауэрн
313	32	20	Берлин
314	35	20	Бранденбург
315	171	20	Мекленбург-передняя
316	186	20	Нижняя саксония
317	247	20	Северный рейн-вестфа
318	226	20	Рейнланд-пфальц
319	236	20	Саар
320	237	20	Саксония
321	238	20	Саксония-ангальт
322	193	20	Нордхейн-вестфален
323	286	20	Тюрингия
324	331	20	Шлезвиг-гольштейн
325	44	2	Варминьско-мазурское
326	46	2	Велькопольское
327	84	2	Западно-поморское
328	146	2	Куявско-поморское
329	157	2	Лодзинское
330	161	2	Любельское
331	162	2	Любуское
332	166	2	Мазовецкое
333	167	2	Малополькое
334	185	2	Нижнесилезское
335	197	2	Опольское
336	210	2	Подкарпатское
337	211	2	Подляское
338	213	2	Поморское
339	245	2	Свентокшиское
340	251	2	Силезское
341	342	12	-
342	343	24	-
343	344	10	-
344	345	8	-
345	346	15	-
346	347	27	-
347	348	14	-
348	349	23	-
349	350	19	-
350	351	11	-
351	352	5	-
352	353	21	-
353	354	7	-
354	356	35	-
355	357	33	Хакассия
\.


--
-- Data for Name: common_geostreet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_geostreet (id, city_id, name) FROM stdin;
\.


--
-- Data for Name: common_informationsource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_informationsource (id, obid, name) FROM stdin;
1	47901	Военнопленные
2	47902	Рвк мр рб
3	47903	Кп тверь
4	47904	Фнп мр рб
5	47905	Цамо
6	47906	Венгрия
7	47907	Фнп мз рб
8	47908	Кп волгоград
9	47909	Поисковики
10	47910	Кп татарстан
11	47911	По данным рвк и рик
12	47912	Кп калиниград
13	47913	Локальные войны
14	47925	Рик и рвк мз
\.


--
-- Data for Name: common_locationbirth; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_locationbirth (obid, country_id, region_id, city_id, info, person_id, gps_x, gps_y, gps_z) FROM stdin;
\.


--
-- Data for Name: common_locationburial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_locationburial (obid, country_id, region_id, city_id, info, burial_id, gps_x, gps_y, gps_z) FROM stdin;
\.


--
-- Data for Name: common_memorialstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_memorialstate (id, name) FROM stdin;
\.


--
-- Data for Name: common_militaryconflict; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_militaryconflict (id, obid, name, brief, comment, type_id) FROM stdin;
2	47917	Локальные военные конфликты	\N	\N	\N
3	47920	Первая мировая война	\N	\N	\N
4	47921	Гражданская и другие	\N	\N	\N
5	47926	Иностранные 1мв	\N	\N	\N
6	47927	Иностранные 2мв	\N	\N	\N
7	47930	Иностранные другие	\N	\N	\N
1	47914	Вторая мировая война			\N
\.


--
-- Data for Name: common_militaryconflicttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_militaryconflicttype (id, "full", brief) FROM stdin;
1	Вторая мировая война	2МВ
\.


--
-- Data for Name: common_militaryunit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_militaryunit (id, obid, country_id, region_id, city_id, info, name, gps_x, gps_y, gps_z) FROM stdin;
53	\N	\N	\N	\N	\N	95 сд	\N	\N	\N
54	\N	\N	\N	\N	\N	121 кавполк	\N	\N	\N
55	\N	\N	\N	\N	\N	1342 сп 234 сд	\N	\N	\N
56	\N	\N	\N	\N	\N	60 сд 1281 сп	\N	\N	\N
57	\N	\N	\N	\N	\N	132 сп 129 сд	\N	\N	\N
58	\N	\N	\N	\N	\N	26 гв сд 77 гв сп	\N	\N	\N
59	\N	\N	\N	\N	\N	77 гв сп 26 гв сд	\N	\N	\N
60	\N	\N	\N	\N	\N	47 сд	\N	\N	\N
61	\N	\N	\N	\N	\N	79 гв.сп	\N	\N	\N
62	\N	\N	\N	\N	\N	247 гв сп	\N	\N	\N
63	\N	\N	\N	\N	\N	1298 артполк; 234 ломоносовская сд	\N	\N	\N
64	\N	\N	\N	\N	\N	145 сд	\N	\N	\N
65	\N	\N	\N	\N	\N	446 сп 397 сдс	\N	\N	\N
66	\N	\N	\N	\N	\N	262 сп	\N	\N	\N
67	\N	\N	\N	\N	\N	353 сп 47 сд	\N	\N	\N
68	\N	\N	\N	\N	\N	1188 сп 357 сд	\N	\N	\N
69	\N	\N	\N	\N	\N	29 гсп 26 гсд	\N	\N	\N
70	\N	\N	\N	\N	\N	64  гап 31 гсд	\N	\N	\N
71	\N	\N	\N	\N	\N	250 гсп; 83 городокская сд	\N	\N	\N
72	\N	\N	\N	\N	\N	65 кавполк 32 кавдив	\N	\N	\N
73	\N	\N	\N	\N	\N	26 гв сд 75 гв сп	\N	\N	\N
74	\N	\N	\N	\N	\N	4 гв.пуш.арт.дивизия ргк	\N	\N	\N
75	\N	\N	\N	\N	\N	1223 сп 369 сд	\N	\N	\N
76	\N	\N	\N	\N	\N	1104 сп 331 сд	\N	\N	\N
77	\N	\N	\N	\N	\N	357 сд	\N	\N	\N
78	\N	\N	\N	\N	\N	94 гсп	\N	\N	\N
79	\N	\N	\N	\N	\N	79 гв сп 26 гв сд	\N	\N	\N
80	\N	\N	\N	\N	\N	75 гсп 26 гсд	\N	\N	\N
81	\N	\N	\N	\N	\N	16 сд	\N	\N	\N
82	\N	\N	\N	\N	\N	234 сд	\N	\N	\N
83	\N	\N	\N	\N	\N	1195 сп 360 сд	\N	\N	\N
84	\N	\N	\N	\N	\N	178 аминп 5 гв.кд	\N	\N	\N
85	\N	\N	\N	\N	\N	47 сп 15 сд	\N	\N	\N
86	\N	\N	\N	\N	\N	381 сд	\N	\N	\N
87	\N	\N	\N	\N	\N	148 сп 47 сд	\N	\N	\N
88	\N	\N	\N	\N	\N	1115 сп	\N	\N	\N
89	\N	\N	\N	\N	\N	1191 сп 358 сд	\N	\N	\N
90	\N	\N	\N	\N	\N	10 олыжб,166 сд	\N	\N	\N
91	\N	\N	\N	\N	\N	94 гсп 30 гсд	\N	\N	\N
92	\N	\N	\N	\N	\N	17 гв.онитд 1 гв.сд	\N	\N	\N
93	\N	\N	\N	\N	\N	90 гв.сд	\N	\N	\N
94	\N	\N	\N	\N	\N	70 тбр	\N	\N	\N
95	\N	\N	\N	\N	\N	806 сп 235 сд	\N	\N	\N
96	\N	\N	\N	\N	\N	27 сп	\N	\N	\N
97	\N	\N	\N	\N	\N	26 гв сд 77  гв сп	\N	\N	\N
98	\N	\N	\N	\N	\N	Пп 40316	\N	\N	\N
99	\N	\N	\N	\N	\N	1150 сбр	\N	\N	\N
100	\N	\N	\N	\N	\N	В/ч 43854	\N	\N	\N
101	\N	\N	\N	\N	\N	90 гв.сд 29 гв.сд	\N	\N	\N
102	\N	\N	\N	\N	\N	732 сп 235 сд	\N	\N	\N
103	\N	\N	\N	\N	\N	1261 сп 381 сд	\N	\N	\N
104	\N	\N	\N	\N	\N	Дулаг-184 г.вязьма	\N	\N	\N
105	\N	\N	\N	\N	\N	380 сд	\N	\N	\N
106	\N	\N	\N	\N	\N	24 корп.авиаотряд	\N	\N	\N
107	\N	\N	\N	\N	\N	109 пехотный полк	\N	\N	\N
108	\N	\N	\N	\N	\N	21 пехотный полк	\N	\N	\N
109	\N	\N	\N	\N	\N	5 пехотный полк	\N	\N	\N
110	\N	\N	\N	\N	\N	8 арт. батарея	\N	\N	\N
111	\N	\N	\N	\N	\N	110 пехотный полк	\N	\N	\N
112	\N	\N	\N	\N	\N	3 сб 640 сп 147 сд	\N	\N	\N
113	\N	\N	\N	\N	\N	22 армия зап.фр. воен.совет	\N	\N	\N
114	\N	\N	\N	\N	\N	2 тб 50 гв. тбр 9 гв. тк	\N	\N	\N
115	\N	\N	\N	\N	\N	14 гренад.полк	\N	\N	\N
116	\N	\N	\N	\N	\N	9 сиб.стр.арт.бриг.	\N	\N	\N
117	\N	\N	\N	\N	\N	113 пех.старорусский полк	\N	\N	\N
118	\N	\N	\N	\N	\N	551 сп 49 сд	\N	\N	\N
119	\N	\N	\N	\N	\N	86 кавалер. полк	\N	\N	\N
120	\N	\N	\N	\N	\N	622 сп	\N	\N	\N
121	\N	\N	\N	\N	\N	1174 сп 348 сд	\N	\N	\N
122	\N	\N	\N	\N	\N	384 сп 157 сд	\N	\N	\N
123	\N	\N	\N	\N	\N	97 сд	\N	\N	\N
124	\N	\N	\N	\N	\N	1185 сп 365 сд	\N	\N	\N
125	\N	\N	\N	\N	\N	169 сп 1 сд	\N	\N	\N
126	\N	\N	\N	\N	\N	86 кавал. полк	\N	\N	\N
127	\N	\N	\N	\N	\N	457 омсб 381 сд	\N	\N	\N
128	\N	\N	\N	\N	\N	49 усп	\N	\N	\N
129	\N	\N	\N	\N	\N	234 сд оаб	\N	\N	\N
130	\N	\N	\N	\N	\N	765 кап	\N	\N	\N
131	\N	\N	\N	\N	\N	652 осб	\N	\N	\N
132	\N	\N	\N	\N	\N	144 инж.батальон 381 сд	\N	\N	\N
133	\N	\N	\N	\N	\N	1263 сп	\N	\N	\N
134	\N	\N	\N	\N	\N	1224 сп	\N	\N	\N
135	\N	\N	\N	\N	\N	935 артполк	\N	\N	\N
136	\N	\N	\N	\N	\N	1897 сп	\N	\N	\N
137	\N	\N	\N	\N	\N	83 гсд 248 сп	\N	\N	\N
138	\N	\N	\N	\N	\N	1263 сп 381 сд	\N	\N	\N
139	\N	\N	\N	\N	\N	В/ч 37663	\N	\N	\N
140	\N	\N	\N	\N	\N	43 армия	\N	\N	\N
141	\N	\N	\N	\N	\N	245 сп 84 сд	\N	\N	\N
142	\N	\N	\N	\N	\N	820 сп 117 сд	\N	\N	\N
143	\N	\N	\N	\N	\N	1259 сп 381 сд	\N	\N	\N
144	\N	\N	\N	\N	\N	10 сб 82 сд	\N	\N	\N
145	\N	\N	\N	\N	\N	1350 сп 234 сд	\N	\N	\N
146	\N	\N	\N	\N	\N	167 сп	\N	\N	\N
147	\N	\N	\N	\N	\N	156 сп 16 сд	\N	\N	\N
148	\N	\N	\N	\N	\N	250 гсп 83 гсд	\N	\N	\N
149	\N	\N	\N	\N	\N	Пп 53758	\N	\N	\N
150	\N	\N	\N	\N	\N	99 гсп 31 гсд	\N	\N	\N
151	\N	\N	\N	\N	\N	Пп 53758  806 сп 236 сд	\N	\N	\N
152	\N	\N	\N	\N	\N	44 мбр	\N	\N	\N
153	\N	\N	\N	\N	\N	275 сп 117 сд	\N	\N	\N
154	\N	\N	\N	\N	\N	1193 сп 360 сд	\N	\N	\N
155	\N	\N	\N	\N	\N	235 сд	\N	\N	\N
156	\N	\N	\N	\N	\N	169 сп пп 56256	\N	\N	\N
157	\N	\N	\N	\N	\N	Батарея 619 артполка	\N	\N	\N
158	\N	\N	\N	\N	\N	732 сп 234 сд	\N	\N	\N
159	\N	\N	\N	\N	\N	757 сп 222 сд	\N	\N	\N
160	\N	\N	\N	\N	\N	41 оасб	\N	\N	\N
161	\N	\N	\N	\N	\N	249 мп	\N	\N	\N
162	\N	\N	\N	\N	\N	121 гсп 5 гсд	\N	\N	\N
163	\N	\N	\N	\N	\N	26 гв сд 79 гв сп	\N	\N	\N
164	\N	\N	\N	\N	\N	730 сп 204 сд	\N	\N	\N
165	\N	\N	\N	\N	\N	271 сп 11 гсд	\N	\N	\N
166	\N	\N	\N	\N	\N	58 сп 18 сд	\N	\N	\N
167	\N	\N	\N	\N	\N	802 сп пп 91178	\N	\N	\N
168	\N	\N	\N	\N	\N	250 гсп 83 гсд пп 29454	\N	\N	\N
169	\N	\N	\N	\N	\N	33 сп	\N	\N	\N
170	\N	\N	\N	\N	\N	11 гв отп	\N	\N	\N
171	\N	\N	\N	\N	\N	1193 сп п/п 05327	\N	\N	\N
172	\N	\N	\N	\N	\N	33 сп 11 сд	\N	\N	\N
173	\N	\N	\N	\N	\N	39 ашр	\N	\N	\N
174	\N	\N	\N	\N	\N	99 гсп пп 655	\N	\N	\N
175	\N	\N	\N	\N	\N	47 нсд	\N	\N	\N
176	\N	\N	\N	\N	\N	248 гсп 83 гсд	\N	\N	\N
177	\N	\N	\N	\N	\N	1197 сп 360 сд	\N	\N	\N
178	\N	\N	\N	\N	\N	106 сп	\N	\N	\N
179	\N	\N	\N	\N	\N	24 кав. полк	\N	\N	\N
180	\N	\N	\N	\N	\N	115 рсв 84 гв.сд	\N	\N	\N
181	\N	\N	\N	\N	\N	376 гап 381 сд	\N	\N	\N
182	\N	\N	\N	\N	\N	387 ап 11 гв армии	\N	\N	\N
183	\N	\N	\N	\N	\N	Пп 33987	\N	\N	\N
184	\N	\N	\N	\N	\N	5 тд 5 смб	\N	\N	\N
185	\N	\N	\N	\N	\N	510 сп 154 сд	\N	\N	\N
186	\N	\N	\N	\N	\N	277 сп 175 сд	\N	\N	\N
187	\N	\N	\N	\N	\N	197 сд	\N	\N	\N
188	\N	\N	\N	\N	\N	102 сп	\N	\N	\N
189	\N	\N	\N	\N	\N	В/ч пп 01064	\N	\N	\N
190	\N	\N	\N	\N	\N	1343 сп 399 сд	\N	\N	\N
191	\N	\N	\N	\N	\N	624 сп 137 сд	\N	\N	\N
192	\N	\N	\N	\N	\N	771 сп 137 сд	\N	\N	\N
193	\N	\N	\N	\N	\N	137 сд 169 осб	\N	\N	\N
194	\N	\N	\N	\N	\N	9 гв каз. дивизия	\N	\N	\N
195	\N	\N	\N	\N	\N	188 сп 106 сд	\N	\N	\N
196	\N	\N	\N	\N	\N	Штаб 15 сд	\N	\N	\N
197	\N	\N	\N	\N	\N	Пп 01144	\N	\N	\N
198	\N	\N	\N	\N	\N	556 сп 169 сд	\N	\N	\N
199	\N	\N	\N	\N	\N	323 сд	\N	\N	\N
200	\N	\N	\N	\N	\N	1020 сп	\N	\N	\N
201	\N	\N	\N	\N	\N	238 сп 186 сд	\N	\N	\N
202	\N	\N	\N	\N	\N	59 гв.шап	\N	\N	\N
203	\N	\N	\N	\N	\N	217 шап 299 шад	\N	\N	\N
204	\N	\N	\N	\N	\N	1 отд.гв.мсб	\N	\N	\N
205	\N	\N	\N	\N	\N	45 тд	\N	\N	\N
206	\N	\N	\N	\N	\N	45 тд ?	\N	\N	\N
207	\N	\N	\N	\N	\N	65 а	\N	\N	\N
208	\N	\N	\N	\N	\N	Вч 06764 (895 сп, 193 сд)	\N	\N	\N
209	\N	\N	\N	\N	\N	206 отд.арм.штаф.рота 354 сд 65 а	\N	\N	\N
210	\N	\N	\N	\N	\N	-	\N	\N	\N
211	\N	\N	\N	\N	\N	434 сп	\N	\N	\N
212	\N	\N	\N	\N	\N	556 сп	\N	\N	\N
213	\N	\N	\N	\N	\N	44 ошсб	\N	\N	\N
214	\N	\N	\N	\N	\N	680 сп	\N	\N	\N
215	\N	\N	\N	\N	\N	283 гомельская краснознаменная ордю суворова сд	\N	\N	\N
216	\N	\N	\N	\N	\N	1316 сп  17 сд	\N	\N	\N
217	\N	\N	\N	\N	\N	17 сд	\N	\N	\N
218	\N	\N	\N	\N	\N	283 сд	\N	\N	\N
219	\N	\N	\N	\N	\N	1457 сап (позднее 1888 сап)	\N	\N	\N
220	\N	\N	\N	\N	\N	860 сп 283 сд	\N	\N	\N
221	\N	\N	\N	\N	\N	1287 сп 110 сд	\N	\N	\N
222	\N	\N	\N	\N	\N	Пп 20761	\N	\N	\N
223	\N	\N	\N	\N	\N	438 сп 129 сд	\N	\N	\N
224	\N	\N	\N	\N	\N	1095 сп 380 сд	\N	\N	\N
225	\N	\N	\N	\N	\N	1091 сп 380 сд	\N	\N	\N
226	\N	\N	\N	\N	\N	1093 сп 380 сд	\N	\N	\N
227	\N	\N	\N	\N	\N	500 ап 199 сд	\N	\N	\N
228	\N	\N	\N	\N	\N	290 сд	\N	\N	\N
229	\N	\N	\N	\N	\N	192 сп 199 сд	\N	\N	\N
230	\N	\N	\N	\N	\N	90 сп	\N	\N	\N
231	\N	\N	\N	\N	\N	43 гв.тбр	\N	\N	\N
232	\N	\N	\N	\N	\N	492 сп	\N	\N	\N
233	\N	\N	\N	\N	\N	199 сд	\N	\N	\N
234	\N	\N	\N	\N	\N	57 ап	\N	\N	\N
235	\N	\N	\N	\N	\N	492 сп 199 сд	\N	\N	\N
236	\N	\N	\N	\N	\N	290 сп	\N	\N	\N
237	\N	\N	\N	\N	\N	161 сп	\N	\N	\N
238	\N	\N	\N	\N	\N	882 сп 290 сд	\N	\N	\N
239	\N	\N	\N	\N	\N	388 сп 172 сд	\N	\N	\N
240	\N	\N	\N	\N	\N	13 сп	\N	\N	\N
241	\N	\N	\N	\N	\N	100 сд	\N	\N	\N
242	\N	\N	\N	\N	\N	766 сп 217 сд	\N	\N	\N
243	\N	\N	\N	\N	\N	339 сд	\N	\N	\N
244	\N	\N	\N	\N	\N	217 сд	\N	\N	\N
245	\N	\N	\N	\N	\N	392 сп	\N	\N	\N
246	\N	\N	\N	\N	\N	146 озсп	\N	\N	\N
247	\N	\N	\N	\N	\N	471 сп	\N	\N	\N
248	\N	\N	\N	\N	\N	108 сд	\N	\N	\N
249	\N	\N	\N	\N	\N	15 гв.тбр	\N	\N	\N
250	\N	\N	\N	\N	\N	102 сд	\N	\N	\N
251	\N	\N	\N	\N	\N	250 сд	\N	\N	\N
252	\N	\N	\N	\N	\N	356 сд	\N	\N	\N
253	\N	\N	\N	\N	\N	1185 сп 356 сд	\N	\N	\N
254	\N	\N	\N	\N	\N	918 ап 356 сд	\N	\N	\N
255	\N	\N	\N	\N	\N	413 сп 73 сд	\N	\N	\N
256	\N	\N	\N	\N	\N	422 обс 1 гв.тк	\N	\N	\N
257	\N	\N	\N	\N	\N	П/о им.фурманова	\N	\N	\N
258	\N	\N	\N	\N	\N	8 мсбр	\N	\N	\N
259	\N	\N	\N	\N	\N	137 сд	\N	\N	\N
260	\N	\N	\N	\N	\N	409 сп 137 сд	\N	\N	\N
261	\N	\N	\N	\N	\N	269 сд	\N	\N	\N
262	\N	\N	\N	\N	\N	8 мсбр 9 тк	\N	\N	\N
263	\N	\N	\N	\N	\N	243 гв.сп	\N	\N	\N
264	\N	\N	\N	\N	\N	94 тга	\N	\N	\N
265	\N	\N	\N	\N	\N	84 гсд	\N	\N	\N
266	\N	\N	\N	\N	\N	257 гсп 84 сд	\N	\N	\N
267	\N	\N	\N	\N	\N	2471 сп 84 сд	\N	\N	\N
268	\N	\N	\N	\N	\N	53 гсп	\N	\N	\N
269	\N	\N	\N	\N	\N	552 минометный полк	\N	\N	\N
270	\N	\N	\N	\N	\N	552 минометный полк 84 гсд	\N	\N	\N
271	\N	\N	\N	\N	\N	35 ап	\N	\N	\N
272	\N	\N	\N	\N	\N	32 отд.штраф.рота 26 гсд	\N	\N	\N
273	\N	\N	\N	\N	\N	1342 сп	\N	\N	\N
274	\N	\N	\N	\N	\N	268 итр	\N	\N	\N
275	\N	\N	\N	\N	\N	423 сп 4 уа	\N	\N	\N
276	\N	\N	\N	\N	\N	6 ошб 4уа	\N	\N	\N
277	\N	\N	\N	\N	\N	517 сп	\N	\N	\N
278	\N	\N	\N	\N	\N	981 обс	\N	\N	\N
279	\N	\N	\N	\N	\N	274 гсп	\N	\N	\N
280	\N	\N	\N	\N	\N	240 сп	\N	\N	\N
281	\N	\N	\N	\N	\N	297 сп 184 сд	\N	\N	\N
282	\N	\N	\N	\N	\N	306 сд	\N	\N	\N
283	\N	\N	\N	\N	\N	787 сп 222 сд	\N	\N	\N
284	\N	\N	\N	\N	\N	938 сп 306 сд	\N	\N	\N
285	\N	\N	\N	\N	\N	192 сд	\N	\N	\N
286	\N	\N	\N	\N	\N	1190 сп 357 сд	\N	\N	\N
287	\N	\N	\N	\N	\N	47 гап 21  гсд	\N	\N	\N
288	\N	\N	\N	\N	\N	59 сп 21 сд	\N	\N	\N
289	\N	\N	\N	\N	\N	201 сп 67 сд	\N	\N	\N
290	\N	\N	\N	\N	\N	210 сп 71 сд	\N	\N	\N
291	\N	\N	\N	\N	\N	421 сп 119 сд	\N	\N	\N
292	\N	\N	\N	\N	\N	1119 сп 332 сд	\N	\N	\N
293	\N	\N	\N	\N	\N	1117 сп 332 сд	\N	\N	\N
294	\N	\N	\N	\N	\N	1071 сп 311 сд	\N	\N	\N
295	\N	\N	\N	\N	\N	1115 сп 332 сд	\N	\N	\N
296	\N	\N	\N	\N	\N	1192 сп 357 сд	\N	\N	\N
297	\N	\N	\N	\N	\N	332 сд	\N	\N	\N
298	\N	\N	\N	\N	\N	334 сп 47 сд	\N	\N	\N
299	\N	\N	\N	\N	\N	513 сп	\N	\N	\N
300	\N	\N	\N	\N	\N	517 сп 166 сд	\N	\N	\N
301	\N	\N	\N	\N	\N	648 сп 200 сд	\N	\N	\N
302	\N	\N	\N	\N	\N	196 гсп 67 гсд	\N	\N	\N
303	\N	\N	\N	\N	\N	154 гсп 51 гсд	\N	\N	\N
304	\N	\N	\N	\N	\N	634 сп 119 сд	\N	\N	\N
305	\N	\N	\N	\N	\N	167 сп 16 сд	\N	\N	\N
306	\N	\N	\N	\N	\N	1 гв.тбр	\N	\N	\N
307	\N	\N	\N	\N	\N	51 гв.сп 18 гв.сд	\N	\N	\N
308	\N	\N	\N	\N	\N	247 сп 84 сд	\N	\N	\N
309	\N	\N	\N	\N	\N	186 ап	\N	\N	\N
310	\N	\N	\N	\N	\N	142 сп	\N	\N	\N
311	\N	\N	\N	\N	\N	6 ад мозырская	\N	\N	\N
312	\N	\N	\N	\N	\N	11 кп 4 кд	\N	\N	\N
313	\N	\N	\N	\N	\N	18 исбр	\N	\N	\N
314	\N	\N	\N	\N	\N	479 сп 149 сд	\N	\N	\N
315	\N	\N	\N	\N	\N	350 сп (250сп)	\N	\N	\N
316	\N	\N	\N	\N	\N	40 сп	\N	\N	\N
317	\N	\N	\N	\N	\N	616 сп 137 сд	\N	\N	\N
318	\N	\N	\N	\N	\N	954 сп	\N	\N	\N
319	\N	\N	\N	\N	\N	Шт.фр.170вз.	\N	\N	\N
320	\N	\N	\N	\N	\N	470 сп	\N	\N	\N
321	\N	\N	\N	\N	\N	30 хсп 102 ?	\N	\N	\N
322	\N	\N	\N	\N	\N	101 сп	\N	\N	\N
323	\N	\N	\N	\N	\N	422 сп	\N	\N	\N
324	\N	\N	\N	\N	\N	16 усп	\N	\N	\N
325	\N	\N	\N	\N	\N	350 сп	\N	\N	\N
326	\N	\N	\N	\N	\N	275 гв.иптап	\N	\N	\N
327	\N	\N	\N	\N	\N	1184 ап	\N	\N	\N
328	\N	\N	\N	\N	\N	1019 сп (1013 сп)	\N	\N	\N
329	\N	\N	\N	\N	\N	17 сд (17 сп)	\N	\N	\N
330	\N	\N	\N	\N	\N	1 гв. аиоб	\N	\N	\N
331	\N	\N	\N	\N	\N	282 сп	\N	\N	\N
332	\N	\N	\N	\N	\N	16 гв.ртбр	\N	\N	\N
333	\N	\N	\N	\N	\N	287 сп	\N	\N	\N
334	\N	\N	\N	\N	\N	294 ап	\N	\N	\N
335	\N	\N	\N	\N	\N	42 отп	\N	\N	\N
336	\N	\N	\N	\N	\N	307 сд	\N	\N	\N
337	\N	\N	\N	\N	\N	114 ап (114 гв.мп)	\N	\N	\N
338	\N	\N	\N	\N	\N	783 шап 4 шак	\N	\N	\N
339	\N	\N	\N	\N	\N	58 гв.шап 2 гв.шад	\N	\N	\N
340	\N	\N	\N	\N	\N	Парт.отр.им.кирова	\N	\N	\N
341	\N	\N	\N	\N	\N	1018 сп	\N	\N	\N
342	\N	\N	\N	\N	\N	118 гв сп 37 гв сд	\N	\N	\N
343	\N	\N	\N	\N	\N	49 сд	\N	\N	\N
344	\N	\N	\N	\N	\N	256 оашр	\N	\N	\N
345	\N	\N	\N	\N	\N	455 сп 42 сд	\N	\N	\N
346	\N	\N	\N	\N	\N	31 уч.полк 852 сп 5 а	\N	\N	\N
347	\N	\N	\N	\N	\N	274 сд	\N	\N	\N
348	\N	\N	\N	\N	\N	Пп 23860	\N	\N	\N
349	\N	\N	\N	\N	\N	9 гв.мбр 7 гв.мин.див	\N	\N	\N
350	\N	\N	\N	\N	\N	418 сп 133 сд	\N	\N	\N
351	\N	\N	\N	\N	\N	1620 лап	\N	\N	\N
352	\N	\N	\N	\N	\N	755 сп 217 сд	\N	\N	\N
353	\N	\N	\N	\N	\N	6 гв.кав.див.	\N	\N	\N
354	\N	\N	\N	\N	\N	15 ооб 31 а	\N	\N	\N
355	\N	\N	\N	\N	\N	55 лап	\N	\N	\N
356	\N	\N	\N	\N	\N	1254 сп 378 сд	\N	\N	\N
357	\N	\N	\N	\N	\N	1 гв.бак дд 6 гв.ад дд 17 гап	\N	\N	\N
358	\N	\N	\N	\N	\N	969 сп 273 сд	\N	\N	\N
359	\N	\N	\N	\N	\N	451 сп 64 сд	\N	\N	\N
360	\N	\N	\N	\N	\N	1227 сп	\N	\N	\N
361	\N	\N	\N	\N	\N	73 сд	\N	\N	\N
362	\N	\N	\N	\N	\N	1046 артполк	\N	\N	\N
363	\N	\N	\N	\N	\N	184 обс	\N	\N	\N
364	\N	\N	\N	\N	\N	1345 сп	\N	\N	\N
365	\N	\N	\N	\N	\N	282 сп 175 сд	\N	\N	\N
366	\N	\N	\N	\N	\N	163 кав.полк 8 кав.див.	\N	\N	\N
367	\N	\N	\N	\N	\N	78 гв.шап	\N	\N	\N
368	\N	\N	\N	\N	\N	110 сд	\N	\N	\N
369	\N	\N	\N	\N	\N	234 сд 340 сд	\N	\N	\N
370	\N	\N	\N	\N	\N	3 мсбн 1 гв.мсбр	\N	\N	\N
371	\N	\N	\N	\N	\N	30 сп 102 сд	\N	\N	\N
372	\N	\N	\N	\N	\N	30 кав.сп	\N	\N	\N
373	\N	\N	\N	\N	\N	83 гсд	\N	\N	\N
374	\N	\N	\N	\N	\N	252 сп 83 гсд	\N	\N	\N
375	\N	\N	\N	\N	\N	187 сп 83 гсд	\N	\N	\N
376	\N	\N	\N	\N	\N	83 гсд  пхп	\N	\N	\N
377	\N	\N	\N	\N	\N	446 сп 397 сд	\N	\N	\N
378	\N	\N	\N	\N	\N	230 шад 103 шап	\N	\N	\N
379	\N	\N	\N	\N	\N	471 сп 73 сд	\N	\N	\N
380	\N	\N	\N	\N	\N	6 сд 45 ск	\N	\N	\N
381	\N	\N	\N	\N	\N	912 сп 243 сд	\N	\N	\N
382	\N	\N	\N	\N	\N	397 сд	\N	\N	\N
383	\N	\N	\N	\N	\N	153 сд	\N	\N	\N
384	\N	\N	\N	\N	\N	563 сп 153 сд	\N	\N	\N
385	\N	\N	\N	\N	\N	Ппг 463	\N	\N	\N
386	\N	\N	\N	\N	\N	243 гсп 84гсд	\N	\N	\N
387	\N	\N	\N	\N	\N	174 орр	\N	\N	\N
388	\N	\N	\N	\N	\N	261 тб 70 тбр	\N	\N	\N
389	\N	\N	\N	\N	\N	136 шап	\N	\N	\N
390	\N	\N	\N	\N	\N	9 отк	\N	\N	\N
391	\N	\N	\N	\N	\N	1117 сп	\N	\N	\N
392	\N	\N	\N	\N	\N	1320 сп	\N	\N	\N
393	\N	\N	\N	\N	\N	298 сп 186 сд	\N	\N	\N
394	\N	\N	\N	\N	\N	324 сд	\N	\N	\N
395	\N	\N	\N	\N	\N	407 сп 108 сд	\N	\N	\N
396	\N	\N	\N	\N	\N	1020 сп 269 сд	\N	\N	\N
397	\N	\N	\N	\N	\N	303 ксп	\N	\N	\N
398	\N	\N	\N	\N	\N	136 сп 97 сд	\N	\N	\N
399	\N	\N	\N	\N	\N	101 осбр	\N	\N	\N
400	\N	\N	\N	\N	\N	118 сп 37 сд	\N	\N	\N
401	\N	\N	\N	\N	\N	1 пк 85 по	\N	\N	\N
402	\N	\N	\N	\N	\N	Гв.олб 38 гв.сд	\N	\N	\N
403	\N	\N	\N	\N	\N	40 кавалер.полк	\N	\N	\N
404	\N	\N	\N	\N	\N	353 отдельная рота	\N	\N	\N
405	\N	\N	\N	\N	\N	531 сп	\N	\N	\N
406	\N	\N	\N	\N	\N	Отряд им.м.и.кутузова 1-ой дриссенской бригады	\N	\N	\N
407	\N	\N	\N	\N	\N	1298 артполк 234 сд	\N	\N	\N
408	\N	\N	\N	\N	\N	235	\N	\N	\N
409	\N	\N	\N	\N	\N	922 сап	\N	\N	\N
410	\N	\N	\N	\N	\N	В/ч 37733	\N	\N	\N
411	\N	\N	\N	\N	\N	918 сп 250 сд	\N	\N	\N
412	\N	\N	\N	\N	\N	1021 сп 307 сд	\N	\N	\N
413	\N	\N	\N	\N	\N	1019 сп 307 сд	\N	\N	\N
414	\N	\N	\N	\N	\N	115 отд.стр.бр	\N	\N	\N
415	\N	\N	\N	\N	\N	97 гв.сп 31 гв.сд	\N	\N	\N
416	\N	\N	\N	\N	\N	91 гв.сп 31 гв.сд	\N	\N	\N
417	\N	\N	\N	\N	\N	1342	\N	\N	\N
418	\N	\N	\N	\N	\N	196 отд.тбр	\N	\N	\N
419	\N	\N	\N	\N	\N	222 сп 49 сд	\N	\N	\N
420	\N	\N	\N	\N	\N	83 гв.гауб.арт.полк ргк	\N	\N	\N
421	\N	\N	\N	\N	\N	239 гв.сп 76 гв.сд	\N	\N	\N
422	\N	\N	\N	\N	\N	55 сд	\N	\N	\N
423	\N	\N	\N	\N	\N	69 сд	\N	\N	\N
424	\N	\N	\N	\N	\N	82 сд	\N	\N	\N
425	\N	\N	\N	\N	\N	983 сп 253 сд	\N	\N	\N
426	\N	\N	\N	\N	\N	193 сд	\N	\N	\N
427	\N	\N	\N	\N	\N	В/ч п/п 01144	\N	\N	\N
428	\N	\N	\N	\N	\N	68 тбр	\N	\N	\N
429	\N	\N	\N	\N	\N	516 отд.авт.батальон	\N	\N	\N
430	\N	\N	\N	\N	\N	117 сп 23 сд	\N	\N	\N
431	\N	\N	\N	\N	\N	114 гв.сп 37 гв.сд	\N	\N	\N
432	\N	\N	\N	\N	\N	71 автоп 306 сд 286 омсб	\N	\N	\N
433	\N	\N	\N	\N	\N	440 сп	\N	\N	\N
434	\N	\N	\N	\N	\N	87 гв.отд.сап.бат-н 75 гв.сд	\N	\N	\N
435	\N	\N	\N	\N	\N	152 сд	\N	\N	\N
436	\N	\N	\N	\N	\N	809 шап 264 шад	\N	\N	\N
437	\N	\N	\N	\N	\N	1027 сп 198 сд	\N	\N	\N
438	\N	\N	\N	\N	\N	923 сп 251 сд	\N	\N	\N
439	\N	\N	\N	\N	\N	556 сп 283 сд	\N	\N	\N
440	\N	\N	\N	\N	\N	Олб 283 сд	\N	\N	\N
441	\N	\N	\N	\N	\N	444 сп 108 сд	\N	\N	\N
442	\N	\N	\N	\N	\N	276 отд.арм.рота	\N	\N	\N
443	\N	\N	\N	\N	\N	186 сд	\N	\N	\N
444	\N	\N	\N	\N	\N	Парт.отр.им.сазонова	\N	\N	\N
445	\N	\N	\N	\N	\N	1322 сп 413 сд	\N	\N	\N
446	\N	\N	\N	\N	\N	В/ч п/п 66986	\N	\N	\N
447	\N	\N	\N	\N	\N	103 авиаполк	\N	\N	\N
448	\N	\N	\N	\N	\N	42 танковая бригада	\N	\N	\N
449	\N	\N	\N	\N	\N	В/ч п/п 02978	\N	\N	\N
450	\N	\N	\N	\N	\N	Эг 4629	\N	\N	\N
451	\N	\N	\N	\N	\N	680 сп 169 сд	\N	\N	\N
452	\N	\N	\N	\N	\N	4 отд.отдела авиатехснабжения 4 воздармии	\N	\N	\N
453	\N	\N	\N	\N	\N	61 обс 8 сд зап.фронта	\N	\N	\N
454	\N	\N	\N	\N	\N	518 сп 129 сд	\N	\N	\N
455	\N	\N	\N	\N	\N	14 гв сд	\N	\N	\N
456	\N	\N	\N	\N	\N	348 сд	\N	\N	\N
457	\N	\N	\N	\N	\N	168 гв.сп 55 гв.сд	\N	\N	\N
458	\N	\N	\N	\N	\N	171 гсп 1 гсд 363 омсб	\N	\N	\N
459	\N	\N	\N	\N	\N	167 гсп 1 гсд 363 омсб	\N	\N	\N
460	\N	\N	\N	\N	\N	363 омсб	\N	\N	\N
461	\N	\N	\N	\N	\N	169 гсп 1 гсд 363 омсб	\N	\N	\N
462	\N	\N	\N	\N	\N	159 тбр	\N	\N	\N
463	\N	\N	\N	\N	\N	618 сп 215 сд	\N	\N	\N
464	\N	\N	\N	\N	\N	919 сп 251 сд	\N	\N	\N
465	\N	\N	\N	\N	\N	17 кавдивизия 35 гв.кав.полк	\N	\N	\N
466	\N	\N	\N	\N	\N	17 гв.кавдивизия 35 гв.кав.полк	\N	\N	\N
467	\N	\N	\N	\N	\N	17 гв.кавдивизия 61 гв.кав.полк	\N	\N	\N
468	\N	\N	\N	\N	\N	17 гв.кавдивизия 59 гв.кав.полк	\N	\N	\N
469	\N	\N	\N	\N	\N	17 гв.кавдивизия	\N	\N	\N
470	\N	\N	\N	\N	\N	169 гсп 1 сд	\N	\N	\N
471	\N	\N	\N	\N	\N	220 сп	\N	\N	\N
472	\N	\N	\N	\N	\N	19 тб 16 гв.тб	\N	\N	\N
473	\N	\N	\N	\N	\N	75 гв.сд	\N	\N	\N
474	\N	\N	\N	\N	\N	Партиз.отряд а.ф.коваленко	\N	\N	\N
475	\N	\N	\N	\N	\N	16 гв.тбр	\N	\N	\N
476	\N	\N	\N	\N	\N	793 сп	\N	\N	\N
477	\N	\N	\N	\N	\N	73 сп	\N	\N	\N
478	\N	\N	\N	\N	\N	35 гв.отд.мин.бригада	\N	\N	\N
479	\N	\N	\N	\N	\N	1174 сп	\N	\N	\N
480	\N	\N	\N	\N	\N	99 гсп	\N	\N	\N
481	\N	\N	\N	\N	\N	В/ч п/п 07025	\N	\N	\N
482	\N	\N	\N	\N	\N	961 сп 247 сд	\N	\N	\N
483	\N	\N	\N	\N	\N	Пп 70557	\N	\N	\N
484	\N	\N	\N	\N	\N	350 сп 96 сд	\N	\N	\N
485	\N	\N	\N	\N	\N	96 опаб	\N	\N	\N
486	\N	\N	\N	\N	\N	68 опаб	\N	\N	\N
487	\N	\N	\N	\N	\N	89 тбр	\N	\N	\N
488	\N	\N	\N	\N	\N	738 лап	\N	\N	\N
489	\N	\N	\N	\N	\N	325 нбад 16 нбап	\N	\N	\N
490	\N	\N	\N	\N	\N	1323 сп 415 сд	\N	\N	\N
491	\N	\N	\N	\N	\N	10 омждб 17 ождбр	\N	\N	\N
492	\N	\N	\N	\N	\N	480 иап 11 а	\N	\N	\N
493	\N	\N	\N	\N	\N	1073 сп	\N	\N	\N
494	\N	\N	\N	\N	\N	376 сп	\N	\N	\N
495	\N	\N	\N	\N	\N	602 орс 222 сд	\N	\N	\N
496	\N	\N	\N	\N	\N	88 сд	\N	\N	\N
497	\N	\N	\N	\N	\N	79 гв.шап	\N	\N	\N
498	\N	\N	\N	\N	\N	117 сд 275 сп	\N	\N	\N
499	\N	\N	\N	\N	\N	Отряд им.в.п.чкалова	\N	\N	\N
500	\N	\N	\N	\N	\N	783 шап 199 шад	\N	\N	\N
501	\N	\N	\N	\N	\N	1086 сп 323 сд	\N	\N	\N
502	\N	\N	\N	\N	\N	152 ур	\N	\N	\N
503	\N	\N	\N	\N	\N	159 сд	\N	\N	\N
504	\N	\N	\N	\N	\N	368 лап 7 гв.лабр 3 гв.ад	\N	\N	\N
505	\N	\N	\N	\N	\N	1132 сп	\N	\N	\N
506	\N	\N	\N	\N	\N	17 гв.сбр	\N	\N	\N
507	\N	\N	\N	\N	\N	243 гв.сп 84 гв.сд	\N	\N	\N
508	\N	\N	\N	\N	\N	59 гв.шап 16 ва	\N	\N	\N
509	\N	\N	\N	\N	\N	875 сп 158 сд	\N	\N	\N
510	\N	\N	\N	\N	\N	262 сд	\N	\N	\N
511	\N	\N	\N	\N	\N	62 сп	\N	\N	\N
512	\N	\N	\N	\N	\N	Госпиталь 3	\N	\N	\N
513	\N	\N	\N	\N	\N	25 гв.тб	\N	\N	\N
514	\N	\N	\N	\N	\N	155 ур	\N	\N	\N
515	\N	\N	\N	\N	\N	40 сп 102 сд	\N	\N	\N
516	\N	\N	\N	\N	\N	37 гв сд	\N	\N	\N
517	\N	\N	\N	\N	\N	1022 сп	\N	\N	\N
518	\N	\N	\N	\N	\N	129 сбр	\N	\N	\N
519	\N	\N	\N	\N	\N	35 авиадивизия	\N	\N	\N
520	\N	\N	\N	\N	\N	646 сп 152 сд	\N	\N	\N
521	\N	\N	\N	\N	\N	646 сп	\N	\N	\N
522	\N	\N	\N	\N	\N	129 сд	\N	\N	\N
523	\N	\N	\N	\N	\N	120 сд	\N	\N	\N
524	\N	\N	\N	\N	\N	108 тбр	\N	\N	\N
525	\N	\N	\N	\N	\N	Отряд "за родину"	\N	\N	\N
526	\N	\N	\N	\N	\N	108 тбр 9 тк	\N	\N	\N
527	\N	\N	\N	\N	\N	199 сп 67 сд	\N	\N	\N
528	\N	\N	\N	\N	\N	45 оиптбр	\N	\N	\N
529	\N	\N	\N	\N	\N	24 тбр 5 тк	\N	\N	\N
530	\N	\N	\N	\N	\N	1313 сп 173 сд	\N	\N	\N
531	\N	\N	\N	\N	\N	В/ч 56256	\N	\N	\N
532	\N	\N	\N	\N	\N	1942 ипап	\N	\N	\N
533	\N	\N	\N	\N	\N	По непобедимый	\N	\N	\N
534	\N	\N	\N	\N	\N	По им.шашуры 161 бригады	\N	\N	\N
535	\N	\N	\N	\N	\N	556 сп 356 сд	\N	\N	\N
536	\N	\N	\N	\N	\N	Дра	\N	\N	\N
537	\N	\N	\N	\N	\N	1091 сп	\N	\N	\N
538	\N	\N	\N	\N	\N	317 гв.минполк	\N	\N	\N
539	\N	\N	\N	\N	\N	329 сп 70 сд	\N	\N	\N
540	\N	\N	\N	\N	\N	299 артполк	\N	\N	\N
541	\N	\N	\N	\N	\N	10 олб	\N	\N	\N
542	\N	\N	\N	\N	\N	19 мехбр	\N	\N	\N
543	\N	\N	\N	\N	\N	15 сд	\N	\N	\N
544	\N	\N	\N	\N	\N	1315 сп 173 сд	\N	\N	\N
545	\N	\N	\N	\N	\N	164 ап 2 сд	\N	\N	\N
546	\N	\N	\N	\N	\N	25 смп 25 тд 13 мк	\N	\N	\N
547	\N	\N	\N	\N	\N	Шталаг 324	\N	\N	\N
548	\N	\N	\N	\N	\N	16 армия зап.фронта	\N	\N	\N
549	\N	\N	\N	\N	\N	2 автомобильный батальон	\N	\N	\N
550	\N	\N	\N	\N	\N	104 сп 62 сд	\N	\N	\N
551	\N	\N	\N	\N	\N	344 сд	\N	\N	\N
552	\N	\N	\N	\N	\N	8 саб 1 бел.фр	\N	\N	\N
553	\N	\N	\N	\N	\N	26 гв сд	\N	\N	\N
554	\N	\N	\N	\N	\N	14 бат.связи	\N	\N	\N
555	\N	\N	\N	\N	\N	1 пп войска польского	\N	\N	\N
556	\N	\N	\N	\N	\N	3 пп войска польского	\N	\N	\N
557	\N	\N	\N	\N	\N	2 пп войска польского	\N	\N	\N
558	\N	\N	\N	\N	\N	Шталаг 315 (ii f)	\N	\N	\N
559	\N	\N	\N	\N	\N	19 гв.сд	\N	\N	\N
560	\N	\N	\N	\N	\N	61 иптд 5 сд	\N	\N	\N
561	\N	\N	\N	\N	\N	Шталаг 316	\N	\N	\N
562	\N	\N	\N	\N	\N	1320 сп 413 сд	\N	\N	\N
563	\N	\N	\N	\N	\N	17 сп 32 сд	\N	\N	\N
564	\N	\N	\N	\N	\N	421 сп	\N	\N	\N
565	\N	\N	\N	\N	\N	338 сп	\N	\N	\N
566	\N	\N	\N	\N	\N	8 отд.вост.ж/дорбат	\N	\N	\N
567	\N	\N	\N	\N	\N	Шталаг 342	\N	\N	\N
568	\N	\N	\N	\N	\N	137 сд 409 сп	\N	\N	\N
569	\N	\N	\N	\N	\N	12 сп 1 бел фр	\N	\N	\N
570	\N	\N	\N	\N	\N	34 вдо	\N	\N	\N
571	\N	\N	\N	\N	\N	1277 сп 389 сд	\N	\N	\N
572	\N	\N	\N	\N	\N	1 тб	\N	\N	\N
573	\N	\N	\N	\N	\N	1109 сп 330 сд	\N	\N	\N
574	\N	\N	\N	\N	\N	1134 сп 338 сд	\N	\N	\N
575	\N	\N	\N	\N	\N	660 ап 220 сд	\N	\N	\N
576	\N	\N	\N	\N	\N	331 сп 100 сд	\N	\N	\N
577	\N	\N	\N	\N	\N	Укнгб по минску и обл.	\N	\N	\N
578	\N	\N	\N	\N	\N	79 шап 2 шад	\N	\N	\N
579	\N	\N	\N	\N	\N	620 гап 167 сд	\N	\N	\N
580	\N	\N	\N	\N	\N	60 сд	\N	\N	\N
581	\N	\N	\N	\N	\N	480 сп 152 сд	\N	\N	\N
582	\N	\N	\N	\N	\N	57 осапб	\N	\N	\N
583	\N	\N	\N	\N	\N	451 сп 64 сд запф	\N	\N	\N
584	\N	\N	\N	\N	\N	971 ап 110 сд 50 а	\N	\N	\N
585	\N	\N	\N	\N	\N	23 сапб	\N	\N	\N
586	\N	\N	\N	\N	\N	1 отадн	\N	\N	\N
587	\N	\N	\N	\N	\N	196 пп 49 пд 24 ак	\N	\N	\N
588	\N	\N	\N	\N	\N	27 сд 239 сп	\N	\N	\N
589	\N	\N	\N	\N	\N	157 сд	\N	\N	\N
590	\N	\N	\N	\N	\N	346 сп 63 сд	\N	\N	\N
591	\N	\N	\N	\N	\N	61 сд	\N	\N	\N
592	\N	\N	\N	\N	\N	По им.молотова	\N	\N	\N
593	\N	\N	\N	\N	\N	223 гап  85 сд	\N	\N	\N
594	\N	\N	\N	\N	\N	7 стр.рота 1117сп	\N	\N	\N
595	\N	\N	\N	\N	\N	П/я 19-42 а	\N	\N	\N
596	\N	\N	\N	\N	\N	609 сп	\N	\N	\N
597	\N	\N	\N	\N	\N	422 сп 170 сд	\N	\N	\N
598	\N	\N	\N	\N	\N	612 сп 144 сд	\N	\N	\N
599	\N	\N	\N	\N	\N	160 сд	\N	\N	\N
600	\N	\N	\N	\N	\N	1028 сп 260 сд	\N	\N	\N
601	\N	\N	\N	\N	\N	3 гв.кав.див.	\N	\N	\N
602	\N	\N	\N	\N	\N	63 ск	\N	\N	\N
\.


--
-- Data for Name: common_nationality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_nationality (id, name) FROM stdin;
\.


--
-- Data for Name: common_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_person (obid, uuid, last_name, first_name, patronymic, birth_date, death_date, death_cause_id, nationality_id, deadman_category_id, documents_place_id, information_source_id, creator_id, date_of_creation, is_trash, oblocationid, info, burial_id, birth_date_no_month, birth_date_no_day, death_date_no_month, death_date_no_day, mia, outside_rb) FROM stdin;
\.


--
-- Data for Name: common_person_closed_burials; Type: TABLE DATA; Schema: public; Owner: ilvar
--

COPY common_person_closed_burials (id, person_id, burial_id) FROM stdin;
\.


--
-- Data for Name: common_personcall; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_personcall (unit_id, date, person_id) FROM stdin;
\.


--
-- Data for Name: common_personduty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_personduty (unit_id, rank_id, post_id, person_id) FROM stdin;
\.


--
-- Data for Name: common_personeditcause; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_personeditcause (id, person_id, name, number, date, date_edit, file) FROM stdin;
\.


--
-- Data for Name: common_personinformationlinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_personinformationlinks (id, person_id, link) FROM stdin;
\.


--
-- Data for Name: common_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_post (id, name) FROM stdin;
5	Автоматчик
6	Оруд.номер
7	Стрелок
8	Ком.роты
9	Бомбардир
10	Политрук
11	Механик-водитель
12	Повозочный
13	Ком.взвода
14	Командир отделения
15	Сапер
16	Командир пулем.роты
17	Воздушный стрелок
18	Командир эскадрильи
19	Летчик
20	Зам.ком-ра по политчасти
21	Зам.ком.роты
22	Ком.батальона
23	Разведчик
24	Пулеметчик
25	Подносчик мин
26	Пом.ком.батареи
27	Стр
28	Командир расчета
29	Повозорчный батарей 76мм пушки
30	Санинструктор
31	Наводчик
32	Пом.нач.штаба
33	Воентехник
34	Парторг батальона
35	Минометчик
36	Старшина
37	Командир экипажа, летчик
38	Сигнальщик
39	Птр
40	Командир орудия
41	Телефонист
42	511 омсб
43	Ком.пул.роты
44	Связной
45	Нач.фин.части
46	Пулеметчик танка
47	Ком.звена, летчик
48	Пом.наводчика
49	Ком.отделения
50	Зам.ком.бата
51	Коновод заставы боевого обеспечения
52	Партизан
53	Ком.стр.роты
54	Разведчик-наблюдатель
55	Наводчик орудия
56	Командир взвода связи
57	Пом.трактор.
58	Мастер оруд.
59	Бронебойщик
60	Начальник штаба
61	Ком.отдел.
62	По.ком.взаода
63	Старший летчик
64	Штурман
65	Плотник-мостовик
66	Зам.командира эскадрильи
67	Командир отряда
68	Командир звена
69	Зам.ком.отд.
70	Механик-водитель танка
71	Командир
72	Ст.политрук
73	Шофер
74	Командир стрелк.взвода
75	Ком.эскадрона
76	Зам.ком.полка
77	Стрелок-лыжник олб
78	Наводчик птр
79	Командир взвода
80	Пехота
81	Зам.начальника артиллерии
82	Командир разведвзвода
83	Пом.ком.взвода
84	Танкист
85	Нач.секретариата
86	Начальник
87	Возд.стрелок
88	Зам.политрука
89	Ком.отделения птр
90	Ст.телефонист
91	Ст.чертежник
92	Ком.рем.взвода
93	Наводчик 76мм орудия
94	Зам.ком.отделения
95	Сан.рота
96	Сабельщик
97	Ездовой
98	Конный инструктор
\.


--
-- Data for Name: common_rank; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_rank (id, obid, name) FROM stdin;
1	47767	Красноар-ц
2	47768	Гв.с-т(фер.)
3	47769	Гвардии старший
4	47770	Полковник
5	47772	Ст.прапорщик
6	47773	Мл.сержант
7	47774	Ст.техн.лейт-т
8	47775	Комисар
9	47776	Ген.-майор
10	47777	Ген.армии
11	47778	Стрелок птр
12	47779	Поручик
13	47780	Ст.телеф.
14	47781	Контр-адмирал
15	47782	Мл.серж
16	47783	16сержант
17	47784	Красноармеец
18	47785	Воспитанник
19	47786	Старшина
20	47787	Рядовой
21	47788	Лейтенант
22	47789	Старш.1-й ст.
23	47790	Командир отделе
24	47791	Мл.лейтенант
25	47792	Краснофл-ц
26	47793	Адм.
27	47795	Воинское звание
28	47796	Кр-ц,пар-н
29	47798	Жертв.войны
30	47799	Вольнонаемная
31	47800	Старший сержант
32	47801	Командир взвода
33	47802	Старш.2-й ст.
34	47803	Техник
35	47804	Политрук
36	47805	Вице адмирал
37	47806	Мл.серж-т
38	47807	Гл.старшина
39	47808	В/ветфельд.
40	47809	Ком.олыжб
41	47810	Служащая
42	47811	Капрал
43	47812	Кр-ц,партиза
44	47813	Ген.-лейтенант
45	47814	В.-адм.
46	47815	Фельдшер
47	47816	Ст.с-т(ст-на
48	47817	Подпоручик
49	47818	Техн.лейтенант
50	47819	Военноплен.
51	47820	Ст.серж-т
52	47821	Мл.с-нт
53	47822	Адмирал
54	47823	Ефр.,сапер
55	47824	Ст.сержант
56	47825	Воентехник втор
57	47826	Ком.состав
58	47827	Техник интендан
59	47828	Курсант
60	47829	С-т,ветфел-р
61	47830	Медсестра
62	47831	Интенд.1 ранга
63	47832	Техник -л-т
64	47833	Майор
65	47834	Интенд.2 ранга
66	47835	Военный комисса
67	47836	Командир
68	47837	Белин
69	47838	В/техник 2р
70	47839	Солд
71	47840	Мл. командир
72	47841	Инж.,м-р
73	47842	В/техник 3р
74	47843	Камандир
75	47844	Ст.политрук
76	47845	Мл. лейтенант
77	47846	Л-т,тех-стро
78	47847	Техник-интендан
79	47848	Зв.неизв.
80	47850	Лин.надсмотр
81	47851	Служащий
82	47852	В/техник 1р
83	47853	Мл.л-т,политрук
84	47854	Участник сопрот
85	47855	Интенд.3 ранга
86	47856	Матрос
87	47857	В/юрист
88	47858	Участн.сопрот.
89	47859	Сержант
90	47860	Кр-ц,развед.
91	47861	Прапорщик
92	47862	В/инженер 3р
93	47863	Интенд. 2р.
94	47864	В/фельдшер
95	47865	В/нврач
96	47866	Мичман
97	47867	Санитар
98	47868	Мл.политрук
99	47869	Ефрейтор
100	47870	Санинструктор
101	47871	Кап.лейтенант
102	47872	В/врач
103	47873	Зам. политрука
104	47874	Следователь
105	47875	Ротмистр
106	47876	Л-т(кр-ц)
107	47877	Кап.1-го ранга
108	47878	Л-т комвзвода 5
109	47879	Ветсанитар
110	47880	Хорунжий
111	47881	В/врач 3 р.
112	47882	Вет/фельдшер
113	47883	Мл.
114	47884	Капитан
115	47885	Зван.неизв.
116	47886	Ст.матрос
117	47887	П/полк.(с-т)
118	47888	Ввет-врач 2 р
119	47889	В/инженер 2р
120	47890	Кап.2-го ранга
121	47891	П/полковник
122	47892	Жертвы войн
123	47893	Ст.лейтенант
124	47894	Партизан
125	47895	Франц.партиз
126	47896	Офицер,механ
127	47897	Вет/фельд.
128	47898	Ст.л-т
129	47899	В/инженер 1р
130	47922	Мл.унтер-офицер
131	47794	Канонир
132	47900	Ст.унтер-офицер
133	47797	Бомбардир
134	47923	Штабс-капитан
135	47924	Офицер
136	47771	Ст-на
137	47929	Ст.с-нт
138	47849	Поручик (ст. л-т)
\.


--
-- Data for Name: common_searchobject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_searchobject (id, number, date, inv_number, burial_id, link) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
1	2011-07-09 07:46:46.708514-05	1	18	1	Вторая мировая война	1	
2	2011-07-09 07:46:48.74695-05	1	19	1	Вторая мировая война	2	Изменен military_conflict_type.
3	2011-07-09 08:07:30.271088-05	1	25	e12db056-a580-11e0-8598-00003975d28a	Абадовский	2	Изменен death_cause.
4	2011-07-15 04:57:39.90104-05	1	3	2	vladimir	1	
5	2011-07-15 04:59:00.982178-05	1	3	2	vladimir	2	Изменен is_staff и user_permissions.
6	2011-07-15 06:15:26.956268-05	1	21	1	решение Администрации	1	
7	2011-07-15 06:15:33.813713-05	1	31	2cfe5c94-a4ad-11e0-bd5f-00003975d28a	7184	2	Добавлен Перенос захоронения "ClosedBurial object".
8	2011-07-15 06:17:22.923824-05	1	37	1c3fe99a-a4ad-11e0-bd5f-00003975d28a	ClosedBurial object	3	
9	2011-07-15 06:18:14.604112-05	1	31	2cfe5c94-a4ad-11e0-bd5f-00003975d28a	7184	2	Добавлен Перенос захоронения "ClosedBurial object".
10	2011-07-15 11:30:55.999841-05	1	37	2cfe5c94-a4ad-11e0-bd5f-00003975d28a	ClosedBurial object	3	
11	2011-07-16 02:09:10.952346-05	1	31	2cfdc45a-a4ad-11e0-bd5f-00003975d28a	2932	2	Добавлен Перенос захоронения "ClosedBurial object".
12	2011-07-16 05:28:27.80835-05	1	37	2cfdc45a-a4ad-11e0-bd5f-00003975d28a	ClosedBurial object	2	Изменен burial_to.
13	2011-07-16 05:46:55.866558-05	1	31	2cfdc45a-a4ad-11e0-bd5f-00003975d28a	2932	2	Изменен qunknown.
14	2011-07-16 05:47:31.448839-05	1	31	1c42e474-a4ad-11e0-bd5f-00003975d28a	13	2	Изменен qunknown.
15	2011-07-16 05:47:46.162542-05	1	31	1c42e474-a4ad-11e0-bd5f-00003975d28a	13	2	Изменен qunknown.
16	2011-07-16 05:47:59.070048-05	1	31	2cfdc45a-a4ad-11e0-bd5f-00003975d28a	2932	2	Изменен qunknown.
17	2011-07-16 05:50:19.697861-05	1	37	2cfdc45a-a4ad-11e0-bd5f-00003975d28a	ClosedBurial object	3	
18	2011-07-16 07:24:58.609761-05	1	31	2cfdc45a-a4ad-11e0-bd5f-00003975d28a	2932	2	Добавлен Перенос захоронения "ClosedBurial object".
19	2011-07-16 11:53:46.745883-05	1	31	1c42e474-a4ad-11e0-bd5f-00003975d28a	13	2	Добавлен Перенос захоронения "ClosedBurial object".
20	2011-07-16 11:54:14.574899-05	1	31	1c42e474-a4ad-11e0-bd5f-00003975d28a	13	2	Удален Перенос захоронения "ClosedBurial object".
21	2011-07-17 02:42:00.328334-05	1	3	2	mil	2	Изменен username.
22	2011-07-29 03:46:45.942797-05	2	11	2418	Г. Новополоцк	2	Изменен name.
23	2011-07-29 03:46:53.619788-05	2	11	2417	Г.орша	2	Ни одно поле не изменено.
24	2011-07-29 03:47:12.713843-05	2	11	2417	Г.Орша	2	Изменен name.
25	2011-07-29 03:47:27.858093-05	2	11	2416	Г.Пинск	2	Изменен name.
26	2011-07-29 03:47:33.281978-05	2	11	2416	Г.Пинск	2	Ни одно поле не изменено.
27	2011-07-29 07:26:29.867145-05	2	21	2	письмо РИК №  от	1	
28	2011-07-29 07:26:46.978448-05	2	21	2	письмо РИК №  от	3	
29	2011-07-29 08:20:37.031199-05	2	31	8c0b6658-b9e5-11e0-990e-00163e45e1c0	7192	1	
30	2011-10-03 01:42:35.565396-05	1	3	3	ilvar	1	
31	2011-10-03 01:42:45.610769-05	1	3	3	ilvar	2	Изменен is_staff и is_superuser.
32	2011-10-10 09:07:37.61611-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
33	2011-10-10 10:39:49.184555-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
34	2011-10-10 10:40:55.802236-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
35	2011-10-10 10:42:41.424338-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
36	2011-10-10 10:45:23.889117-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
37	2011-10-10 10:46:40.614701-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
38	2011-10-10 10:47:24.55006-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
39	2011-10-10 10:49:50.570774-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
40	2011-10-10 10:50:42.173613-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
41	2011-10-10 10:52:39.25163-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
42	2011-10-10 10:53:16.305483-05	4	25	a24bed0e-a57f-11e0-8598-00003975d28a	Аамман	2	Изменен birth_date и death_date.
43	2011-10-16 12:10:14.277318-05	4	25	e11edd6a-a580-11e0-8598-00003975d28a	Аайрахан	2	Изменен burial,birth_date и death_date.
44	2011-10-16 12:10:46.515263-05	4	31	24297b44-a4ad-11e0-bd5f-00003975d28a	1079	2	Добавлен Перенос захоронения "ClosedBurial object".
45	2011-10-16 12:15:23.243124-05	4	31	232b4b8c-a4ad-11e0-bd5f-00003975d28a	1	2	Добавлен Перенос захоронения "ClosedBurial object".
46	2011-10-16 12:16:48.488705-05	4	31	232f73a6-a4ad-11e0-bd5f-00003975d28a	10	2	Добавлен Перенос захоронения "ClosedBurial object".
47	2011-10-16 12:18:30.527015-05	4	31	2a2c2bd6-a4ad-11e0-bd5f-00003975d28a	100	2	Добавлен Перенос захоронения "ClosedBurial object".
48	2011-10-16 12:22:17.229441-05	4	31	1d1ec890-a4ad-11e0-bd5f-00003975d28a	1000	2	Добавлен Перенос захоронения "ClosedBurial object".
49	2011-10-16 12:24:02.509654-05	4	31	241e7af0-a4ad-11e0-bd5f-00003975d28a	1001	2	Добавлен Перенос захоронения "Закрыто: решение Администрации".
50	2011-10-16 12:31:59.157391-05	4	31	241e7af0-a4ad-11e0-bd5f-00003975d28a	1001	2	Изменены document для Перенос захоронения "Закрыто: решение Администрации".
51	2011-10-28 11:57:00.364339-05	4	25	a24cc49a-a57f-11e0-8598-00003975d28a	Аасумов	2	Изменен birth_date и death_date. Добавлен Основание для редакирования Воина "Паспорт".
52	2011-10-29 13:28:28.992777-05	4	31	cc26cd04-025b-11e1-8696-00265eeda3e3	без паспорта	1	
53	2011-10-29 13:30:21.038677-05	4	31	0f04ba64-025c-11e1-b884-00265eeda3e3	без паспорта	1	
54	2011-11-13 17:10:53.323092-05	4	31	2420cc7e-a4ad-11e0-bd5f-00003975d28a	1007	2	Изменены unknown для Количество захороненных "1007 - Другие".
55	2011-11-13 17:17:46.237694-05	4	31	232f73a6-a4ad-11e0-bd5f-00003975d28a	10	2	Изменен date_gosznak.
56	2011-11-28 14:15:39.772691-05	4	25	5bcae7be-19f5-11e1-a03f-00265eeda3e3	Ааулич	1	
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	permission	auth	permission
2	group	auth	group
3	user	auth	user
4	content type	contenttypes	contenttype
5	session	sessions	session
6	site	sites	site
7	log entry	admin	logentry
8	migration history	south	migrationhistory
9	страна	common	geocountry
10	регион	common	georegion
11	населенный пункт	common	geocity
12	улица	common	geostreet
13	воинское звание	common	rank
14	Причина гибели	common	deathcause
15	Категория погибшего	common	deadmancategory
16	Место нахождения документов	common	documentsplace
17	Тип воинского захоронения	common	burialtype
18	Тип военного конфликта	common	militaryconflicttype
19	Военный конфликт	common	militaryconflict
20	Источник информации	common	informationsource
21	Причина закрытия захоронения	common	closurecause
22	Национальность	common	nationality
23	Должность	common	post
24	Воинское подразделение	common	militaryunit
25	Погибший	common	person
26	Место призыва	common	personcall
27	История службы	common	personduty
28	Основание для редакирования Воина	common	personeditcause
29	Ссылка на информационные источники	common	personinformationlinks
30	Адрес рождения	common	locationbirth
31	Захоронение	common	burial
32	Захоронения военнослужащего	common	personburial
33	Основание для внесения изменения	common	burialeditcause
34	Фотография захоронения	common	burialpictures
35	Ссылка на информационные источники	common	burialinformationlinks
36	Поисковый объект	common	searchobject
37	Входящие захоронения	common	closedburial
38	Адрес захоронения	common	locationburial
39	source	easy_thumbnails	source
40	thumbnail	easy_thumbnails	thumbnail
41	Состояние памятника	common	memorialstate
42	message	auth	message
43	grouped message	sentry	groupedmessage
44	message	sentry	message
45	filter value	sentry	filtervalue
46	message filter value	sentry	messagefiltervalue
47	message count by minute	sentry	messagecountbyminute
48	message index	sentry	messageindex
49	Связь категории с захоронением	common	burialcategory
50	Военкомат	common	comissariat
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
6713f011758c79844320b9bc60632c49	ODgxOTIxODJmYWMxNzZjMjYyNjBlYjgyY2RmZmRjNjUzOGQzZDIwNzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2011-07-23 07:46:03.469655-05
c04a2dd690c1c02cfd2feb6e94621b4a	YmE0YTdmZmQwMjIyNzQ2YTU5ZDA0ZDc5NjQ5MDcxZDc4MWE5ZTU3MDqAAn1xAVUKdGVzdGNvb2tp\nZVUGd29ya2VkcQJzLg==\n	2011-07-21 05:33:55.405657-05
37e739e5135ea2827ecb984a01b9c9fc	ODgxOTIxODJmYWMxNzZjMjYyNjBlYjgyY2RmZmRjNjUzOGQzZDIwNzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2011-07-29 01:27:18.279355-05
cc018c9a6c2c65fff2e7c82b6dc28157	NjkyZjE5NDlkNmY0MDEyM2EyMWFkMzMxZDFhOGM4YTY2N2JkMDExOTqAAn1xAS4=\n	2011-07-29 11:30:31.337171-05
4fcf781cf08bcca25bcffc68856da6af	ODgxOTIxODJmYWMxNzZjMjYyNjBlYjgyY2RmZmRjNjUzOGQzZDIwNzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2011-07-29 11:30:35.847263-05
d2c8365dd2b54605fc883d438b2544b7	ODgxOTIxODJmYWMxNzZjMjYyNjBlYjgyY2RmZmRjNjUzOGQzZDIwNzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2011-07-30 01:43:51.181-05
5c624aaf0ece02d1bc721b5920a10503	N2Q2ZjAwZmU5N2MxNjU1NDRiZGVmYTkyY2EyNzNiY2M3MzU0MWNlMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAnUu\n	2011-07-31 02:42:17.923917-05
e62c5273bd05206482e1c111fff6437d	N2Q2ZjAwZmU5N2MxNjU1NDRiZGVmYTkyY2EyNzNiY2M3MzU0MWNlMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAnUu\n	2011-08-02 04:41:13.617522-05
6be3b5ea229a55d4fd415059ce4ff412	NWFjYjU4YWU4ZTgxMzMyMTJlODdmNjczYTUxZmJmMTIxMjc2M2ZiZTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2011-08-09 04:50:22.998266-05
f143bc76be4d4af6b59300fc7cf6fe86	NWFjYjU4YWU4ZTgxMzMyMTJlODdmNjczYTUxZmJmMTIxMjc2M2ZiZTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2011-08-10 09:04:02.721378-05
9a02dcaf68bbda45641e691200f81ef6	NWFjYjU4YWU4ZTgxMzMyMTJlODdmNjczYTUxZmJmMTIxMjc2M2ZiZTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2011-10-17 01:31:26.611941-05
e5cad4a05e95de6a342007cee4e5eb1d	ODgxOTIxODJmYWMxNzZjMjYyNjBlYjgyY2RmZmRjNjUzOGQzZDIwNzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2011-10-17 01:41:05.15683-05
5bc658ce50b12799a7e93a68d6ef140a	NWFjYjU4YWU4ZTgxMzMyMTJlODdmNjczYTUxZmJmMTIxMjc2M2ZiZTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2011-10-18 08:28:54.060663-05
820d32d703eb2529e650466638e15bf3	MDY5ZDJmMjczMDgyNWRjY2Q1MGZlNzg0ZWFjMTMzMDRiYzYwNTA0NTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2011-10-20 01:24:21.157382-05
691f9dbc5e1fc07077bd42185cbcd9d7	NmZkOWI3YTBmOTk2ZTUyMDgwOTBiZjY1NGY5ZTRjMTJlZjdhNWMzMDqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2011-10-24 08:56:52.901226-05
e28511a440385b31d2d4c88024f4daad	NmZkOWI3YTBmOTk2ZTUyMDgwOTBiZjY1NGY5ZTRjMTJlZjdhNWMzMDqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2011-10-25 12:52:00.052928-05
1997f369babcc79aec06977361b1b0ec	NmZkOWI3YTBmOTk2ZTUyMDgwOTBiZjY1NGY5ZTRjMTJlZjdhNWMzMDqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2011-10-28 14:34:05.780241-05
4a8c117f00bb13a56a963e448d38ff8f	NmZkOWI3YTBmOTk2ZTUyMDgwOTBiZjY1NGY5ZTRjMTJlZjdhNWMzMDqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2011-10-30 11:18:57.780208-05
88df2bfac4e79ac7d4dbe09d49149e3d	NmZkOWI3YTBmOTk2ZTUyMDgwOTBiZjY1NGY5ZTRjMTJlZjdhNWMzMDqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2011-11-11 11:36:37.575788-05
8699ec970ec039e64f7e647e760a4200	ODg3N2Y3YzdkZDEzNzIzOWJiZDc5YWRjOTVkMDA4NzI5NGI3YjI0NjqAAn1xAVUKdGVzdGNvb2tp\nZVUGd29ya2VkcQJzLg==\n	2011-11-13 13:59:14.789667-05
4f847c00e58c319895ec4836a8441266	NmZkOWI3YTBmOTk2ZTUyMDgwOTBiZjY1NGY5ZTRjMTJlZjdhNWMzMDqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2011-11-26 18:29:09.020181-05
50092b77712d4c73aa9ec0b17f780dcc	NmZkOWI3YTBmOTk2ZTUyMDgwOTBiZjY1NGY5ZTRjMTJlZjdhNWMzMDqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2011-11-27 17:01:29.991102-05
c96e7832a7fa0fdf71e1a9e00d04d412	NmZkOWI3YTBmOTk2ZTUyMDgwOTBiZjY1NGY5ZTRjMTJlZjdhNWMzMDqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2011-12-12 14:10:55.925187-05
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Data for Name: easy_thumbnails_source; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY easy_thumbnails_source (id, name, modified, storage_hash) FROM stdin;
\.


--
-- Data for Name: easy_thumbnails_thumbnail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY easy_thumbnails_thumbnail (id, name, modified, source_id, storage_hash) FROM stdin;
\.


--
-- Data for Name: sentry_filtervalue; Type: TABLE DATA; Schema: public; Owner: ilvar
--

COPY sentry_filtervalue (id, key, value) FROM stdin;
1	server_name	ilvar-ThinkPad-X200s
2	site	example.com
3	logger	root
\.


--
-- Data for Name: sentry_groupedmessage; Type: TABLE DATA; Schema: public; Owner: ilvar
--

COPY sentry_groupedmessage (id, logger, class_name, level, message, traceback, view, checksum, status, times_seen, last_seen, first_seen, data, score) FROM stdin;
1	root	TypeError	40	unsupported operand type(s) for +: 'int' and 'NoneType'	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 284, in burials\n    'all': all_count + unknown_count,\n\nTypeError: unsupported operand type(s) for +: 'int' and 'NoneType'\n	common.views.burials	87abeda2f91442d05cb1ab4b24fd528f	0	1	2011-11-14 01:23:15.421599-05	2011-11-14 01:23:15.421599-05	eJxdj0FqwzAQRfe+h5SubMmhjRMYQkKaC/QAQpHleEC2xGi88O0rJ3RTBj6Pz/zPzEefdPWzWyjsqtQWGpnTqWl0e6hVGX3qlFLNYyG0ITdn9lMKlj2QT5E4i/b+JvNZjzwF6eIyM62gJfknxhm+pENeYa/lu8Qkm/OWwB42i9D3pi+VZqA4/bM4wl+M1+RBThiQLa3GxXkI6BgkzkPZyrxdJbO35EYQNyWO902v3y/txE2LTr/4Ul7dV7n+Be2PU6A=	1321251795
2	root	DoesNotExist	40	GeoRegion matching query does not exist.	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 248, in burials\n    'region': GeoRegion.objects.get(name=['region']),\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/db/models/manager.py", line 132, in get\n    return self.get_query_set().get(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/db/models/query.py", line 349, in get\n    % self.model._meta.object_name)\n\nDoesNotExist: GeoRegion matching query does not exist.\n	common.views.burials	bb2231f956a641d99ed3e4b50bfbbc6c	0	1	2011-11-28 04:49:02.452277-05	2011-11-28 04:49:02.452277-05	eJxdT8GqwjAQvPc/Ej21SQSthfB4D/UH/IAQ09QupE3YbA/9+5cqXmRhmB12htl9n2R13y0YdlVShY1EqWsaqU61KCO7VgjRPBYEG3LzQ35KwZLX6FNEykzd3swoW480Be7iMhOuWnL0T4izVtwBlf3I3ykm2Zw3C/R6kxB8b/qSaQaM05dEUX9stCav+QQByOJqXJyHAI40h3koV5m2Wjx7i27U7CLY+bbh3/WFLbtI1soX/y2/Hqpc/wNFslP9	1322473742
3	root	MultipleObjectsReturned	40	get() returned more than one GeoCity -- it returned 2! Lookup parameters were {'name': <GeoCity: Ленинский>}	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 255, in burials\n    'city': GeoCity.objects.get(name=cd['city']),\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/db/models/manager.py", line 132, in get\n    return self.get_query_set().get(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/db/models/query.py", line 351, in get\n    % (self.model._meta.object_name, num, kwargs))\n\nMultipleObjectsReturned: get() returned more than one GeoCity -- it returned 2! Lookup parameters were {'name': <GeoCity: Ленинский>}\n	common.views.burials	230edbd734456c81a356a8dd4d7f7aa4	0	1	2011-11-28 04:49:34.937898-05	2011-11-28 04:49:34.937898-05	eJxdj0FqwzAQRfe+h5SsbMktqRMYSkOaC/QAQpHleEC2xGi88O0jJ2RTBj6Pz/zPzL5PuvrbLRR2VWoLjczp1DS6/apVGX3qlFLNbSG0ITff7KcULHsgnyJxFu31Raa91SNPQbq4zEwraEn+jnGGg3TIKxw+5avFJJvzFsEeNovQ96YvnWagOP2zOMI7xmvyICcMyJZW4+I8BHQMEuehbGXezpLZW3IjiIsSx+um59+nduKiRaef/FN+/ahy/QBKh1QF	1322473774
6	root	TemplateSyntaxError	40	Caught AttributeError while rendering: type object 'CheckboxInput' has no attribute 'attrs'	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/options.py", line 307, in wrapper\n    return self.admin_site.admin_view(view)(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/utils/decorators.py", line 93, in _wrapped_view\n    response = view_func(request, *args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/views/decorators/cache.py", line 79, in _wrapped_view_func\n    response = view_func(request, *args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/sites.py", line 197, in inner\n    return view(request, *args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/utils/decorators.py", line 28, in _wrapper\n    return bound_func(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/utils/decorators.py", line 93, in _wrapped_view\n    response = view_func(request, *args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/utils/decorators.py", line 24, in bound_func\n    return func(self, *args2, **kwargs2)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/db/transaction.py", line 217, in inner\n    res = func(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/options.py", line 938, in add_view\n    return self.render_change_form(request, context, form_url=form_url, add=True)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/options.py", line 708, in render_change_form\n    ], context, context_instance=context_instance)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/shortcuts/__init__.py", line 20, in render_to_response\n    return HttpResponse(loader.render_to_string(*args, **kwargs), **httpresponse_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader.py", line 188, in render_to_string\n    return t.render(context_instance)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 123, in render\n    return self._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 127, in render\n    return compiled_parent._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 127, in render\n    return compiled_parent._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 127, in render\n    return compiled_parent._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 64, in render\n    result = block.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/defaulttags.py", line 227, in render\n    nodelist.append(node.render(context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 159, in render\n    return self.render_template(self.template, context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 141, in render_template\n    output = template.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 123, in render\n    return self._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/defaulttags.py", line 227, in render\n    nodelist.append(node.render(context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/defaulttags.py", line 227, in render\n    nodelist.append(node.render(context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/defaulttags.py", line 313, in render\n    return self.nodelist_false.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 90, in render\n    output = self.filter_expression.resolve(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 510, in resolve\n    obj = self.var.resolve(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 653, in resolve\n    value = self._resolve_lookup(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 698, in _resolve_lookup\n    current = current()\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/helpers.py", line 128, in label_tag\n    return self.field.label_tag(contents=contents, attrs=attrs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/forms/forms.py", line 489, in label_tag\n    id_ = widget.attrs.get('id') or self.auto_id\n\nTemplateSyntaxError: Caught AttributeError while rendering: type object 'CheckboxInput' has no attribute 'attrs'\n	admin/includes/fieldset.html	a8f831f5cdcdb1027347451ebc473ef3	0	1	2011-11-28 22:12:18.91199-05	2011-11-28 22:12:18.91199-05	eJzTSCkw5ApWLy3KUecqMAKyMkpKCqz09Q2NzPUMgNDQysLAwEA/MSU3M08/OT83Nz9PvyC1qBhIJaak6AM1GXMV6wEAsTUUJw==	1322536338
4	root	TemplateSyntaxError	40	Unclosed tag 'if'. Looking for one of: else, endif 	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 420, in burials\n    return render_to_response(template, context_instance = RequestContext(request, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/shortcuts/__init__.py", line 20, in render_to_response\n    return HttpResponse(loader.render_to_string(*args, **kwargs), **httpresponse_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 181, in render_to_string\n    t = get_template(template_name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 157, in get_template\n    template, origin = find_template(template_name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 134, in find_template\n    source, display_name = loader(name, dirs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 42, in __call__\n    return self.load_template(template_name, template_dirs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 48, in load_template\n    template = get_template_from_string(source, origin, template_name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 168, in get_template_from_string\n    return Template(source, origin, name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 108, in __init__\n    self.nodelist = compile_string(template_string, origin)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 136, in compile_string\n    return parser.parse()\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 239, in parse\n    compiled_result = compile_func(self, token)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/defaulttags.py", line 787, in do_for\n    nodelist_loop = parser.parse(('empty', 'endfor',))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 239, in parse\n    compiled_result = compile_func(self, token)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/defaulttags.py", line 922, in do_if\n    nodelist_true = parser.parse(('else', 'endif'))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 246, in parse\n    self.unclosed_block_tag(parse_until)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/debug.py", line 64, in unclosed_block_tag\n    raise self.source_error(source, msg)\n\nTemplateSyntaxError: Unclosed tag 'if'. Looking for one of: else, endif \n	reports/report_2a.html	a8f831f5cdcdb1027347451ebc473ef3	0	2	2011-11-28 05:01:10.45192-05	2011-11-28 04:57:00.988749-05	eJxdT8GqwjAQvPc/Ej21SQSthfB4D/UH/IAQ09QupE3YbA/9+5cqXmRhmB12htl9n2R13y0YdlVShY1EqWsaqU61KCO7VgjRPBYEG3LzQ35KwZLX6FNEykzd3swoW480Be7iMhOuWnL0T4izVtwBlf3I3ykm2Zw3C/R6kxB8b/qSaQaM05dEUX9stCav+QQByOJqXJyHAI40h3koV5m2Wjx7i27U7CLY+bbh3/WFLbtI1soX/y2/Hqpc/wNFslP9	1322474220
5	root	TemplateSyntaxError	40	Caught TypeError while rendering: 'Page' object is not iterable	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 449, in burials\n    return render_to_response(template, context_instance = RequestContext(request, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/shortcuts/__init__.py", line 20, in render_to_response\n    return HttpResponse(loader.render_to_string(*args, **kwargs), **httpresponse_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 188, in render_to_string\n    return t.render(context_instance)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 123, in render\n    return self._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/defaulttags.py", line 190, in render\n    values = list(values)\n\nTemplateSyntaxError: Caught TypeError while rendering: 'Page' object is not iterable\n	reports/report_2b.html	a8f831f5cdcdb1027347451ebc473ef3	0	1	2011-11-28 05:23:11.954802-05	2011-11-28 05:23:11.954802-05	eJxdj0FqwzAQRfe+h5SsbMktqRMYSkOaC/QAQpHleEC2xGi88O0jJ2RTBj6Pz/zPzL5PuvrbLRR2VWoLjczp1DS6/apVGX3qlFLNbSG0ITff7KcULHsgnyJxFu31Raa91SNPQbq4zEwraEn+jnGGg3TIKxw+5avFJJvzFsEeNovQ96YvnWagOP2zOMI7xmvyICcMyJZW4+I8BHQMEuehbGXezpLZW3IjiIsSx+um59+nduKiRaef/FN+/ahy/QBKh1QF	1322475791
\.


--
-- Data for Name: sentry_message; Type: TABLE DATA; Schema: public; Owner: ilvar
--

COPY sentry_message (id, logger, class_name, level, message, traceback, view, url, server_name, checksum, datetime, data, group_id, site, message_id) FROM stdin;
1	root	TypeError	40	unsupported operand type(s) for +: 'int' and 'NoneType'	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 284, in burials\n    'all': all_count + unknown_count,\n\nTypeError: unsupported operand type(s) for +: 'int' and 'NoneType'\n	common.views.burials	http://127.0.0.1:8000/burials/?template=reports%2Freport_5.html&country=1&region=6&city=31&burial_passportid=&burried_date_from=&burried_date_to=&burial_type=&military_conflict=&info=&state=&search=%D	ilvar-ThinkPad-X200s	87abeda2f91442d05cb1ab4b24fd528f	2011-11-14 01:23:15.421599-05	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	1	example.com	d55ac99645644c788ccc00105fcb3dfa
2	root	DoesNotExist	40	GeoRegion matching query does not exist.	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 248, in burials\n    'region': GeoRegion.objects.get(name=['region']),\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/db/models/manager.py", line 132, in get\n    return self.get_query_set().get(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/db/models/query.py", line 349, in get\n    % self.model._meta.object_name)\n\nDoesNotExist: GeoRegion matching query does not exist.\n	common.views.burials	http://127.0.0.1:8000/burials/?template=reports%2Freport_2a.html&country=1&region=2&city=16&burial_passportid=&burried_date_from=&burried_date_to=&burial_type=&military_conflict=&info=&state=&search=%	ilvar-ThinkPad-X200s	bb2231f956a641d99ed3e4b50bfbbc6c	2011-11-28 04:49:02.452277-05	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	2	example.com	28c7ee58be684d95a418219b7ed8c17a
3	root	MultipleObjectsReturned	40	get() returned more than one GeoCity -- it returned 2! Lookup parameters were {'name': <GeoCity: Ленинский>}	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 255, in burials\n    'city': GeoCity.objects.get(name=cd['city']),\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/db/models/manager.py", line 132, in get\n    return self.get_query_set().get(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/db/models/query.py", line 351, in get\n    % (self.model._meta.object_name, num, kwargs))\n\nMultipleObjectsReturned: get() returned more than one GeoCity -- it returned 2! Lookup parameters were {'name': <GeoCity: Ленинский>}\n	common.views.burials	http://127.0.0.1:8000/burials/?template=reports%2Freport_2b.html&country=1&region=6&city=64&burial_passportid=&burried_date_from=&burried_date_to=&burial_type=&military_conflict=&info=&state=&search=%	ilvar-ThinkPad-X200s	230edbd734456c81a356a8dd4d7f7aa4	2011-11-28 04:49:34.937898-05	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	3	example.com	82839d87a71441a9b2bfe9363a2e059e
4	root	TemplateSyntaxError	40	Unclosed tag 'if'. Looking for one of: else, endif 	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 420, in burials\n    return render_to_response(template, context_instance = RequestContext(request, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/shortcuts/__init__.py", line 20, in render_to_response\n    return HttpResponse(loader.render_to_string(*args, **kwargs), **httpresponse_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 181, in render_to_string\n    t = get_template(template_name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 157, in get_template\n    template, origin = find_template(template_name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 134, in find_template\n    source, display_name = loader(name, dirs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 42, in __call__\n    return self.load_template(template_name, template_dirs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 48, in load_template\n    template = get_template_from_string(source, origin, template_name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 168, in get_template_from_string\n    return Template(source, origin, name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 108, in __init__\n    self.nodelist = compile_string(template_string, origin)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 136, in compile_string\n    return parser.parse()\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 239, in parse\n    compiled_result = compile_func(self, token)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/defaulttags.py", line 787, in do_for\n    nodelist_loop = parser.parse(('empty', 'endfor',))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 239, in parse\n    compiled_result = compile_func(self, token)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/defaulttags.py", line 922, in do_if\n    nodelist_true = parser.parse(('else', 'endif'))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 246, in parse\n    self.unclosed_block_tag(parse_until)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/debug.py", line 64, in unclosed_block_tag\n    raise self.source_error(source, msg)\n\nTemplateSyntaxError: Unclosed tag 'if'. Looking for one of: else, endif \n	reports/report_2a.html	http://127.0.0.1:8000/burials/?template=reports%2Freport_2a.html&country=1&region=2&city=16&burial_passportid=&burried_date_from=&burried_date_to=&burial_type=&military_conflict=&info=&state=&search=%	ilvar-ThinkPad-X200s	a8f831f5cdcdb1027347451ebc473ef3	2011-11-28 04:57:00.988749-05	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	4	example.com	8ab22ca386324401a246ef42757925f6
5	root	TemplateSyntaxError	40	Could not parse the remainder: '|'d.m.Y'' from 'b.date_memorial|'d.m.Y''	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 420, in burials\n    return render_to_response(template, context_instance = RequestContext(request, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/shortcuts/__init__.py", line 20, in render_to_response\n    return HttpResponse(loader.render_to_string(*args, **kwargs), **httpresponse_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 181, in render_to_string\n    t = get_template(template_name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 157, in get_template\n    template, origin = find_template(template_name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 134, in find_template\n    source, display_name = loader(name, dirs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 42, in __call__\n    return self.load_template(template_name, template_dirs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 48, in load_template\n    template = get_template_from_string(source, origin, template_name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 168, in get_template_from_string\n    return Template(source, origin, name)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 108, in __init__\n    self.nodelist = compile_string(template_string, origin)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 136, in compile_string\n    return parser.parse()\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 239, in parse\n    compiled_result = compile_func(self, token)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/defaulttags.py", line 787, in do_for\n    nodelist_loop = parser.parse(('empty', 'endfor',))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 220, in parse\n    filter_expression = self.compile_filter(token.contents)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 314, in compile_filter\n    return FilterExpression(token, self)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 502, in __init__\n    raise TemplateSyntaxError("Could not parse the remainder: '%s' from '%s'" % (token[upto:], token))\n\nTemplateSyntaxError: Could not parse the remainder: '|'d.m.Y'' from 'b.date_memorial|'d.m.Y''\n	reports/report_2a.html	http://127.0.0.1:8000/burials/?template=reports%2Freport_2a.html&country=1&region=2&city=16&burial_passportid=&burried_date_from=&burried_date_to=&burial_type=&military_conflict=&info=&state=&search=%	ilvar-ThinkPad-X200s	a8f831f5cdcdb1027347451ebc473ef3	2011-11-28 05:01:10.45192-05	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	4	example.com	52c70e6bc3e44cd68a11096c5a5e72d1
6	root	TemplateSyntaxError	40	Caught TypeError while rendering: 'Page' object is not iterable	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/common/views.py", line 449, in burials\n    return render_to_response(template, context_instance = RequestContext(request, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/shortcuts/__init__.py", line 20, in render_to_response\n    return HttpResponse(loader.render_to_string(*args, **kwargs), **httpresponse_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/loader.py", line 188, in render_to_string\n    return t.render(context_instance)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 123, in render\n    return self._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/lib/python2.7/site-packages/django/template/defaulttags.py", line 190, in render\n    values = list(values)\n\nTemplateSyntaxError: Caught TypeError while rendering: 'Page' object is not iterable\n	reports/report_2b.html	http://127.0.0.1:8000/burials/?template=reports%2Freport_2b.html&country=1&region=6&city=64&burial_passportid=&burried_date_from=&burried_date_to=&burial_type=&military_conflict=&info=&state=&search=%	ilvar-ThinkPad-X200s	a8f831f5cdcdb1027347451ebc473ef3	2011-11-28 05:23:11.954802-05	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	5	example.com	c6916da8e7984401a3f42244c55c64a5
7	root	TemplateSyntaxError	40	Caught AttributeError while rendering: type object 'CheckboxInput' has no attribute 'attrs'	Traceback (most recent call last):\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/core/handlers/base.py", line 111, in get_response\n    response = callback(request, *callback_args, **callback_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/options.py", line 307, in wrapper\n    return self.admin_site.admin_view(view)(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/utils/decorators.py", line 93, in _wrapped_view\n    response = view_func(request, *args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/views/decorators/cache.py", line 79, in _wrapped_view_func\n    response = view_func(request, *args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/sites.py", line 197, in inner\n    return view(request, *args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/utils/decorators.py", line 28, in _wrapper\n    return bound_func(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/utils/decorators.py", line 93, in _wrapped_view\n    response = view_func(request, *args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/utils/decorators.py", line 24, in bound_func\n    return func(self, *args2, **kwargs2)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/db/transaction.py", line 217, in inner\n    res = func(*args, **kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/options.py", line 938, in add_view\n    return self.render_change_form(request, context, form_url=form_url, add=True)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/options.py", line 708, in render_change_form\n    ], context, context_instance=context_instance)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/shortcuts/__init__.py", line 20, in render_to_response\n    return HttpResponse(loader.render_to_string(*args, **kwargs), **httpresponse_kwargs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader.py", line 188, in render_to_string\n    return t.render(context_instance)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 123, in render\n    return self._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 127, in render\n    return compiled_parent._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 127, in render\n    return compiled_parent._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 127, in render\n    return compiled_parent._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 64, in render\n    result = block.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/defaulttags.py", line 227, in render\n    nodelist.append(node.render(context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 159, in render\n    return self.render_template(self.template, context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/loader_tags.py", line 141, in render_template\n    output = template.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 123, in render\n    return self._render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 117, in _render\n    return self.nodelist.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/defaulttags.py", line 227, in render\n    nodelist.append(node.render(context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/defaulttags.py", line 227, in render\n    nodelist.append(node.render(context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/defaulttags.py", line 313, in render\n    return self.nodelist_false.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 744, in render\n    bits.append(self.render_node(node, context))\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 73, in render_node\n    result = node.render(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/debug.py", line 90, in render\n    output = self.filter_expression.resolve(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 510, in resolve\n    obj = self.var.resolve(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 653, in resolve\n    value = self._resolve_lookup(context)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/template/base.py", line 698, in _resolve_lookup\n    current = current()\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/contrib/admin/helpers.py", line 128, in label_tag\n    return self.field.label_tag(contents=contents, attrs=attrs)\n\n  File "/home/ilvar/job/cemetery_mil/.env/local/lib/python2.7/site-packages/django/forms/forms.py", line 489, in label_tag\n    id_ = widget.attrs.get('id') or self.auto_id\n\nTemplateSyntaxError: Caught AttributeError while rendering: type object 'CheckboxInput' has no attribute 'attrs'\n	admin/includes/fieldset.html	http://127.0.0.1:8000/admin/common/person/add/	ilvar-ThinkPad-X200s	a8f831f5cdcdb1027347451ebc473ef3	2011-11-28 22:12:18.91199-05	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	6	example.com	6566b7f893b14d5d8884f50405451227
\.


--
-- Data for Name: sentry_messagecountbyminute; Type: TABLE DATA; Schema: public; Owner: ilvar
--

COPY sentry_messagecountbyminute (id, group_id, date, times_seen) FROM stdin;
1	1	2011-11-14 01:15:00-05	1
2	2	2011-11-28 04:45:00-05	1
3	3	2011-11-28 04:45:00-05	1
4	4	2011-11-28 04:45:00-05	1
5	4	2011-11-28 05:00:00-05	1
6	5	2011-11-28 05:15:00-05	1
7	6	2011-11-28 22:00:00-05	1
\.


--
-- Data for Name: sentry_messagefiltervalue; Type: TABLE DATA; Schema: public; Owner: ilvar
--

COPY sentry_messagefiltervalue (id, group_id, times_seen, key, value) FROM stdin;
1	1	1	server_name	ilvar-ThinkPad-X200s
2	1	1	site	example.com
3	1	1	logger	root
4	2	1	server_name	ilvar-ThinkPad-X200s
5	2	1	site	example.com
6	2	1	logger	root
7	3	1	server_name	ilvar-ThinkPad-X200s
8	3	1	site	example.com
9	3	1	logger	root
10	4	2	server_name	ilvar-ThinkPad-X200s
11	4	2	site	example.com
12	4	2	logger	root
13	5	1	server_name	ilvar-ThinkPad-X200s
14	5	1	site	example.com
15	5	1	logger	root
16	6	1	server_name	ilvar-ThinkPad-X200s
17	6	1	site	example.com
18	6	1	logger	root
\.


--
-- Data for Name: sentry_messageindex; Type: TABLE DATA; Schema: public; Owner: ilvar
--

COPY sentry_messageindex (id, object_id, "column", value) FROM stdin;
\.


--
-- Data for Name: south_migrationhistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY south_migrationhistory (id, app_name, migration, applied) FROM stdin;
1	common	0001_initial	2011-06-26 00:10:16.72348-05
2	common	0002_auto__add_field_person_oblocationid__add_field_burial_oblocationid	2011-07-02 04:52:23.874402-05
3	easy_thumbnails	0001_initial	2011-07-02 04:52:24.106134-05
4	easy_thumbnails	0002_filename_indexes	2011-07-02 04:52:24.118753-05
5	easy_thumbnails	0003_auto__add_storagenew	2011-07-02 04:52:24.147514-05
6	easy_thumbnails	0004_auto__add_field_source_storage_new__add_field_thumbnail_storage_new	2011-07-02 04:52:24.188616-05
7	easy_thumbnails	0005_storage_fks_null	2011-07-02 04:52:24.290183-05
8	easy_thumbnails	0006_copy_storage	2011-07-02 04:52:24.297426-05
9	easy_thumbnails	0007_storagenew_fks_not_null	2011-07-02 04:52:24.352-05
10	easy_thumbnails	0008_auto__del_field_source_storage__del_field_thumbnail_storage	2011-07-02 04:52:24.360408-05
11	easy_thumbnails	0009_auto__del_storage	2011-07-02 04:52:24.367385-05
12	easy_thumbnails	0010_rename_storage	2011-07-02 04:52:24.375338-05
13	easy_thumbnails	0011_auto__add_field_source_storage_hash__add_field_thumbnail_storage_hash	2011-07-02 04:52:24.416451-05
14	easy_thumbnails	0012_build_storage_hashes	2011-07-02 04:52:24.422907-05
15	easy_thumbnails	0013_auto__del_storage__del_field_source_storage__del_field_thumbnail_stora	2011-07-02 04:52:24.43492-05
16	common	0003_auto__del_field_personduty_person_ptr__add_field_personduty_person	2011-07-02 07:49:50.360519-05
17	common	0004_auto__del_field_person_additional_info__add_field_person_info	2011-07-02 08:40:35.49628-05
18	common	0005_auto__del_field_personcall_person_ptr__add_field_personcall_person	2011-07-03 06:16:21.290694-05
19	common	0006_auto__chg_field_burial_qunknown	2011-07-09 02:31:18.809467-05
20	common	0007_auto__del_field_militaryconflict_military_conflict_type__add_field_mil	2011-07-09 04:49:56.486745-05
21	common	0008_auto__del_field_personburial_date_exhumated__del_field_locationburial_	2011-07-14 22:45:34.977127-05
22	common	0009_auto__del_field_closedburial_burial__add_field_closedburial_burial_to_	2011-07-15 03:07:19.705836-05
23	common	0010_auto__add_field_burialeditcause_date_edit__add_field_burialeditcause_u	2011-07-15 08:29:28.436048-05
24	common	0011_auto__del_personburial__del_unique_personburial_person_burial__del_fie	2011-07-15 22:42:04.763312-05
25	common	0012_auto__add_memorialstate__add_field_burial_state_memorial	2011-07-16 22:05:51.255801-05
26	common	0013_auto__del_field_burial_state_memorial__add_field_burial_state	2011-07-16 22:12:12.143636-05
27	common	0014_unclear_dates	2011-10-10 06:04:29.939655-05
28	sentry	0001_initial	2011-10-11 09:51:03.507855-05
29	sentry	0002_auto__del_field_groupedmessage_url__chg_field_groupedmessage_view__chg	2011-10-11 09:51:05.002696-05
30	sentry	0003_auto__add_field_message_group__del_field_groupedmessage_server_name	2011-10-11 09:51:05.708713-05
31	sentry	0004_auto__add_filtervalue__add_unique_filtervalue_key_value	2011-10-11 09:51:05.848971-05
32	sentry	0005_auto	2011-10-11 09:51:05.937049-05
33	sentry	0006_auto	2011-10-11 09:51:05.960837-05
34	sentry	0007_auto__add_field_message_site	2011-10-11 09:51:06.77637-05
35	sentry	0008_auto__chg_field_message_view__add_field_groupedmessage_data__chg_field	2011-10-11 09:51:08.960553-05
36	sentry	0009_auto__add_field_message_message_id	2011-10-11 09:51:09.803426-05
37	sentry	0010_auto__add_messageindex__add_unique_messageindex_column_value_object_id	2011-10-11 09:51:09.977121-05
38	sentry	0011_auto__add_field_groupedmessage_score	2011-10-11 09:51:11.275707-05
39	sentry	0012_auto	2011-10-11 09:51:11.367432-05
40	sentry	0013_auto__add_messagecountbyminute__add_unique_messagecountbyminute_group_	2011-10-11 09:51:11.669349-05
41	sentry	0014_auto	2011-10-11 09:51:11.702412-05
42	common	0015_indexes	2011-10-11 10:17:31.735479-05
43	common	0016_mia	2011-10-14 11:42:54.187383-05
44	common	0017_unknown_cats	2011-10-16 08:42:04.381127-05
45	common	0018_closed_burials	2011-10-16 09:09:48.821886-05
46	common	0019_closed_burials_docs	2011-10-16 09:31:30.094451-05
47	common	0020_known_counts	2011-10-28 08:08:00.664751-05
48	common	0021_unknown_count	2011-10-28 08:09:25.64528-05
49	common	0022_known_counts2	2011-10-28 08:47:25.152523-05
50	common	0023_cause_docs	2011-10-28 08:47:25.519922-05
51	common	0024_autocomplete_speedup	2011-10-28 09:39:19.046422-05
52	common	0025_burial_update	2011-11-12 15:27:28.985162-05
53	common	0026_voenkomat	2011-11-12 16:11:12.904294-05
54	common	0027_gosznak_unclear	2011-11-13 14:16:23.980336-05
55	common	0028_bur_names	2011-11-27 18:45:04.082594-05
56	common	0029_deadman_cat_ordering	2011-11-27 18:50:27.292263-05
57	common	0030_deadman_outside_rb	2011-11-27 19:03:10.542216-05
58	common	0031_unclear_dates	2011-11-28 11:01:56.652905-05
\.


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_message
    ADD CONSTRAINT auth_message_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: common_burial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_burial
    ADD CONSTRAINT common_burial_pkey PRIMARY KEY (uuid);


--
-- Name: common_burialcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY common_burialcategory
    ADD CONSTRAINT common_burialcategory_pkey PRIMARY KEY (id);


--
-- Name: common_burialeditcause_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_burialeditcause
    ADD CONSTRAINT common_burialeditcause_pkey PRIMARY KEY (id);


--
-- Name: common_burialinformationlinks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_burialinformationlinks
    ADD CONSTRAINT common_burialinformationlinks_pkey PRIMARY KEY (id);


--
-- Name: common_burialpictures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_burialpictures
    ADD CONSTRAINT common_burialpictures_pkey PRIMARY KEY (id);


--
-- Name: common_burialtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_burialtype
    ADD CONSTRAINT common_burialtype_pkey PRIMARY KEY (id);


--
-- Name: common_closedburial_burial_from_id_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_closedburial
    ADD CONSTRAINT common_closedburial_burial_from_id_uniq UNIQUE (burial_from_id);


--
-- Name: common_closurecause_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_closurecause
    ADD CONSTRAINT common_closurecause_pkey PRIMARY KEY (id);


--
-- Name: common_comissariat_pkey; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY common_comissariat
    ADD CONSTRAINT common_comissariat_pkey PRIMARY KEY (id);


--
-- Name: common_deadmancategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_deadmancategory
    ADD CONSTRAINT common_deadmancategory_pkey PRIMARY KEY (id);


--
-- Name: common_deathcause_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_deathcause
    ADD CONSTRAINT common_deathcause_pkey PRIMARY KEY (id);


--
-- Name: common_documentsplace_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_documentsplace
    ADD CONSTRAINT common_documentsplace_pkey PRIMARY KEY (id);


--
-- Name: common_geocity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geocity
    ADD CONSTRAINT common_geocity_pkey PRIMARY KEY (id);


--
-- Name: common_geocountry_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geocountry
    ADD CONSTRAINT common_geocountry_name_key UNIQUE (name);


--
-- Name: common_geocountry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geocountry
    ADD CONSTRAINT common_geocountry_pkey PRIMARY KEY (id);


--
-- Name: common_georegion_country_id_7237d30d99e9ea56_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_georegion
    ADD CONSTRAINT common_georegion_country_id_7237d30d99e9ea56_uniq UNIQUE (country_id, name);


--
-- Name: common_georegion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_georegion
    ADD CONSTRAINT common_georegion_pkey PRIMARY KEY (id);


--
-- Name: common_geostreet_city_id_e13b608157ddba3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geostreet
    ADD CONSTRAINT common_geostreet_city_id_e13b608157ddba3_uniq UNIQUE (city_id, name);


--
-- Name: common_geostreet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geostreet
    ADD CONSTRAINT common_geostreet_pkey PRIMARY KEY (id);


--
-- Name: common_informationsource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_informationsource
    ADD CONSTRAINT common_informationsource_pkey PRIMARY KEY (id);


--
-- Name: common_locationbirth_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_locationbirth
    ADD CONSTRAINT common_locationbirth_pkey PRIMARY KEY (person_id);


--
-- Name: common_locationburial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT common_locationburial_pkey PRIMARY KEY (burial_id);


--
-- Name: common_memorialstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_memorialstate
    ADD CONSTRAINT common_memorialstate_pkey PRIMARY KEY (id);


--
-- Name: common_militaryconflict_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_militaryconflict
    ADD CONSTRAINT common_militaryconflict_pkey PRIMARY KEY (id);


--
-- Name: common_militaryconflicttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_militaryconflicttype
    ADD CONSTRAINT common_militaryconflicttype_pkey PRIMARY KEY (id);


--
-- Name: common_militaryunit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_militaryunit
    ADD CONSTRAINT common_militaryunit_pkey PRIMARY KEY (id);


--
-- Name: common_nationality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_nationality
    ADD CONSTRAINT common_nationality_pkey PRIMARY KEY (id);


--
-- Name: common_person_closed_burials_person_id_7ab9f12f4f2d4c01_uniq; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY common_person_closed_burials
    ADD CONSTRAINT common_person_closed_burials_person_id_7ab9f12f4f2d4c01_uniq UNIQUE (person_id, burial_id);


--
-- Name: common_person_closed_burials_pkey; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY common_person_closed_burials
    ADD CONSTRAINT common_person_closed_burials_pkey PRIMARY KEY (id);


--
-- Name: common_person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT common_person_pkey PRIMARY KEY (uuid);


--
-- Name: common_personcall_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_personcall
    ADD CONSTRAINT common_personcall_pkey PRIMARY KEY (person_id);


--
-- Name: common_personduty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_personduty
    ADD CONSTRAINT common_personduty_pkey PRIMARY KEY (person_id);


--
-- Name: common_personeditcause_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_personeditcause
    ADD CONSTRAINT common_personeditcause_pkey PRIMARY KEY (id);


--
-- Name: common_personinformationlinks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_personinformationlinks
    ADD CONSTRAINT common_personinformationlinks_pkey PRIMARY KEY (id);


--
-- Name: common_post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_post
    ADD CONSTRAINT common_post_pkey PRIMARY KEY (id);


--
-- Name: common_rank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_rank
    ADD CONSTRAINT common_rank_pkey PRIMARY KEY (id);


--
-- Name: common_searchobject_burial_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_searchobject
    ADD CONSTRAINT common_searchobject_burial_id_key UNIQUE (burial_id);


--
-- Name: common_searchobject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_searchobject
    ADD CONSTRAINT common_searchobject_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_model_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_source_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_pkey PRIMARY KEY (id);


--
-- Name: sentry_filtervalue_key_490960fe2e7ed19d_uniq; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_filtervalue
    ADD CONSTRAINT sentry_filtervalue_key_490960fe2e7ed19d_uniq UNIQUE (key, value);


--
-- Name: sentry_filtervalue_pkey; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_filtervalue
    ADD CONSTRAINT sentry_filtervalue_pkey PRIMARY KEY (id);


--
-- Name: sentry_groupedmessage_logger_6620e83ff8553a25_uniq; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_groupedmessage
    ADD CONSTRAINT sentry_groupedmessage_logger_6620e83ff8553a25_uniq UNIQUE (logger, view, checksum);


--
-- Name: sentry_groupedmessage_pkey; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_groupedmessage
    ADD CONSTRAINT sentry_groupedmessage_pkey PRIMARY KEY (id);


--
-- Name: sentry_message_message_id_key; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_message
    ADD CONSTRAINT sentry_message_message_id_key UNIQUE (message_id);


--
-- Name: sentry_message_pkey; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_message
    ADD CONSTRAINT sentry_message_pkey PRIMARY KEY (id);


--
-- Name: sentry_messagecountbyminute_group_id_7559322cf7b76ad9_uniq; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_messagecountbyminute
    ADD CONSTRAINT sentry_messagecountbyminute_group_id_7559322cf7b76ad9_uniq UNIQUE (group_id, date);


--
-- Name: sentry_messagecountbyminute_pkey; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_messagecountbyminute
    ADD CONSTRAINT sentry_messagecountbyminute_pkey PRIMARY KEY (id);


--
-- Name: sentry_messagefiltervalue_key_a4e294791734e9_uniq; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_messagefiltervalue
    ADD CONSTRAINT sentry_messagefiltervalue_key_a4e294791734e9_uniq UNIQUE (key, value, group_id);


--
-- Name: sentry_messagefiltervalue_pkey; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_messagefiltervalue
    ADD CONSTRAINT sentry_messagefiltervalue_pkey PRIMARY KEY (id);


--
-- Name: sentry_messageindex_column_23431fca14e385c1_uniq; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_messageindex
    ADD CONSTRAINT sentry_messageindex_column_23431fca14e385c1_uniq UNIQUE ("column", value, object_id);


--
-- Name: sentry_messageindex_pkey; Type: CONSTRAINT; Schema: public; Owner: ilvar; Tablespace: 
--

ALTER TABLE ONLY sentry_messageindex
    ADD CONSTRAINT sentry_messageindex_pkey PRIMARY KEY (id);


--
-- Name: south_migrationhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY south_migrationhistory
    ADD CONSTRAINT south_migrationhistory_pkey PRIMARY KEY (id);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_message_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_message_user_id ON auth_message USING btree (user_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: common_burial_burial_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_burial_type_id ON common_burial USING btree (burial_type_id);


--
-- Name: common_burial_creator_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_creator_id ON common_burial USING btree (creator_id);


--
-- Name: common_burial_military_conflict_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_military_conflict_id ON common_burial USING btree (military_conflict_id);


--
-- Name: common_burial_state_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_state_id ON common_burial USING btree (state_id);


--
-- Name: common_burialcategory_burial_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_burialcategory_burial_id ON common_burialcategory USING btree (burial_id);


--
-- Name: common_burialcategory_burial_id_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_burialcategory_burial_id_like ON common_burialcategory USING btree (burial_id varchar_pattern_ops);


--
-- Name: common_burialcategory_category_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_burialcategory_category_id ON common_burialcategory USING btree (category_id);


--
-- Name: common_burialeditcause_burial_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burialeditcause_burial_id ON common_burialeditcause USING btree (burial_id);


--
-- Name: common_burialeditcause_burial_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burialeditcause_burial_id_like ON common_burialeditcause USING btree (burial_id varchar_pattern_ops);


--
-- Name: common_burialeditcause_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burialeditcause_user_id ON common_burialeditcause USING btree (user_id);


--
-- Name: common_burialinformationlinks_burial_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burialinformationlinks_burial_id ON common_burialinformationlinks USING btree (burial_id);


--
-- Name: common_burialinformationlinks_burial_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burialinformationlinks_burial_id_like ON common_burialinformationlinks USING btree (burial_id varchar_pattern_ops);


--
-- Name: common_burialpictures_burial_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burialpictures_burial_id ON common_burialpictures USING btree (burial_id);


--
-- Name: common_burialpictures_burial_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burialpictures_burial_id_like ON common_burialpictures USING btree (burial_id varchar_pattern_ops);


--
-- Name: common_closedburial_burial_from_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_closedburial_burial_from_id ON common_closedburial USING btree (burial_from_id);


--
-- Name: common_closedburial_burial_from_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_closedburial_burial_from_id_like ON common_closedburial USING btree (burial_from_id varchar_pattern_ops);


--
-- Name: common_closedburial_burial_to_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_closedburial_burial_to_id ON common_closedburial USING btree (burial_to_id);


--
-- Name: common_closedburial_burial_to_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_closedburial_burial_to_id_like ON common_closedburial USING btree (burial_to_id varchar_pattern_ops);


--
-- Name: common_closedburial_cause_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_closedburial_cause_id ON common_closedburial USING btree (cause_id);


--
-- Name: common_comissariat_city_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_comissariat_city_id ON common_comissariat USING btree (city_id);


--
-- Name: common_comissariat_country_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_comissariat_country_id ON common_comissariat USING btree (country_id);


--
-- Name: common_comissariat_region_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_comissariat_region_id ON common_comissariat USING btree (region_id);


--
-- Name: common_geocity_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_geocity_name ON common_geocity USING btree (name);


--
-- Name: common_geocity_name_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_geocity_name_like ON common_geocity USING btree (name varchar_pattern_ops);


--
-- Name: common_geocity_region_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_geocity_region_id ON common_geocity USING btree (region_id);


--
-- Name: common_georegion_country_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_georegion_country_id ON common_georegion USING btree (country_id);


--
-- Name: common_georegion_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_georegion_name ON common_georegion USING btree (name);


--
-- Name: common_georegion_name_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_georegion_name_like ON common_georegion USING btree (name varchar_pattern_ops);


--
-- Name: common_geostreet_city_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_geostreet_city_id ON common_geostreet USING btree (city_id);


--
-- Name: common_geostreet_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_geostreet_name ON common_geostreet USING btree (name);


--
-- Name: common_geostreet_name_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_geostreet_name_like ON common_geostreet USING btree (name varchar_pattern_ops);


--
-- Name: common_locationbirth_city_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationbirth_city_id ON common_locationbirth USING btree (city_id);


--
-- Name: common_locationbirth_country_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationbirth_country_id ON common_locationbirth USING btree (country_id);


--
-- Name: common_locationbirth_region_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationbirth_region_id ON common_locationbirth USING btree (region_id);


--
-- Name: common_locationburial_city_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_city_id ON common_locationburial USING btree (city_id);


--
-- Name: common_locationburial_country_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_country_id ON common_locationburial USING btree (country_id);


--
-- Name: common_locationburial_region_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_region_id ON common_locationburial USING btree (region_id);


--
-- Name: common_militaryconflict_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_militaryconflict_type_id ON common_militaryconflict USING btree (type_id);


--
-- Name: common_militaryunit_city_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_militaryunit_city_id ON common_militaryunit USING btree (city_id);


--
-- Name: common_militaryunit_country_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_militaryunit_country_id ON common_militaryunit USING btree (country_id);


--
-- Name: common_militaryunit_region_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_militaryunit_region_id ON common_militaryunit USING btree (region_id);


--
-- Name: common_person_birth_date; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_birth_date ON common_person USING btree (birth_date);


--
-- Name: common_person_burial_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_burial_id ON common_person USING btree (burial_id);


--
-- Name: common_person_burial_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_burial_id_like ON common_person USING btree (burial_id varchar_pattern_ops);


--
-- Name: common_person_closed_burials_burial_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_person_closed_burials_burial_id ON common_person_closed_burials USING btree (burial_id);


--
-- Name: common_person_closed_burials_burial_id_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_person_closed_burials_burial_id_like ON common_person_closed_burials USING btree (burial_id varchar_pattern_ops);


--
-- Name: common_person_closed_burials_person_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_person_closed_burials_person_id ON common_person_closed_burials USING btree (person_id);


--
-- Name: common_person_closed_burials_person_id_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX common_person_closed_burials_person_id_like ON common_person_closed_burials USING btree (person_id varchar_pattern_ops);


--
-- Name: common_person_creator_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_creator_id ON common_person USING btree (creator_id);


--
-- Name: common_person_deadman_category_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_deadman_category_id ON common_person USING btree (deadman_category_id);


--
-- Name: common_person_death_cause_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_death_cause_id ON common_person USING btree (death_cause_id);


--
-- Name: common_person_death_date; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_death_date ON common_person USING btree (death_date);


--
-- Name: common_person_documents_place_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_documents_place_id ON common_person USING btree (documents_place_id);


--
-- Name: common_person_first_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_first_name ON common_person USING btree (first_name);


--
-- Name: common_person_information_source_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_information_source_id ON common_person USING btree (information_source_id);


--
-- Name: common_person_last_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_last_name ON common_person USING btree (last_name);


--
-- Name: common_person_nationality_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_nationality_id ON common_person USING btree (nationality_id);


--
-- Name: common_person_patronymic; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_patronymic ON common_person USING btree (patronymic);


--
-- Name: common_personcall_unit_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personcall_unit_id ON common_personcall USING btree (unit_id);


--
-- Name: common_personduty_post_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personduty_post_id ON common_personduty USING btree (post_id);


--
-- Name: common_personduty_rank_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personduty_rank_id ON common_personduty USING btree (rank_id);


--
-- Name: common_personduty_unit_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personduty_unit_id ON common_personduty USING btree (unit_id);


--
-- Name: common_personeditcause_person_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personeditcause_person_id ON common_personeditcause USING btree (person_id);


--
-- Name: common_personeditcause_person_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personeditcause_person_id_like ON common_personeditcause USING btree (person_id varchar_pattern_ops);


--
-- Name: common_personinformationlinks_person_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personinformationlinks_person_id ON common_personinformationlinks USING btree (person_id);


--
-- Name: common_personinformationlinks_person_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personinformationlinks_person_id_like ON common_personinformationlinks USING btree (person_id varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_session_expire_date ON django_session USING btree (expire_date);


--
-- Name: easy_thumbnails_source_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX easy_thumbnails_source_name ON easy_thumbnails_source USING btree (name);


--
-- Name: easy_thumbnails_source_storage_hash; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX easy_thumbnails_source_storage_hash ON easy_thumbnails_source USING btree (storage_hash);


--
-- Name: easy_thumbnails_thumbnail_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX easy_thumbnails_thumbnail_name ON easy_thumbnails_thumbnail USING btree (name);


--
-- Name: easy_thumbnails_thumbnail_source_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX easy_thumbnails_thumbnail_source_id ON easy_thumbnails_thumbnail USING btree (source_id);


--
-- Name: easy_thumbnails_thumbnail_storage_hash; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX easy_thumbnails_thumbnail_storage_hash ON easy_thumbnails_thumbnail USING btree (storage_hash);


--
-- Name: lower_last_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lower_last_name ON common_person USING btree (lower((last_name)::text));


--
-- Name: sentry_groupedmessage_checksum; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_checksum ON sentry_groupedmessage USING btree (checksum);


--
-- Name: sentry_groupedmessage_checksum_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_checksum_like ON sentry_groupedmessage USING btree (checksum varchar_pattern_ops);


--
-- Name: sentry_groupedmessage_class_name; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_class_name ON sentry_groupedmessage USING btree (class_name);


--
-- Name: sentry_groupedmessage_class_name_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_class_name_like ON sentry_groupedmessage USING btree (class_name varchar_pattern_ops);


--
-- Name: sentry_groupedmessage_first_seen; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_first_seen ON sentry_groupedmessage USING btree (first_seen);


--
-- Name: sentry_groupedmessage_last_seen; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_last_seen ON sentry_groupedmessage USING btree (last_seen);


--
-- Name: sentry_groupedmessage_level; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_level ON sentry_groupedmessage USING btree (level);


--
-- Name: sentry_groupedmessage_logger; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_logger ON sentry_groupedmessage USING btree (logger);


--
-- Name: sentry_groupedmessage_logger_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_logger_like ON sentry_groupedmessage USING btree (logger varchar_pattern_ops);


--
-- Name: sentry_groupedmessage_status; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_status ON sentry_groupedmessage USING btree (status);


--
-- Name: sentry_groupedmessage_times_seen; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_times_seen ON sentry_groupedmessage USING btree (times_seen);


--
-- Name: sentry_groupedmessage_view; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_view ON sentry_groupedmessage USING btree (view);


--
-- Name: sentry_groupedmessage_view_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_groupedmessage_view_like ON sentry_groupedmessage USING btree (view varchar_pattern_ops);


--
-- Name: sentry_message_checksum; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_checksum ON sentry_message USING btree (checksum);


--
-- Name: sentry_message_checksum_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_checksum_like ON sentry_message USING btree (checksum varchar_pattern_ops);


--
-- Name: sentry_message_class_name; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_class_name ON sentry_message USING btree (class_name);


--
-- Name: sentry_message_class_name_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_class_name_like ON sentry_message USING btree (class_name varchar_pattern_ops);


--
-- Name: sentry_message_datetime; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_datetime ON sentry_message USING btree (datetime);


--
-- Name: sentry_message_group_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_group_id ON sentry_message USING btree (group_id);


--
-- Name: sentry_message_level; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_level ON sentry_message USING btree (level);


--
-- Name: sentry_message_logger; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_logger ON sentry_message USING btree (logger);


--
-- Name: sentry_message_logger_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_logger_like ON sentry_message USING btree (logger varchar_pattern_ops);


--
-- Name: sentry_message_server_name; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_server_name ON sentry_message USING btree (server_name);


--
-- Name: sentry_message_server_name_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_server_name_like ON sentry_message USING btree (server_name varchar_pattern_ops);


--
-- Name: sentry_message_site; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_site ON sentry_message USING btree (site);


--
-- Name: sentry_message_site_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_site_like ON sentry_message USING btree (site varchar_pattern_ops);


--
-- Name: sentry_message_view; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_view ON sentry_message USING btree (view);


--
-- Name: sentry_message_view_like; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_message_view_like ON sentry_message USING btree (view varchar_pattern_ops);


--
-- Name: sentry_messagecountbyminute_group_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_messagecountbyminute_group_id ON sentry_messagecountbyminute USING btree (group_id);


--
-- Name: sentry_messagefiltervalue_group_id; Type: INDEX; Schema: public; Owner: ilvar; Tablespace: 
--

CREATE INDEX sentry_messagefiltervalue_group_id ON sentry_messagefiltervalue USING btree (group_id);


--
-- Name: upper_last_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX upper_last_name ON common_person USING btree (upper((last_name)::text));


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_message_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_message
    ADD CONSTRAINT auth_message_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_from_id_refs_uuid_7108e847fa3e5461; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_closedburial
    ADD CONSTRAINT burial_from_id_refs_uuid_7108e847fa3e5461 FOREIGN KEY (burial_from_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_id_refs_uuid_1e419729376c500c; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY common_person_closed_burials
    ADD CONSTRAINT burial_id_refs_uuid_1e419729376c500c FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_id_refs_uuid_2d4dab379af4ecf5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT burial_id_refs_uuid_2d4dab379af4ecf5 FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_id_refs_uuid_33642242275a9aaa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burialinformationlinks
    ADD CONSTRAINT burial_id_refs_uuid_33642242275a9aaa FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_id_refs_uuid_33a39005e5a8a22e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT burial_id_refs_uuid_33a39005e5a8a22e FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_id_refs_uuid_4994fb68c4fda36b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burialeditcause
    ADD CONSTRAINT burial_id_refs_uuid_4994fb68c4fda36b FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_id_refs_uuid_4aba4ca177110cbb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_searchobject
    ADD CONSTRAINT burial_id_refs_uuid_4aba4ca177110cbb FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_id_refs_uuid_7106e92977f33957; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY common_burialcategory
    ADD CONSTRAINT burial_id_refs_uuid_7106e92977f33957 FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_id_refs_uuid_7ba1cce4d78e5cf2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burialpictures
    ADD CONSTRAINT burial_id_refs_uuid_7ba1cce4d78e5cf2 FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_to_id_refs_uuid_7108e847fa3e5461; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_closedburial
    ADD CONSTRAINT burial_to_id_refs_uuid_7108e847fa3e5461 FOREIGN KEY (burial_to_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: burial_type_id_refs_id_1c18c4b520c290a9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burial
    ADD CONSTRAINT burial_type_id_refs_id_1c18c4b520c290a9 FOREIGN KEY (burial_type_id) REFERENCES common_burialtype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: category_id_refs_id_19a4b91af98244d7; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY common_burialcategory
    ADD CONSTRAINT category_id_refs_id_19a4b91af98244d7 FOREIGN KEY (category_id) REFERENCES common_deadmancategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cause_id_refs_id_537e7dabfa85476; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_closedburial
    ADD CONSTRAINT cause_id_refs_id_537e7dabfa85476 FOREIGN KEY (cause_id) REFERENCES common_closurecause(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: city_id_refs_id_2499f06a14797eb6; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY common_comissariat
    ADD CONSTRAINT city_id_refs_id_2499f06a14797eb6 FOREIGN KEY (city_id) REFERENCES common_geocity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: city_id_refs_id_249b71d6ffa0e327; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationbirth
    ADD CONSTRAINT city_id_refs_id_249b71d6ffa0e327 FOREIGN KEY (city_id) REFERENCES common_geocity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: city_id_refs_id_4652deaeb3a08a9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_geostreet
    ADD CONSTRAINT city_id_refs_id_4652deaeb3a08a9 FOREIGN KEY (city_id) REFERENCES common_geocity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: city_id_refs_id_6ccf266a4c037c80; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT city_id_refs_id_6ccf266a4c037c80 FOREIGN KEY (city_id) REFERENCES common_geocity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: city_id_refs_id_7de58732b93c08c7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_militaryunit
    ADD CONSTRAINT city_id_refs_id_7de58732b93c08c7 FOREIGN KEY (city_id) REFERENCES common_geocity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_728de91f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_728de91f FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: country_id_refs_id_46d15c0ff2087696; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT country_id_refs_id_46d15c0ff2087696 FOREIGN KEY (country_id) REFERENCES common_geocountry(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: country_id_refs_id_6018cb0d5f0588d1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_militaryunit
    ADD CONSTRAINT country_id_refs_id_6018cb0d5f0588d1 FOREIGN KEY (country_id) REFERENCES common_geocountry(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: country_id_refs_id_65e351fee835818f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationbirth
    ADD CONSTRAINT country_id_refs_id_65e351fee835818f FOREIGN KEY (country_id) REFERENCES common_geocountry(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: country_id_refs_id_7741abde3c45924c; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY common_comissariat
    ADD CONSTRAINT country_id_refs_id_7741abde3c45924c FOREIGN KEY (country_id) REFERENCES common_geocountry(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: country_id_refs_id_f912bb0f7b8296a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_georegion
    ADD CONSTRAINT country_id_refs_id_f912bb0f7b8296a FOREIGN KEY (country_id) REFERENCES common_geocountry(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: creator_id_refs_id_11bd316723074570; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT creator_id_refs_id_11bd316723074570 FOREIGN KEY (creator_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: creator_id_refs_id_460d36bda3fd3488; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burial
    ADD CONSTRAINT creator_id_refs_id_460d36bda3fd3488 FOREIGN KEY (creator_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: deadman_category_id_refs_id_9b8770a80cb6153; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT deadman_category_id_refs_id_9b8770a80cb6153 FOREIGN KEY (deadman_category_id) REFERENCES common_deadmancategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: death_cause_id_refs_id_3e8b91bc6778eecd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT death_cause_id_refs_id_3e8b91bc6778eecd FOREIGN KEY (death_cause_id) REFERENCES common_deathcause(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_place_id_refs_id_e9e8b1f60ddb2a5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT documents_place_id_refs_id_e9e8b1f60ddb2a5 FOREIGN KEY (documents_place_id) REFERENCES common_documentsplace(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_2955655b757f499a; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY sentry_message
    ADD CONSTRAINT group_id_refs_id_2955655b757f499a FOREIGN KEY (group_id) REFERENCES sentry_groupedmessage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_329e3bb8b3571656; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY sentry_messagefiltervalue
    ADD CONSTRAINT group_id_refs_id_329e3bb8b3571656 FOREIGN KEY (group_id) REFERENCES sentry_groupedmessage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_3cea63fe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_3cea63fe FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_538495fb557ae099; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY sentry_messagecountbyminute
    ADD CONSTRAINT group_id_refs_id_538495fb557ae099 FOREIGN KEY (group_id) REFERENCES sentry_groupedmessage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: information_source_id_refs_id_1468f1be4948576e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT information_source_id_refs_id_1468f1be4948576e FOREIGN KEY (information_source_id) REFERENCES common_informationsource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: military_conflict_id_refs_id_124448c7860964a1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burial
    ADD CONSTRAINT military_conflict_id_refs_id_124448c7860964a1 FOREIGN KEY (military_conflict_id) REFERENCES common_militaryconflict(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nationality_id_refs_id_61754d8a0ff64bfb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT nationality_id_refs_id_61754d8a0ff64bfb FOREIGN KEY (nationality_id) REFERENCES common_nationality(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: person_id_refs_uuid_1e9e93d473e5fb29; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personcall
    ADD CONSTRAINT person_id_refs_uuid_1e9e93d473e5fb29 FOREIGN KEY (person_id) REFERENCES common_person(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: person_id_refs_uuid_2657d592cb9dba3b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personeditcause
    ADD CONSTRAINT person_id_refs_uuid_2657d592cb9dba3b FOREIGN KEY (person_id) REFERENCES common_person(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: person_id_refs_uuid_44ca4bb9ffa5160b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personduty
    ADD CONSTRAINT person_id_refs_uuid_44ca4bb9ffa5160b FOREIGN KEY (person_id) REFERENCES common_person(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: person_id_refs_uuid_5020dd7a547b052c; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY common_person_closed_burials
    ADD CONSTRAINT person_id_refs_uuid_5020dd7a547b052c FOREIGN KEY (person_id) REFERENCES common_person(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: person_id_refs_uuid_9a031f0eee64e6a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personinformationlinks
    ADD CONSTRAINT person_id_refs_uuid_9a031f0eee64e6a FOREIGN KEY (person_id) REFERENCES common_person(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: person_id_refs_uuid_c9c4ab6880b22bf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationbirth
    ADD CONSTRAINT person_id_refs_uuid_c9c4ab6880b22bf FOREIGN KEY (person_id) REFERENCES common_person(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: post_id_refs_id_66e52ad0a718ed92; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personduty
    ADD CONSTRAINT post_id_refs_id_66e52ad0a718ed92 FOREIGN KEY (post_id) REFERENCES common_post(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: rank_id_refs_id_5a4044cfad2532f2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personduty
    ADD CONSTRAINT rank_id_refs_id_5a4044cfad2532f2 FOREIGN KEY (rank_id) REFERENCES common_rank(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: region_id_refs_id_4c007ae41c511a0f; Type: FK CONSTRAINT; Schema: public; Owner: ilvar
--

ALTER TABLE ONLY common_comissariat
    ADD CONSTRAINT region_id_refs_id_4c007ae41c511a0f FOREIGN KEY (region_id) REFERENCES common_georegion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: region_id_refs_id_55b5191c38b6a82e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationbirth
    ADD CONSTRAINT region_id_refs_id_55b5191c38b6a82e FOREIGN KEY (region_id) REFERENCES common_georegion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: region_id_refs_id_78433f69d2981613; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT region_id_refs_id_78433f69d2981613 FOREIGN KEY (region_id) REFERENCES common_georegion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: region_id_refs_id_7f950e556928b772; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_geocity
    ADD CONSTRAINT region_id_refs_id_7f950e556928b772 FOREIGN KEY (region_id) REFERENCES common_georegion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: region_id_refs_id_d5f5170e1f52632; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_militaryunit
    ADD CONSTRAINT region_id_refs_id_d5f5170e1f52632 FOREIGN KEY (region_id) REFERENCES common_georegion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: source_id_refs_id_38c628a45bffe8f5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT source_id_refs_id_38c628a45bffe8f5 FOREIGN KEY (source_id) REFERENCES easy_thumbnails_source(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: state_id_refs_id_153ce3278a0946fe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burial
    ADD CONSTRAINT state_id_refs_id_153ce3278a0946fe FOREIGN KEY (state_id) REFERENCES common_memorialstate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: type_id_refs_id_50bb84f4910ee8f3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_militaryconflict
    ADD CONSTRAINT type_id_refs_id_50bb84f4910ee8f3 FOREIGN KEY (type_id) REFERENCES common_militaryconflicttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: unit_id_refs_id_1966ac72a35fc192; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personcall
    ADD CONSTRAINT unit_id_refs_id_1966ac72a35fc192 FOREIGN KEY (unit_id) REFERENCES common_comissariat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: unit_id_refs_id_39c25db4e9295c1b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personduty
    ADD CONSTRAINT unit_id_refs_id_39c25db4e9295c1b FOREIGN KEY (unit_id) REFERENCES common_militaryunit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_25bb2a769f823d10; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burialeditcause
    ADD CONSTRAINT user_id_refs_id_25bb2a769f823d10 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_831107f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_831107f1 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_f2045483; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_f2045483 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

