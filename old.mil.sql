--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

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

SELECT pg_catalog.setval('auth_permission_id_seq', 84, true);


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

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


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

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Name: common_burial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_burial (
    uuid character varying(36) NOT NULL,
    passportid character varying(128),
    date_passport date,
    date_burried date,
    date_discovered date,
    date_closed date,
    closure_cause_id character varying(36),
    burial_type_id character varying(36),
    military_conflict_id character varying(36),
    date_memorial date,
    date_gosznak date,
    foto character varying(100),
    creator_id integer,
    date_of_creation timestamp with time zone NOT NULL,
    date_last_edit timestamp with time zone NOT NULL,
    additional_info text,
    is_trash boolean NOT NULL
);


ALTER TABLE public.common_burial OWNER TO postgres;

--
-- Name: common_burialtype; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_burialtype (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_burialtype OWNER TO postgres;

--
-- Name: common_closurecause; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_closurecause (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_closurecause OWNER TO postgres;

--
-- Name: common_deadmancategory; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_deadmancategory (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_deadmancategory OWNER TO postgres;

--
-- Name: common_deathcause; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_deathcause (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_deathcause OWNER TO postgres;

--
-- Name: common_documentsplace; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_documentsplace (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_documentsplace OWNER TO postgres;

--
-- Name: common_duty; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_duty (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_duty OWNER TO postgres;

--
-- Name: common_geocity; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_geocity (
    uuid character varying(36) NOT NULL,
    region_id character varying(36) NOT NULL,
    name character varying(36) NOT NULL
);


ALTER TABLE public.common_geocity OWNER TO postgres;

--
-- Name: common_geocountry; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_geocountry (
    uuid character varying(36) NOT NULL,
    name character varying(24) NOT NULL
);


ALTER TABLE public.common_geocountry OWNER TO postgres;

--
-- Name: common_georegion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_georegion (
    uuid character varying(36) NOT NULL,
    country_id character varying(36) NOT NULL,
    name character varying(36) NOT NULL
);


ALTER TABLE public.common_georegion OWNER TO postgres;

--
-- Name: common_geostreet; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_geostreet (
    uuid character varying(36) NOT NULL,
    city_id character varying(36) NOT NULL,
    name character varying(99) NOT NULL
);


ALTER TABLE public.common_geostreet OWNER TO postgres;

--
-- Name: common_informationsource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_informationsource (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_informationsource OWNER TO postgres;

--
-- Name: common_locationbirth; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_locationbirth (
    country_id character varying(36),
    region_id character varying(36),
    city_id character varying(36),
    gps_x double precision,
    gps_y double precision,
    gps_z double precision,
    person_id character varying(36) NOT NULL
);


ALTER TABLE public.common_locationbirth OWNER TO postgres;

--
-- Name: common_locationburial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_locationburial (
    country_id character varying(36),
    region_id character varying(36),
    city_id character varying(36),
    gps_x double precision,
    gps_y double precision,
    gps_z double precision,
    burial_id character varying(36) NOT NULL,
    post_index character varying(16) NOT NULL,
    street_id character varying(36),
    house character varying(16) NOT NULL,
    block character varying(16) NOT NULL,
    building character varying(16) NOT NULL
);


ALTER TABLE public.common_locationburial OWNER TO postgres;

--
-- Name: common_locationduty; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_locationduty (
    country_id character varying(36),
    region_id character varying(36),
    city_id character varying(36),
    gps_x double precision,
    gps_y double precision,
    gps_z double precision,
    duty_id character varying(36) NOT NULL,
    post_index character varying(16) NOT NULL,
    street_id character varying(36),
    house character varying(16) NOT NULL,
    block character varying(16) NOT NULL,
    building character varying(16) NOT NULL
);


ALTER TABLE public.common_locationduty OWNER TO postgres;

--
-- Name: common_militaryconflict; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_militaryconflict (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL,
    military_conflict_category_id character varying(36)
);


ALTER TABLE public.common_militaryconflict OWNER TO postgres;

--
-- Name: common_militaryconflictcategory; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_militaryconflictcategory (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_militaryconflictcategory OWNER TO postgres;

--
-- Name: common_person; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_person (
    uuid character varying(36) NOT NULL,
    last_name character varying(128) NOT NULL,
    first_name character varying(30) NOT NULL,
    patronymic character varying(30) NOT NULL,
    birth_date date,
    death_date date,
    death_cause_id character varying(36),
    deadman_category_id character varying(36),
    documents_place_id character varying(36),
    information_source_id character varying(36),
    creator_id integer,
    date_of_creation timestamp with time zone NOT NULL,
    additional_info text,
    is_trash boolean NOT NULL
);


ALTER TABLE public.common_person OWNER TO postgres;

--
-- Name: common_personburial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_personburial (
    uuid character varying(36) NOT NULL,
    person_id character varying(36) NOT NULL,
    burial_id character varying(36) NOT NULL,
    date_burried date,
    date_exhumated date
);


ALTER TABLE public.common_personburial OWNER TO postgres;

--
-- Name: common_personduty; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_personduty (
    uuid character varying(36) NOT NULL,
    person_id character varying(36) NOT NULL,
    rank_id character varying(36) NOT NULL,
    duty_id character varying(36) NOT NULL,
    date_from date,
    date_to date
);


ALTER TABLE public.common_personduty OWNER TO postgres;

--
-- Name: common_rank; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE common_rank (
    uuid character varying(36) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.common_rank OWNER TO postgres;

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

SELECT pg_catalog.setval('django_admin_log_id_seq', 8, true);


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

SELECT pg_catalog.setval('django_content_type_id_seq', 28, true);


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
19	Can add страна	7	add_geocountry
20	Can change страна	7	change_geocountry
21	Can delete страна	7	delete_geocountry
22	Can add регион	8	add_georegion
23	Can change регион	8	change_georegion
24	Can delete регион	8	delete_georegion
25	Can add населенный пункт	9	add_geocity
26	Can change населенный пункт	9	change_geocity
27	Can delete населенный пункт	9	delete_geocity
28	Can add улица	10	add_geostreet
29	Can change улица	10	change_geostreet
30	Can delete улица	10	delete_geostreet
31	Can add воинское звание	11	add_rank
32	Can change воинское звание	11	change_rank
33	Can delete воинское звание	11	delete_rank
34	Can add Причина гибели	12	add_deathcause
35	Can change Причина гибели	12	change_deathcause
36	Can delete Причина гибели	12	delete_deathcause
37	Can add Категория погибшего	13	add_deadmancategory
38	Can change Категория погибшего	13	change_deadmancategory
39	Can delete Категория погибшего	13	delete_deadmancategory
40	Can add Место нахождения документов	14	add_documentsplace
41	Can change Место нахождения документов	14	change_documentsplace
42	Can delete Место нахождения документов	14	delete_documentsplace
43	Can add Тип воинского захоронения	15	add_burialtype
44	Can change Тип воинского захоронения	15	change_burialtype
45	Can delete Тип воинского захоронения	15	delete_burialtype
46	Can add Категория военного конфликта	16	add_militaryconflictcategory
47	Can change Категория военного конфликта	16	change_militaryconflictcategory
48	Can delete Категория военного конфликта	16	delete_militaryconflictcategory
49	Can add Военный конфликт	17	add_militaryconflict
50	Can change Военный конфликт	17	change_militaryconflict
51	Can delete Военный конфликт	17	delete_militaryconflict
52	Can add Источник информации	18	add_informationsource
53	Can change Источник информации	18	change_informationsource
54	Can delete Источник информации	18	delete_informationsource
55	Can add Причина закрытия захоронения	19	add_closurecause
56	Can change Причина закрытия захоронения	19	change_closurecause
57	Can delete Причина закрытия захоронения	19	delete_closurecause
58	Can add Воин	20	add_person
59	Can change Воин	20	change_person
60	Can delete Воин	20	delete_person
61	Can add Адрес рождения	21	add_locationbirth
62	Can change Адрес рождения	21	change_locationbirth
63	Can delete Адрес рождения	21	delete_locationbirth
64	Can add Захоронение	22	add_burial
65	Can change Захоронение	22	change_burial
66	Can delete Захоронение	22	delete_burial
67	Can add Адрес захоронения	23	add_locationburial
68	Can change Адрес захоронения	23	change_locationburial
69	Can delete Адрес захоронения	23	delete_locationburial
70	Can add место службы	24	add_duty
71	Can change место службы	24	change_duty
72	Can delete место службы	24	delete_duty
73	Can add Захоронения военнослужащего	25	add_personburial
74	Can change Захоронения военнослужащего	25	change_personburial
75	Can delete Захоронения военнослужащего	25	delete_personburial
76	Can add История службы	26	add_personduty
77	Can change История службы	26	change_personduty
78	Can delete История службы	26	delete_personduty
79	Can add Адрес места службы	27	add_locationduty
80	Can change Адрес места службы	27	change_locationduty
81	Can delete Адрес места службы	27	delete_locationduty
82	Can add log entry	28	add_logentry
83	Can change log entry	28	change_logentry
84	Can delete log entry	28	delete_logentry
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined) FROM stdin;
1	robotd			soul@youmemory.org	sha1$e1100$70c297116a7dabe30f1717714593f48fca71562e	t	t	t	2011-05-06 19:31:44.939259+04	2011-05-06 19:31:13.73836+04
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
\.


--
-- Data for Name: common_burial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_burial (uuid, passportid, date_passport, date_burried, date_discovered, date_closed, closure_cause_id, burial_type_id, military_conflict_id, date_memorial, date_gosznak, foto, creator_id, date_of_creation, date_last_edit, additional_info, is_trash) FROM stdin;
8e6d8f10-77f6-11e0-bd3f-67b9b9ac342f	111	2011-05-04	2011-05-02	2011-05-03	2011-05-06	e9b90044-748f-11e0-9944-af1700e642dd	04362508-701e-11e0-879c-00003975d28a	6afb4888-77f6-11e0-bd3f-67b9b9ac342f	2011-05-06	2011-05-06		1	2011-05-06 19:36:05.632221+04	2011-05-06 19:36:05.632252+04		f
\.


--
-- Data for Name: common_burialtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_burialtype (uuid, name) FROM stdin;
f93e3726-701d-11e0-879c-00003975d28a	воинское кладбище
fe168afa-701d-11e0-879c-00003975d28a	братская могила
04362508-701e-11e0-879c-00003975d28a	индивидуальная могила
0ee092ea-701e-11e0-879c-00003975d28a	локальные военные конфликты
13c8ed02-701e-11e0-879c-00003975d28a	место массового уничтожения
256b9f3c-701e-11e0-879c-00003975d28a	смешанное захоронение
2b70c790-701e-11e0-879c-00003975d28a	иностранное захоронение
\.


--
-- Data for Name: common_closurecause; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_closurecause (uuid, name) FROM stdin;
e9b90044-748f-11e0-9944-af1700e642dd	решение Администрации
\.


--
-- Data for Name: common_deadmancategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_deadmancategory (uuid, name) FROM stdin;
df727b40-701d-11e0-879c-00003975d28a	военнослужащий
e47c34fa-701d-11e0-879c-00003975d28a	участник сопротивления
e8059184-701d-11e0-879c-00003975d28a	жертва войны
ec59cc28-701d-11e0-879c-00003975d28a	военнопленный
\.


--
-- Data for Name: common_deathcause; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_deathcause (uuid, name) FROM stdin;
355f5fa0-701e-11e0-879c-00003975d28a	погиб в бою
39894712-701e-11e0-879c-00003975d28a	умер от ран
3ec5c1ec-701e-11e0-879c-00003975d28a	умер в плену
41e089e8-701e-11e0-879c-00003975d28a	казнен
473dc3f6-701e-11e0-879c-00003975d28a	пропал без вести
4bb23bf6-701e-11e0-879c-00003975d28a	другая
\.


--
-- Data for Name: common_documentsplace; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_documentsplace (uuid, name) FROM stdin;
4cf59dd6-7277-11e0-a1aa-00003975d28a	архив
51def752-7277-11e0-a1aa-00003975d28a	утеряны
\.


--
-- Data for Name: common_duty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_duty (uuid, name) FROM stdin;
4931fddc-7288-11e0-8373-00003975d28a	в/ч 1221
\.


--
-- Data for Name: common_geocity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_geocity (uuid, region_id, name) FROM stdin;
3abe748c-7324-11e0-96e5-00003975d28a	316c99d6-7324-11e0-96e5-00003975d28a	Минск
090df6de-7490-11e0-9944-af1700e642dd	fc34c79e-748f-11e0-9944-af1700e642dd	Смоленск
\.


--
-- Data for Name: common_geocountry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_geocountry (uuid, name) FROM stdin;
2a42fb5a-7324-11e0-96e5-00003975d28a	Беларусь
f2f9b4f0-748f-11e0-9944-af1700e642dd	Россия
\.


--
-- Data for Name: common_georegion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_georegion (uuid, country_id, name) FROM stdin;
316c99d6-7324-11e0-96e5-00003975d28a	2a42fb5a-7324-11e0-96e5-00003975d28a	Минская обл.
fc34c79e-748f-11e0-9944-af1700e642dd	f2f9b4f0-748f-11e0-9944-af1700e642dd	Смоленская обл.
\.


--
-- Data for Name: common_geostreet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_geostreet (uuid, city_id, name) FROM stdin;
814908fa-77f6-11e0-bd3f-67b9b9ac342f	3abe748c-7324-11e0-96e5-00003975d28a	Скорины
\.


--
-- Data for Name: common_informationsource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_informationsource (uuid, name) FROM stdin;
6aca36c8-7277-11e0-a1aa-00003975d28a	ОБД "Мемориал"
6d9c0a5c-7277-11e0-a1aa-00003975d28a	РИК (РВК)
72f5120a-7277-11e0-a1aa-00003975d28a	Книга памяти
75fee9a8-7277-11e0-a1aa-00003975d28a	Национальный архив
\.


--
-- Data for Name: common_locationbirth; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_locationbirth (country_id, region_id, city_id, gps_x, gps_y, gps_z, person_id) FROM stdin;
2a42fb5a-7324-11e0-96e5-00003975d28a	316c99d6-7324-11e0-96e5-00003975d28a	3abe748c-7324-11e0-96e5-00003975d28a	\N	\N	\N	927ae1e8-77f6-11e0-bd3f-67b9b9ac342f
f2f9b4f0-748f-11e0-9944-af1700e642dd	fc34c79e-748f-11e0-9944-af1700e642dd	090df6de-7490-11e0-9944-af1700e642dd	\N	\N	\N	c1e7bc76-77f6-11e0-bd3f-67b9b9ac342f
\.


--
-- Data for Name: common_locationburial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_locationburial (country_id, region_id, city_id, gps_x, gps_y, gps_z, burial_id, post_index, street_id, house, block, building) FROM stdin;
2a42fb5a-7324-11e0-96e5-00003975d28a	316c99d6-7324-11e0-96e5-00003975d28a	3abe748c-7324-11e0-96e5-00003975d28a	\N	\N	\N	8e6d8f10-77f6-11e0-bd3f-67b9b9ac342f		814908fa-77f6-11e0-bd3f-67b9b9ac342f	131Б		
\.


--
-- Data for Name: common_locationduty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_locationduty (country_id, region_id, city_id, gps_x, gps_y, gps_z, duty_id, post_index, street_id, house, block, building) FROM stdin;
\.


--
-- Data for Name: common_militaryconflict; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_militaryconflict (uuid, name, military_conflict_category_id) FROM stdin;
6afb4888-77f6-11e0-bd3f-67b9b9ac342f	Великая Отечественная война	61132106-77f6-11e0-bd3f-67b9b9ac342f
\.


--
-- Data for Name: common_militaryconflictcategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_militaryconflictcategory (uuid, name) FROM stdin;
61132106-77f6-11e0-bd3f-67b9b9ac342f	ВОВ
\.


--
-- Data for Name: common_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_person (uuid, last_name, first_name, patronymic, birth_date, death_date, death_cause_id, deadman_category_id, documents_place_id, information_source_id, creator_id, date_of_creation, additional_info, is_trash) FROM stdin;
927ae1e8-77f6-11e0-bd3f-67b9b9ac342f	Иванов	Иван	Иванович	2011-05-06	2011-05-06	355f5fa0-701e-11e0-879c-00003975d28a	df727b40-701d-11e0-879c-00003975d28a	4cf59dd6-7277-11e0-a1aa-00003975d28a	6aca36c8-7277-11e0-a1aa-00003975d28a	1	2011-05-06 19:36:12.430362+04	третья хата справа	f
c1e7bc76-77f6-11e0-bd3f-67b9b9ac342f	Петров	Петр	Петрович	2011-05-06	2011-05-06	39894712-701e-11e0-879c-00003975d28a	e47c34fa-701d-11e0-879c-00003975d28a	51def752-7277-11e0-a1aa-00003975d28a	6d9c0a5c-7277-11e0-a1aa-00003975d28a	1	2011-05-06 19:37:31.996652+04	из семьи рабочих	f
\.


--
-- Data for Name: common_personburial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_personburial (uuid, person_id, burial_id, date_burried, date_exhumated) FROM stdin;
927b75ea-77f6-11e0-bd3f-67b9b9ac342f	927ae1e8-77f6-11e0-bd3f-67b9b9ac342f	8e6d8f10-77f6-11e0-bd3f-67b9b9ac342f	2011-05-06	2011-05-06
c1e83746-77f6-11e0-bd3f-67b9b9ac342f	c1e7bc76-77f6-11e0-bd3f-67b9b9ac342f	8e6d8f10-77f6-11e0-bd3f-67b9b9ac342f	2011-05-06	2011-05-06
\.


--
-- Data for Name: common_personduty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_personduty (uuid, person_id, rank_id, duty_id, date_from, date_to) FROM stdin;
927be4f8-77f6-11e0-bd3f-67b9b9ac342f	927ae1e8-77f6-11e0-bd3f-67b9b9ac342f	2f9b7fa6-77f6-11e0-bd3f-67b9b9ac342f	4931fddc-7288-11e0-8373-00003975d28a	2011-05-03	2011-05-06
c1e89b14-77f6-11e0-bd3f-67b9b9ac342f	c1e7bc76-77f6-11e0-bd3f-67b9b9ac342f	2c1240ae-77f6-11e0-bd3f-67b9b9ac342f	4931fddc-7288-11e0-8373-00003975d28a	2011-05-06	2011-05-06
\.


--
-- Data for Name: common_rank; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY common_rank (uuid, name) FROM stdin;
2c1240ae-77f6-11e0-bd3f-67b9b9ac342f	рядовой
2f9b7fa6-77f6-11e0-bd3f-67b9b9ac342f	сержант
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
1	2011-05-06 19:33:20.6175+04	1	11	2c1240ae-77f6-11e0-bd3f-67b9b9ac342f	рядовой	1	
2	2011-05-06 19:33:26.549978+04	1	11	2f9b7fa6-77f6-11e0-bd3f-67b9b9ac342f	сержант	1	
3	2011-05-06 19:34:49.542461+04	1	16	61132106-77f6-11e0-bd3f-67b9b9ac342f	ВОВ	1	
4	2011-05-06 19:35:06.163532+04	1	17	6afb4888-77f6-11e0-bd3f-67b9b9ac342f	Великая Отечественная война	1	
5	2011-05-06 19:35:43.583111+04	1	10	814908fa-77f6-11e0-bd3f-67b9b9ac342f	Скорины	1	
6	2011-05-06 19:36:05.638453+04	1	22	8e6d8f10-77f6-11e0-bd3f-67b9b9ac342f	111	1	
7	2011-05-06 19:36:12.441374+04	1	20	927ae1e8-77f6-11e0-bd3f-67b9b9ac342f	Иванов	1	
8	2011-05-06 19:37:32.005833+04	1	20	c1e7bc76-77f6-11e0-bd3f-67b9b9ac342f	Петров	1	
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
7	страна	common	geocountry
8	регион	common	georegion
9	населенный пункт	common	geocity
10	улица	common	geostreet
11	воинское звание	common	rank
12	Причина гибели	common	deathcause
13	Категория погибшего	common	deadmancategory
14	Место нахождения документов	common	documentsplace
15	Тип воинского захоронения	common	burialtype
16	Категория военного конфликта	common	militaryconflictcategory
17	Военный конфликт	common	militaryconflict
18	Источник информации	common	informationsource
19	Причина закрытия захоронения	common	closurecause
20	Воин	common	person
21	Адрес рождения	common	locationbirth
22	Захоронение	common	burial
23	Адрес захоронения	common	locationburial
24	место службы	common	duty
25	Захоронения военнослужащего	common	personburial
26	История службы	common	personduty
27	Адрес места службы	common	locationduty
28	log entry	admin	logentry
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
947177f6b0dd37ff0dc0f5de417bf8dc	ODgxOTIxODJmYWMxNzZjMjYyNjBlYjgyY2RmZmRjNjUzOGQzZDIwNzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2011-05-20 19:31:44.942214+04
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
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
-- Name: common_burialtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_burialtype
    ADD CONSTRAINT common_burialtype_pkey PRIMARY KEY (uuid);


--
-- Name: common_closurecause_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_closurecause
    ADD CONSTRAINT common_closurecause_pkey PRIMARY KEY (uuid);


--
-- Name: common_deadmancategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_deadmancategory
    ADD CONSTRAINT common_deadmancategory_pkey PRIMARY KEY (uuid);


--
-- Name: common_deathcause_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_deathcause
    ADD CONSTRAINT common_deathcause_pkey PRIMARY KEY (uuid);


--
-- Name: common_documentsplace_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_documentsplace
    ADD CONSTRAINT common_documentsplace_pkey PRIMARY KEY (uuid);


--
-- Name: common_duty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_duty
    ADD CONSTRAINT common_duty_pkey PRIMARY KEY (uuid);


--
-- Name: common_geocity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geocity
    ADD CONSTRAINT common_geocity_pkey PRIMARY KEY (uuid);


--
-- Name: common_geocity_region_id_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geocity
    ADD CONSTRAINT common_geocity_region_id_name_key UNIQUE (region_id, name);


--
-- Name: common_geocountry_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geocountry
    ADD CONSTRAINT common_geocountry_name_key UNIQUE (name);


--
-- Name: common_geocountry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geocountry
    ADD CONSTRAINT common_geocountry_pkey PRIMARY KEY (uuid);


--
-- Name: common_georegion_country_id_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_georegion
    ADD CONSTRAINT common_georegion_country_id_name_key UNIQUE (country_id, name);


--
-- Name: common_georegion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_georegion
    ADD CONSTRAINT common_georegion_pkey PRIMARY KEY (uuid);


--
-- Name: common_geostreet_city_id_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geostreet
    ADD CONSTRAINT common_geostreet_city_id_name_key UNIQUE (city_id, name);


--
-- Name: common_geostreet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_geostreet
    ADD CONSTRAINT common_geostreet_pkey PRIMARY KEY (uuid);


--
-- Name: common_informationsource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_informationsource
    ADD CONSTRAINT common_informationsource_pkey PRIMARY KEY (uuid);


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
-- Name: common_locationduty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_locationduty
    ADD CONSTRAINT common_locationduty_pkey PRIMARY KEY (duty_id);


--
-- Name: common_militaryconflict_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_militaryconflict
    ADD CONSTRAINT common_militaryconflict_pkey PRIMARY KEY (uuid);


--
-- Name: common_militaryconflictcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_militaryconflictcategory
    ADD CONSTRAINT common_militaryconflictcategory_pkey PRIMARY KEY (uuid);


--
-- Name: common_person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT common_person_pkey PRIMARY KEY (uuid);


--
-- Name: common_personburial_person_id_burial_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_personburial
    ADD CONSTRAINT common_personburial_person_id_burial_id_key UNIQUE (person_id, burial_id);


--
-- Name: common_personburial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_personburial
    ADD CONSTRAINT common_personburial_pkey PRIMARY KEY (uuid);


--
-- Name: common_personduty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_personduty
    ADD CONSTRAINT common_personduty_pkey PRIMARY KEY (uuid);


--
-- Name: common_rank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY common_rank
    ADD CONSTRAINT common_rank_pkey PRIMARY KEY (uuid);


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
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


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
-- Name: common_burial_burial_type_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_burial_type_id_like ON common_burial USING btree (burial_type_id varchar_pattern_ops);


--
-- Name: common_burial_closure_cause_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_closure_cause_id ON common_burial USING btree (closure_cause_id);


--
-- Name: common_burial_closure_cause_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_closure_cause_id_like ON common_burial USING btree (closure_cause_id varchar_pattern_ops);


--
-- Name: common_burial_creator_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_creator_id ON common_burial USING btree (creator_id);


--
-- Name: common_burial_military_conflict_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_military_conflict_id ON common_burial USING btree (military_conflict_id);


--
-- Name: common_burial_military_conflict_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_burial_military_conflict_id_like ON common_burial USING btree (military_conflict_id varchar_pattern_ops);


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
-- Name: common_geocity_region_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_geocity_region_id_like ON common_geocity USING btree (region_id varchar_pattern_ops);


--
-- Name: common_georegion_country_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_georegion_country_id ON common_georegion USING btree (country_id);


--
-- Name: common_georegion_country_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_georegion_country_id_like ON common_georegion USING btree (country_id varchar_pattern_ops);


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
-- Name: common_geostreet_city_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_geostreet_city_id_like ON common_geostreet USING btree (city_id varchar_pattern_ops);


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
-- Name: common_locationbirth_city_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationbirth_city_id_like ON common_locationbirth USING btree (city_id varchar_pattern_ops);


--
-- Name: common_locationbirth_country_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationbirth_country_id ON common_locationbirth USING btree (country_id);


--
-- Name: common_locationbirth_country_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationbirth_country_id_like ON common_locationbirth USING btree (country_id varchar_pattern_ops);


--
-- Name: common_locationbirth_region_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationbirth_region_id ON common_locationbirth USING btree (region_id);


--
-- Name: common_locationbirth_region_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationbirth_region_id_like ON common_locationbirth USING btree (region_id varchar_pattern_ops);


--
-- Name: common_locationburial_city_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_city_id ON common_locationburial USING btree (city_id);


--
-- Name: common_locationburial_city_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_city_id_like ON common_locationburial USING btree (city_id varchar_pattern_ops);


--
-- Name: common_locationburial_country_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_country_id ON common_locationburial USING btree (country_id);


--
-- Name: common_locationburial_country_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_country_id_like ON common_locationburial USING btree (country_id varchar_pattern_ops);


--
-- Name: common_locationburial_region_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_region_id ON common_locationburial USING btree (region_id);


--
-- Name: common_locationburial_region_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_region_id_like ON common_locationburial USING btree (region_id varchar_pattern_ops);


--
-- Name: common_locationburial_street_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_street_id ON common_locationburial USING btree (street_id);


--
-- Name: common_locationburial_street_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationburial_street_id_like ON common_locationburial USING btree (street_id varchar_pattern_ops);


--
-- Name: common_locationduty_city_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationduty_city_id ON common_locationduty USING btree (city_id);


--
-- Name: common_locationduty_city_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationduty_city_id_like ON common_locationduty USING btree (city_id varchar_pattern_ops);


--
-- Name: common_locationduty_country_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationduty_country_id ON common_locationduty USING btree (country_id);


--
-- Name: common_locationduty_country_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationduty_country_id_like ON common_locationduty USING btree (country_id varchar_pattern_ops);


--
-- Name: common_locationduty_region_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationduty_region_id ON common_locationduty USING btree (region_id);


--
-- Name: common_locationduty_region_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationduty_region_id_like ON common_locationduty USING btree (region_id varchar_pattern_ops);


--
-- Name: common_locationduty_street_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationduty_street_id ON common_locationduty USING btree (street_id);


--
-- Name: common_locationduty_street_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_locationduty_street_id_like ON common_locationduty USING btree (street_id varchar_pattern_ops);


--
-- Name: common_militaryconflict_military_conflict_category_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_militaryconflict_military_conflict_category_id ON common_militaryconflict USING btree (military_conflict_category_id);


--
-- Name: common_militaryconflict_military_conflict_category_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_militaryconflict_military_conflict_category_id_like ON common_militaryconflict USING btree (military_conflict_category_id varchar_pattern_ops);


--
-- Name: common_person_creator_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_creator_id ON common_person USING btree (creator_id);


--
-- Name: common_person_deadman_category_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_deadman_category_id ON common_person USING btree (deadman_category_id);


--
-- Name: common_person_deadman_category_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_deadman_category_id_like ON common_person USING btree (deadman_category_id varchar_pattern_ops);


--
-- Name: common_person_death_cause_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_death_cause_id ON common_person USING btree (death_cause_id);


--
-- Name: common_person_death_cause_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_death_cause_id_like ON common_person USING btree (death_cause_id varchar_pattern_ops);


--
-- Name: common_person_documents_place_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_documents_place_id ON common_person USING btree (documents_place_id);


--
-- Name: common_person_documents_place_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_documents_place_id_like ON common_person USING btree (documents_place_id varchar_pattern_ops);


--
-- Name: common_person_information_source_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_information_source_id ON common_person USING btree (information_source_id);


--
-- Name: common_person_information_source_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_person_information_source_id_like ON common_person USING btree (information_source_id varchar_pattern_ops);


--
-- Name: common_personburial_burial_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personburial_burial_id ON common_personburial USING btree (burial_id);


--
-- Name: common_personburial_burial_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personburial_burial_id_like ON common_personburial USING btree (burial_id varchar_pattern_ops);


--
-- Name: common_personburial_person_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personburial_person_id ON common_personburial USING btree (person_id);


--
-- Name: common_personburial_person_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personburial_person_id_like ON common_personburial USING btree (person_id varchar_pattern_ops);


--
-- Name: common_personduty_duty_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personduty_duty_id ON common_personduty USING btree (duty_id);


--
-- Name: common_personduty_duty_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personduty_duty_id_like ON common_personduty USING btree (duty_id varchar_pattern_ops);


--
-- Name: common_personduty_person_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personduty_person_id ON common_personduty USING btree (person_id);


--
-- Name: common_personduty_person_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personduty_person_id_like ON common_personduty USING btree (person_id varchar_pattern_ops);


--
-- Name: common_personduty_rank_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personduty_rank_id ON common_personduty USING btree (rank_id);


--
-- Name: common_personduty_rank_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX common_personduty_rank_id_like ON common_personduty USING btree (rank_id varchar_pattern_ops);


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
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


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
-- Name: common_burial_burial_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burial
    ADD CONSTRAINT common_burial_burial_type_id_fkey FOREIGN KEY (burial_type_id) REFERENCES common_burialtype(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_burial_closure_cause_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burial
    ADD CONSTRAINT common_burial_closure_cause_id_fkey FOREIGN KEY (closure_cause_id) REFERENCES common_closurecause(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_burial_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burial
    ADD CONSTRAINT common_burial_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_burial_military_conflict_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_burial
    ADD CONSTRAINT common_burial_military_conflict_id_fkey FOREIGN KEY (military_conflict_id) REFERENCES common_militaryconflict(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_geocity_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_geocity
    ADD CONSTRAINT common_geocity_region_id_fkey FOREIGN KEY (region_id) REFERENCES common_georegion(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_georegion_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_georegion
    ADD CONSTRAINT common_georegion_country_id_fkey FOREIGN KEY (country_id) REFERENCES common_geocountry(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_geostreet_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_geostreet
    ADD CONSTRAINT common_geostreet_city_id_fkey FOREIGN KEY (city_id) REFERENCES common_geocity(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationbirth_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationbirth
    ADD CONSTRAINT common_locationbirth_city_id_fkey FOREIGN KEY (city_id) REFERENCES common_geocity(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationbirth_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationbirth
    ADD CONSTRAINT common_locationbirth_country_id_fkey FOREIGN KEY (country_id) REFERENCES common_geocountry(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationbirth_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationbirth
    ADD CONSTRAINT common_locationbirth_person_id_fkey FOREIGN KEY (person_id) REFERENCES common_person(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationbirth_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationbirth
    ADD CONSTRAINT common_locationbirth_region_id_fkey FOREIGN KEY (region_id) REFERENCES common_georegion(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationburial_burial_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT common_locationburial_burial_id_fkey FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationburial_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT common_locationburial_city_id_fkey FOREIGN KEY (city_id) REFERENCES common_geocity(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationburial_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT common_locationburial_country_id_fkey FOREIGN KEY (country_id) REFERENCES common_geocountry(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationburial_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT common_locationburial_region_id_fkey FOREIGN KEY (region_id) REFERENCES common_georegion(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationburial_street_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationburial
    ADD CONSTRAINT common_locationburial_street_id_fkey FOREIGN KEY (street_id) REFERENCES common_geostreet(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationduty_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationduty
    ADD CONSTRAINT common_locationduty_city_id_fkey FOREIGN KEY (city_id) REFERENCES common_geocity(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationduty_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationduty
    ADD CONSTRAINT common_locationduty_country_id_fkey FOREIGN KEY (country_id) REFERENCES common_geocountry(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationduty_duty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationduty
    ADD CONSTRAINT common_locationduty_duty_id_fkey FOREIGN KEY (duty_id) REFERENCES common_personduty(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationduty_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationduty
    ADD CONSTRAINT common_locationduty_region_id_fkey FOREIGN KEY (region_id) REFERENCES common_georegion(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_locationduty_street_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_locationduty
    ADD CONSTRAINT common_locationduty_street_id_fkey FOREIGN KEY (street_id) REFERENCES common_geostreet(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_militaryconflict_military_conflict_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_militaryconflict
    ADD CONSTRAINT common_militaryconflict_military_conflict_category_id_fkey FOREIGN KEY (military_conflict_category_id) REFERENCES common_militaryconflictcategory(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_person_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT common_person_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_person_deadman_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT common_person_deadman_category_id_fkey FOREIGN KEY (deadman_category_id) REFERENCES common_deadmancategory(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_person_death_cause_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT common_person_death_cause_id_fkey FOREIGN KEY (death_cause_id) REFERENCES common_deathcause(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_person_documents_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT common_person_documents_place_id_fkey FOREIGN KEY (documents_place_id) REFERENCES common_documentsplace(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_person_information_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_person
    ADD CONSTRAINT common_person_information_source_id_fkey FOREIGN KEY (information_source_id) REFERENCES common_informationsource(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_personburial_burial_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personburial
    ADD CONSTRAINT common_personburial_burial_id_fkey FOREIGN KEY (burial_id) REFERENCES common_burial(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_personburial_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personburial
    ADD CONSTRAINT common_personburial_person_id_fkey FOREIGN KEY (person_id) REFERENCES common_person(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_personduty_duty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personduty
    ADD CONSTRAINT common_personduty_duty_id_fkey FOREIGN KEY (duty_id) REFERENCES common_duty(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_personduty_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personduty
    ADD CONSTRAINT common_personduty_person_id_fkey FOREIGN KEY (person_id) REFERENCES common_person(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: common_personduty_rank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY common_personduty
    ADD CONSTRAINT common_personduty_rank_id_fkey FOREIGN KEY (rank_id) REFERENCES common_rank(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_728de91f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_728de91f FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


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
-- Name: group_id_refs_id_3cea63fe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_3cea63fe FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


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

