--
-- PostgreSQL database cluster dump
--

\connect postgres

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET escape_string_warning = off;

--
-- Roles
--

CREATE ROLE cpas_admin;
ALTER ROLE cpas_admin WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'md5ad5f961a3dafba7cea8a2c7b3e439ece' VALID UNTIL 'infinity';
CREATE ROLE elect_admin;
ALTER ROLE elect_admin WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'md5c62c56dba9d77236095a9198d117fd68' VALID UNTIL 'infinity';
CREATE ROLE jaotdbadmin;
ALTER ROLE jaotdbadmin WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'md563f9776d9af3778d0fe2a336de75d998' VALID UNTIL 'infinity';
CREATE ROLE jizen_local;
ALTER ROLE jizen_local WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'md5178452511cffb6620c4c3d94903b1a4b' VALID UNTIL 'infinity';
CREATE ROLE keijiban_local;
ALTER ROLE keijiban_local WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'md52bf1a76f70ef29e41b4d24f80adc580d' VALID UNTIL 'infinity';
CREATE ROLE keijiban_web;
ALTER ROLE keijiban_web WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'md5e4f943e0a7dd9a0b46a674ee25006a7d' VALID UNTIL 'infinity';
CREATE ROLE otwebdb_ad_new;
ALTER ROLE otwebdb_ad_new WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'md575a18a990ed4ab8ad4a75c3d8e82664c' VALID UNTIL 'infinity';
CREATE ROLE pguser;
ALTER ROLE pguser WITH SUPERUSER INHERIT NOCREATEROLE CREATEDB LOGIN PASSWORD 'md57ed8d0ea43ad387aaa4a138ac4dae045' VALID UNTIL 'infinity';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN;
CREATE ROLE syogai_web;
ALTER ROLE syogai_web WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'md5eabb17a9ccec8fcd1d4634df74acc0b9' VALID UNTIL 'infinity';
CREATE ROLE zenken_local;
ALTER ROLE zenken_local WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'md56f44a1a6b565313b87214d89a494c4d4' VALID UNTIL 'infinity';


--
-- Role memberships
--

GRANT pguser TO zenken_local GRANTED BY pguser;




--
-- Database creation
--

CREATE DATABASE cpas WITH TEMPLATE = template0 OWNER = pguser;
CREATE DATABASE elect WITH TEMPLATE = template0 OWNER = pguser;
CREATE DATABASE jireinet WITH TEMPLATE = template0 OWNER = pguser;
CREATE DATABASE jizen WITH TEMPLATE = template0 OWNER = pguser;
CREATE DATABASE keijiban WITH TEMPLATE = template0 OWNER = pguser;
CREATE DATABASE otwebdb_new WITH TEMPLATE = template0 OWNER = pguser;
CREATE DATABASE syogai WITH TEMPLATE = template0 OWNER = pguser;
REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;
CREATE DATABASE zenken WITH TEMPLATE = template0 OWNER = pguser;


\connect cpas

SET default_transaction_read_only = off;

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
-- Name: cpas; Type: COMMENT; Schema: -; Owner: pguser
--

COMMENT ON DATABASE cpas IS '代議員選挙システム';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: cpas_admin; Tablespace: 
--

CREATE TABLE active_sessions (
    sid character varying(32) DEFAULT ''::character varying NOT NULL,
    name character varying(32) DEFAULT ''::character varying NOT NULL,
    val text,
    changed character varying(14) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.active_sessions OWNER TO cpas_admin;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: cpas_admin; Tablespace: 
--

CREATE TABLE auth_user (
    user_id character varying(32) NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(64),
    perms character varying(255)
);


ALTER TABLE public.auth_user OWNER TO cpas_admin;

--
-- Name: auth_user_md5; Type: TABLE; Schema: public; Owner: cpas_admin; Tablespace: 
--

CREATE TABLE auth_user_md5 (
    user_id character varying(32) NOT NULL,
    username character varying(32) DEFAULT ''::character varying NOT NULL,
    password character varying(32) DEFAULT ''::character varying NOT NULL,
    mail_address character varying(64) DEFAULT ''::character varying,
    perms character varying(255)
);


ALTER TABLE public.auth_user_md5 OWNER TO cpas_admin;

--
-- Name: t_candidacy; Type: TABLE; Schema: public; Owner: cpas_admin; Tablespace: 
--

CREATE TABLE t_candidacy (
    cand_no integer NOT NULL,
    cand_name character varying(32) DEFAULT ''::character varying NOT NULL,
    cand_kana character varying(32) DEFAULT ''::character varying NOT NULL,
    seibetu smallint,
    senden text,
    todoufuken smallint,
    kinmu_sisetumei character varying(100)
);


ALTER TABLE public.t_candidacy OWNER TO cpas_admin;

--
-- Name: t_collation; Type: TABLE; Schema: public; Owner: cpas_admin; Tablespace: 
--

CREATE TABLE t_collation (
    voter_id character varying(10) DEFAULT ''::character varying NOT NULL,
    voter_ps character varying(10) DEFAULT ''::character varying NOT NULL,
    comp_flg smallint,
    todoufuken smallint
);


ALTER TABLE public.t_collation OWNER TO cpas_admin;

--
-- Name: t_vote; Type: TABLE; Schema: public; Owner: cpas_admin; Tablespace: 
--

CREATE TABLE t_vote (
    seqno integer NOT NULL,
    voter_id character varying(10),
    voter_ps character varying(10),
    cand_no integer
);


ALTER TABLE public.t_vote OWNER TO cpas_admin;

--
-- Name: tm_todoufuken; Type: TABLE; Schema: public; Owner: cpas_admin; Tablespace: 
--

CREATE TABLE tm_todoufuken (
    no integer NOT NULL,
    meisyou character varying(10),
    teiin integer,
    kaiinsuu integer,
    kakutei_flg smallint
);


ALTER TABLE public.tm_todoufuken OWNER TO cpas_admin;

--
-- Name: active_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: cpas_admin; Tablespace: 
--

ALTER TABLE ONLY active_sessions
    ADD CONSTRAINT active_sessions_pkey PRIMARY KEY (sid, name);


--
-- Name: auth_user_md5_pkey; Type: CONSTRAINT; Schema: public; Owner: cpas_admin; Tablespace: 
--

ALTER TABLE ONLY auth_user_md5
    ADD CONSTRAINT auth_user_md5_pkey PRIMARY KEY (user_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: cpas_admin; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (user_id);


--
-- Name: t_candidacy_pkey; Type: CONSTRAINT; Schema: public; Owner: cpas_admin; Tablespace: 
--

ALTER TABLE ONLY t_candidacy
    ADD CONSTRAINT t_candidacy_pkey PRIMARY KEY (cand_no);


--
-- Name: t_collation_pkey; Type: CONSTRAINT; Schema: public; Owner: cpas_admin; Tablespace: 
--

ALTER TABLE ONLY t_collation
    ADD CONSTRAINT t_collation_pkey PRIMARY KEY (voter_id, voter_ps);


--
-- Name: t_vote_pkey; Type: CONSTRAINT; Schema: public; Owner: cpas_admin; Tablespace: 
--

ALTER TABLE ONLY t_vote
    ADD CONSTRAINT t_vote_pkey PRIMARY KEY (seqno);


--
-- Name: tm_todoufuken_pkey; Type: CONSTRAINT; Schema: public; Owner: cpas_admin; Tablespace: 
--

ALTER TABLE ONLY tm_todoufuken
    ADD CONSTRAINT tm_todoufuken_pkey PRIMARY KEY (no);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: active_sessions; Type: ACL; Schema: public; Owner: cpas_admin
--

REVOKE ALL ON TABLE active_sessions FROM PUBLIC;
REVOKE ALL ON TABLE active_sessions FROM cpas_admin;
GRANT ALL ON TABLE active_sessions TO cpas_admin;


--
-- Name: auth_user; Type: ACL; Schema: public; Owner: cpas_admin
--

REVOKE ALL ON TABLE auth_user FROM PUBLIC;
REVOKE ALL ON TABLE auth_user FROM cpas_admin;
GRANT ALL ON TABLE auth_user TO cpas_admin;


--
-- Name: auth_user_md5; Type: ACL; Schema: public; Owner: cpas_admin
--

REVOKE ALL ON TABLE auth_user_md5 FROM PUBLIC;
REVOKE ALL ON TABLE auth_user_md5 FROM cpas_admin;
GRANT ALL ON TABLE auth_user_md5 TO cpas_admin;


--
-- Name: t_candidacy; Type: ACL; Schema: public; Owner: cpas_admin
--

REVOKE ALL ON TABLE t_candidacy FROM PUBLIC;
REVOKE ALL ON TABLE t_candidacy FROM cpas_admin;
GRANT ALL ON TABLE t_candidacy TO cpas_admin;


--
-- Name: t_collation; Type: ACL; Schema: public; Owner: cpas_admin
--

REVOKE ALL ON TABLE t_collation FROM PUBLIC;
REVOKE ALL ON TABLE t_collation FROM cpas_admin;
GRANT ALL ON TABLE t_collation TO cpas_admin;


--
-- Name: t_vote; Type: ACL; Schema: public; Owner: cpas_admin
--

REVOKE ALL ON TABLE t_vote FROM PUBLIC;
REVOKE ALL ON TABLE t_vote FROM cpas_admin;
GRANT ALL ON TABLE t_vote TO cpas_admin;


--
-- Name: tm_todoufuken; Type: ACL; Schema: public; Owner: cpas_admin
--

REVOKE ALL ON TABLE tm_todoufuken FROM PUBLIC;
REVOKE ALL ON TABLE tm_todoufuken FROM cpas_admin;
GRANT ALL ON TABLE tm_todoufuken TO cpas_admin;


--
-- PostgreSQL database dump complete
--

\connect elect

SET default_transaction_read_only = off;

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
-- Name: elect; Type: COMMENT; Schema: -; Owner: pguser
--

COMMENT ON DATABASE elect IS 'Web投票システム';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE active_sessions (
    sid character varying(32) DEFAULT ''::character varying NOT NULL,
    name character varying(32) DEFAULT ''::character varying NOT NULL,
    val text,
    changed character varying(14) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.active_sessions OWNER TO elect_admin;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE auth_user (
    user_id character varying(32) NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(64),
    perms character varying(255)
);


ALTER TABLE public.auth_user OWNER TO elect_admin;

--
-- Name: auth_user_md5; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE auth_user_md5 (
    user_id character varying(32) NOT NULL,
    username character varying(32) DEFAULT ''::character varying NOT NULL,
    password character varying(32) DEFAULT ''::character varying NOT NULL,
    mail_address character varying(64) DEFAULT ''::character varying,
    perms character varying(255)
);


ALTER TABLE public.auth_user_md5 OWNER TO elect_admin;

--
-- Name: t_candidacy; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE t_candidacy (
    cand_no integer,
    cand_name character varying(32),
    cand_kana character varying(32),
    seibetu smallint,
    executivecd smallint,
    nendo integer,
    end_flg smallint,
    youkou text
);


ALTER TABLE public.t_candidacy OWNER TO elect_admin;

--
-- Name: t_chairman; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE t_chairman (
    seqno integer NOT NULL,
    voter_id character varying(10),
    voter_ps character varying(10),
    cand_no integer
);


ALTER TABLE public.t_chairman OWNER TO elect_admin;

--
-- Name: t_chairman_seqno_seq; Type: SEQUENCE; Schema: public; Owner: elect_admin
--

CREATE SEQUENCE t_chairman_seqno_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_chairman_seqno_seq OWNER TO elect_admin;

--
-- Name: t_chairman_seqno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elect_admin
--

ALTER SEQUENCE t_chairman_seqno_seq OWNED BY t_chairman.seqno;


--
-- Name: t_collation; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE t_collation (
    voter_id character varying(10),
    voter_ps character varying(10),
    comp_flg character varying(50)
);


ALTER TABLE public.t_collation OWNER TO elect_admin;

--
-- Name: t_director; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE t_director (
    seqno integer NOT NULL,
    voter_id character varying(10),
    voter_ps character varying(10),
    cand_no integer
);


ALTER TABLE public.t_director OWNER TO elect_admin;

--
-- Name: t_director_seqno_seq; Type: SEQUENCE; Schema: public; Owner: elect_admin
--

CREATE SEQUENCE t_director_seqno_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_director_seqno_seq OWNER TO elect_admin;

--
-- Name: t_director_seqno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elect_admin
--

ALTER SEQUENCE t_director_seqno_seq OWNED BY t_director.seqno;


--
-- Name: t_executive; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE t_executive (
    executivecd smallint NOT NULL,
    executi character varying(32)
);


ALTER TABLE public.t_executive OWNER TO elect_admin;

--
-- Name: t_inspector; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE t_inspector (
    seqno integer NOT NULL,
    voter_id character varying(10),
    voter_ps character varying(10),
    cand_no integer
);


ALTER TABLE public.t_inspector OWNER TO elect_admin;

--
-- Name: t_inspector_seqno_seq; Type: SEQUENCE; Schema: public; Owner: elect_admin
--

CREATE SEQUENCE t_inspector_seqno_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_inspector_seqno_seq OWNER TO elect_admin;

--
-- Name: t_inspector_seqno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elect_admin
--

ALTER SEQUENCE t_inspector_seqno_seq OWNED BY t_inspector.seqno;


--
-- Name: t_kenshikai; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE t_kenshikai (
    seqno integer NOT NULL,
    kenshikai character varying(200)
);


ALTER TABLE public.t_kenshikai OWNER TO elect_admin;

--
-- Name: t_kenshikai_seqno_seq; Type: SEQUENCE; Schema: public; Owner: elect_admin
--

CREATE SEQUENCE t_kenshikai_seqno_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_kenshikai_seqno_seq OWNER TO elect_admin;

--
-- Name: t_kenshikai_seqno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elect_admin
--

ALTER SEQUENCE t_kenshikai_seqno_seq OWNED BY t_kenshikai.seqno;


--
-- Name: t_voter; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE t_voter (
    seqno integer NOT NULL,
    kaiincd character varying(50),
    age character varying(10),
    sex smallint,
    place character varying(16),
    browser character varying(300)
);


ALTER TABLE public.t_voter OWNER TO elect_admin;

--
-- Name: t_voter_seqno_seq; Type: SEQUENCE; Schema: public; Owner: elect_admin
--

CREATE SEQUENCE t_voter_seqno_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_voter_seqno_seq OWNER TO elect_admin;

--
-- Name: t_voter_seqno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elect_admin
--

ALTER SEQUENCE t_voter_seqno_seq OWNED BY t_voter.seqno;


--
-- Name: t_vpresident; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE t_vpresident (
    seqno integer NOT NULL,
    voter_id character varying(10),
    voter_ps character varying(10),
    cand_no integer
);


ALTER TABLE public.t_vpresident OWNER TO elect_admin;

--
-- Name: t_vpresident_seqno_seq; Type: SEQUENCE; Schema: public; Owner: elect_admin
--

CREATE SEQUENCE t_vpresident_seqno_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_vpresident_seqno_seq OWNER TO elect_admin;

--
-- Name: t_vpresident_seqno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elect_admin
--

ALTER SEQUENCE t_vpresident_seqno_seq OWNED BY t_vpresident.seqno;


--
-- Name: tm_todoufuken; Type: TABLE; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE TABLE tm_todoufuken (
    no character varying(2),
    meisyou character varying(10)
);


ALTER TABLE public.tm_todoufuken OWNER TO elect_admin;

--
-- Name: seqno; Type: DEFAULT; Schema: public; Owner: elect_admin
--

ALTER TABLE ONLY t_chairman ALTER COLUMN seqno SET DEFAULT nextval('t_chairman_seqno_seq'::regclass);


--
-- Name: seqno; Type: DEFAULT; Schema: public; Owner: elect_admin
--

ALTER TABLE ONLY t_director ALTER COLUMN seqno SET DEFAULT nextval('t_director_seqno_seq'::regclass);


--
-- Name: seqno; Type: DEFAULT; Schema: public; Owner: elect_admin
--

ALTER TABLE ONLY t_inspector ALTER COLUMN seqno SET DEFAULT nextval('t_inspector_seqno_seq'::regclass);


--
-- Name: seqno; Type: DEFAULT; Schema: public; Owner: elect_admin
--

ALTER TABLE ONLY t_kenshikai ALTER COLUMN seqno SET DEFAULT nextval('t_kenshikai_seqno_seq'::regclass);


--
-- Name: seqno; Type: DEFAULT; Schema: public; Owner: elect_admin
--

ALTER TABLE ONLY t_voter ALTER COLUMN seqno SET DEFAULT nextval('t_voter_seqno_seq'::regclass);


--
-- Name: seqno; Type: DEFAULT; Schema: public; Owner: elect_admin
--

ALTER TABLE ONLY t_vpresident ALTER COLUMN seqno SET DEFAULT nextval('t_vpresident_seqno_seq'::regclass);


--
-- Name: active_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: elect_admin; Tablespace: 
--

ALTER TABLE ONLY active_sessions
    ADD CONSTRAINT active_sessions_pkey PRIMARY KEY (sid, name);


--
-- Name: auth_user_md5_pkey; Type: CONSTRAINT; Schema: public; Owner: elect_admin; Tablespace: 
--

ALTER TABLE ONLY auth_user_md5
    ADD CONSTRAINT auth_user_md5_pkey PRIMARY KEY (user_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: elect_admin; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (user_id);


--
-- Name: t_executive_pkey; Type: CONSTRAINT; Schema: public; Owner: elect_admin; Tablespace: 
--

ALTER TABLE ONLY t_executive
    ADD CONSTRAINT t_executive_pkey PRIMARY KEY (executivecd);


--
-- Name: idx_cand_no_t_candidacy; Type: INDEX; Schema: public; Owner: elect_admin; Tablespace: 
--

CREATE UNIQUE INDEX idx_cand_no_t_candidacy ON t_candidacy USING btree (cand_no);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: active_sessions; Type: ACL; Schema: public; Owner: elect_admin
--

REVOKE ALL ON TABLE active_sessions FROM PUBLIC;
REVOKE ALL ON TABLE active_sessions FROM elect_admin;
GRANT ALL ON TABLE active_sessions TO elect_admin;


--
-- Name: auth_user; Type: ACL; Schema: public; Owner: elect_admin
--

REVOKE ALL ON TABLE auth_user FROM PUBLIC;
REVOKE ALL ON TABLE auth_user FROM elect_admin;
GRANT ALL ON TABLE auth_user TO elect_admin;


--
-- Name: auth_user_md5; Type: ACL; Schema: public; Owner: elect_admin
--

REVOKE ALL ON TABLE auth_user_md5 FROM PUBLIC;
REVOKE ALL ON TABLE auth_user_md5 FROM elect_admin;
GRANT ALL ON TABLE auth_user_md5 TO elect_admin;


--
-- Name: t_candidacy; Type: ACL; Schema: public; Owner: elect_admin
--

REVOKE ALL ON TABLE t_candidacy FROM PUBLIC;
REVOKE ALL ON TABLE t_candidacy FROM elect_admin;
GRANT ALL ON TABLE t_candidacy TO elect_admin;


--
-- Name: t_collation; Type: ACL; Schema: public; Owner: elect_admin
--

REVOKE ALL ON TABLE t_collation FROM PUBLIC;
REVOKE ALL ON TABLE t_collation FROM elect_admin;
GRANT ALL ON TABLE t_collation TO elect_admin;


--
-- Name: t_executive; Type: ACL; Schema: public; Owner: elect_admin
--

REVOKE ALL ON TABLE t_executive FROM PUBLIC;
REVOKE ALL ON TABLE t_executive FROM elect_admin;
GRANT ALL ON TABLE t_executive TO elect_admin;


--
-- PostgreSQL database dump complete
--

\connect jireinet

SET default_transaction_read_only = off;

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
-- Name: jireinet; Type: COMMENT; Schema: -; Owner: pguser
--

COMMENT ON DATABASE jireinet IS '事例報告登録システム';


SET search_path = public, pg_catalog;

--
-- Name: icf_type_enum; Type: TYPE; Schema: public; Owner: pguser
--

CREATE TYPE icf_type_enum AS ENUM (
    'icf',
    'intervention',
    'append_intervention',
    'result',
    'extra',
    'extra_intervention',
    'extra_result',
    'incidental_result'
);


ALTER TYPE public.icf_type_enum OWNER TO pguser;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE active_sessions (
    sid character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    val text,
    changed character varying(32) NOT NULL
);


ALTER TABLE public.active_sessions OWNER TO jaotdbadmin;

--
-- Name: active_sessions_split; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE active_sessions_split (
    ct_sid character varying(32) DEFAULT ''::character varying NOT NULL,
    ct_name character varying(32) DEFAULT ''::character varying NOT NULL,
    ct_pos character varying(6) DEFAULT ''::character varying NOT NULL,
    ct_val text,
    ct_changed character varying(14) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.active_sessions_split OWNER TO jaotdbadmin;

--
-- Name: active_tokens; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE active_tokens (
    token_id character varying(32),
    auth_user character varying(32),
    browser_name character varying(300),
    ip_address character varying(15),
    create_time character varying(12)
);


ALTER TABLE public.active_tokens OWNER TO jaotdbadmin;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE auth_user (
    user_id integer NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(64),
    perms character varying(255)
);


ALTER TABLE public.auth_user OWNER TO jaotdbadmin;

--
-- Name: auth_user_md5; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE auth_user_md5 (
    user_id character varying(32) NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(64),
    perms character varying(255)
);


ALTER TABLE public.auth_user_md5 OWNER TO jaotdbadmin;

--
-- Name: mt_evaluation; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_evaluation (
    evaluation_no smallint NOT NULL,
    evaluation_subno smallint NOT NULL,
    handicase character varying(50),
    type_no integer,
    sort_no smallint,
    tani smallint,
    view_sort smallint
);


ALTER TABLE public.mt_evaluation OWNER TO jaotdbadmin;

--
-- Name: e_n_c; Type: VIEW; Schema: public; Owner: jaotdbadmin
--

CREATE VIEW e_n_c AS
    SELECT mt_evaluation.evaluation_no, count(mt_evaluation.evaluation_no) AS count FROM mt_evaluation GROUP BY mt_evaluation.evaluation_no;


ALTER TABLE public.e_n_c OWNER TO jaotdbadmin;

--
-- Name: mojicode; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mojicode (
    sjis character varying(4) NOT NULL,
    euc character varying(4),
    utf_8 character varying(6),
    utf_16 character varying(6),
    view_moji character varying(4)
);


ALTER TABLE public.mojicode OWNER TO jaotdbadmin;

--
-- Name: mt_authorization; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_authorization (
    authorization_cd character varying(2) NOT NULL,
    "authorization" character varying(50)
);


ALTER TABLE public.mt_authorization OWNER TO jaotdbadmin;

--
-- Name: mt_case_kugiri; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_case_kugiri (
    id integer NOT NULL,
    input_no smallint NOT NULL
);


ALTER TABLE public.mt_case_kugiri OWNER TO jaotdbadmin;

--
-- Name: TABLE mt_case_kugiri; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON TABLE mt_case_kugiri IS '新旧生活事例を分ける情報テーブル';


--
-- Name: COLUMN mt_case_kugiri.input_no; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN mt_case_kugiri.input_no IS '新旧生活事例を分ける受け付け番号';


--
-- Name: mt_case_kugiri_id_seq; Type: SEQUENCE; Schema: public; Owner: jaotdbadmin
--

CREATE SEQUENCE mt_case_kugiri_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.mt_case_kugiri_id_seq OWNER TO jaotdbadmin;

--
-- Name: mt_case_kugiri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jaotdbadmin
--

ALTER SEQUENCE mt_case_kugiri_id_seq OWNED BY mt_case_kugiri.id;


--
-- Name: mt_disease; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_disease (
    disease_cd character varying(4) NOT NULL,
    disease character varying(20)
);


ALTER TABLE public.mt_disease OWNER TO jaotdbadmin;

--
-- Name: mt_info; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_info (
    seq smallint NOT NULL,
    category_cd character varying(3),
    info_cd character varying(3),
    info_name character varying(60)
);


ALTER TABLE public.mt_info OWNER TO jaotdbadmin;

--
-- Name: mt_judge; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_judge (
    judge_cd smallint NOT NULL,
    judge character varying(20),
    member_id character varying(8),
    psword character varying(20),
    judge_mail character varying(50),
    division character varying(2),
    del_flg smallint,
    case_type_1 smallint DEFAULT (1)::smallint,
    case_type_2 smallint
);


ALTER TABLE public.mt_judge OWNER TO jaotdbadmin;

--
-- Name: mt_keyword; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_keyword (
    keyword_cd smallint NOT NULL,
    keyword character varying(50),
    kana character varying(50),
    display_flg boolean DEFAULT false NOT NULL
);


ALTER TABLE public.mt_keyword OWNER TO jaotdbadmin;

--
-- Name: COLUMN mt_keyword.display_flg; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN mt_keyword.display_flg IS 'キーワード表示フラグ';


--
-- Name: mt_search_purpose; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_search_purpose (
    search_purpose_cd smallint NOT NULL,
    search_purpose character varying(40)
);


ALTER TABLE public.mt_search_purpose OWNER TO jaotdbadmin;

--
-- Name: mt_seikatsu_edit_member; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_seikatsu_edit_member (
    member_id character varying(8) NOT NULL
);


ALTER TABLE public.mt_seikatsu_edit_member OWNER TO jaotdbadmin;

--
-- Name: mt_service; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_service (
    service_cd character varying(2) NOT NULL,
    service character varying(50)
);


ALTER TABLE public.mt_service OWNER TO jaotdbadmin;

--
-- Name: mt_speciali_field; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_speciali_field (
    speciali_field_cd smallint NOT NULL,
    speciali_field character varying(20)
);


ALTER TABLE public.mt_speciali_field OWNER TO jaotdbadmin;

--
-- Name: mt_stage; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_stage (
    stage_cd smallint NOT NULL,
    stage character varying(10)
);


ALTER TABLE public.mt_stage OWNER TO jaotdbadmin;

--
-- Name: mt_theme; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_theme (
    theme_cd smallint NOT NULL,
    theme_title character varying(20),
    theme text
);


ALTER TABLE public.mt_theme OWNER TO jaotdbadmin;

--
-- Name: mt_type; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE mt_type (
    type_no smallint NOT NULL,
    data_no smallint NOT NULL,
    data_name character varying(20),
    display_no smallint,
    occupational_display_no smallint
);


ALTER TABLE public.mt_type OWNER TO jaotdbadmin;

--
-- Name: COLUMN mt_type.display_no; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN mt_type.display_no IS '一般ユーザ表示順';


--
-- Name: COLUMN mt_type.occupational_display_no; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN mt_type.occupational_display_no IS '管理ユーザ表示順';


--
-- Name: t_case; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_case (
    input_no smallint NOT NULL,
    seq_no character varying(8),
    input_status smallint,
    withdrawal smallint,
    input_date date,
    member_id character varying(8),
    speciali_field_cd smallint,
    stage_cd smallint,
    title character varying(100),
    disease_main_cd character varying(4),
    disease_main_other character varying(20),
    disease_sub_cd character varying(4),
    disease_sub_other character varying(20),
    age smallint,
    age_month smallint,
    age_day smallint,
    age_flg smallint,
    sex smallint,
    period_day smallint,
    period_month smallint,
    period_year smallint,
    period_flg smallint,
    experience smallint,
    profession_other character varying(100),
    policy_other character varying(20),
    area_cd character varying(8),
    area_other character varying(20),
    authorization_cd character varying(4),
    authorization_other character varying(20),
    service_cd character varying(2),
    service_other character varying(20),
    syudan_other character varying(20),
    period_from date,
    period_to date,
    frequency character varying(100),
    frequency_min smallint,
    myrating smallint,
    keyword_1 smallint,
    keyword_2 smallint,
    keyword_3 smallint,
    keyword_other1 character varying(50),
    keyword_other2 character varying(50),
    keyword_other3 character varying(50),
    theme_cd smallint,
    purpose text,
    introduction text,
    evaluation text,
    policy text,
    plan text,
    passage text,
    result text,
    consideration text,
    case_flg smallint,
    case_name character varying(50),
    case_no character varying(10),
    image_flg smallint,
    mail_flg smallint,
    passage2 text,
    consideration2 text,
    authorization_cd_new character varying(4),
    open_flg smallint,
    back_input_no smallint,
    comp_date date,
    agreement character varying(50),
    finalprocess character varying(50),
    examines_flg smallint,
    case_type smallint DEFAULT (1)::smallint,
    archive_flg1 smallint,
    archive_flg2 smallint,
    archive_flg3 smallint,
    archive_flg4 smallint,
    disease_sub2_cd character varying(4),
    disease_sub2_other character varying(20),
    disease_sub3_cd character varying(4),
    disease_sub3_other character varying(20),
    agreement_img_date date,
    archive_flg5 smallint,
    archive_flg6 smallint,
    release_date date
);


ALTER TABLE public.t_case OWNER TO jaotdbadmin;

--
-- Name: COLUMN t_case.disease_sub2_cd; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case.disease_sub2_cd IS '疾患コード副2';


--
-- Name: COLUMN t_case.disease_sub2_other; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case.disease_sub2_other IS '疾患コード副2その他';


--
-- Name: COLUMN t_case.disease_sub3_cd; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case.disease_sub3_cd IS '疾患コード副3';


--
-- Name: COLUMN t_case.disease_sub3_other; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case.disease_sub3_other IS '疾患コード副3その他';


--
-- Name: COLUMN t_case.agreement_img_date; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case.agreement_img_date IS '同意書画像添付日付。nullは未送付。';


--
-- Name: COLUMN t_case.archive_flg5; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case.archive_flg5 IS '生活行為申し送り表存在フラグ';


--
-- Name: COLUMN t_case.archive_flg6; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case.archive_flg6 IS '事例概要図（S事例のみ）存在フラグ';


--
-- Name: COLUMN t_case.release_date; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case.release_date IS '公開日';


--
-- Name: t_e_result; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_e_result (
    input_no smallint NOT NULL,
    e_result smallint,
    judge_a smallint,
    judge_b1 smallint,
    judge_b2 smallint,
    b1_screening_criterion1 smallint,
    b1_screening_criterion2 smallint,
    b1_screening_criterion3 smallint,
    b1_screening_criterion4 smallint,
    b1_screening_criterion5 smallint,
    b1_screening_criterion6 smallint,
    b1_screening_criterion7 smallint,
    b1_screening_criterion8 smallint,
    b2_screening_criterion1 smallint,
    b2_screening_criterion2 smallint,
    b2_screening_criterion3 smallint,
    b2_screening_criterion4 smallint,
    b2_screening_criterion5 smallint,
    b2_screening_criterion6 smallint,
    b2_screening_criterion7 smallint,
    b2_screening_criterion8 smallint,
    a_screening_criterion1 smallint,
    a_screening_criterion2 smallint,
    a_screening_criterion3 smallint,
    a_screening_criterion4 smallint,
    a_screening_criterion5 smallint,
    a_screening_criterion6 smallint,
    a_screening_criterion7 smallint,
    a_screening_criterion8 smallint,
    a_comment text,
    gdate date,
    request_date date,
    send_date_b1 date,
    send_date_b2 date,
    send_date_a date,
    agreement_flg smallint,
    auto_mail_flg_b1 smallint,
    auto_mail_flg_b2 smallint,
    auto_mail_flg_a smallint,
    comment_open_flg smallint,
    b1_comment text,
    b2_comment text,
    b_comp_date date,
    sinsa_comp_flg smallint,
    b_comp_date_temp date,
    b1_start_date date,
    b2_start_date date,
    a_start_date date,
    judge_result smallint
);


ALTER TABLE public.t_e_result OWNER TO jaotdbadmin;

--
-- Name: COLUMN t_e_result.judge_result; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_e_result.judge_result IS '審査判定';


--
-- Name: q_sinsa_a; Type: VIEW; Schema: public; Owner: jaotdbadmin
--

CREATE VIEW q_sinsa_a AS
    SELECT t_e_result.judge_a AS judge, mt_judge.member_id FROM t_case, t_e_result, mt_judge WHERE (((t_case.input_no = t_e_result.input_no) AND (t_e_result.judge_a = mt_judge.judge_cd)) AND ((((t_case.input_status = 2) OR (t_case.input_status = 3)) OR (t_case.input_status = 4)) OR (t_case.input_status = 5))) GROUP BY t_e_result.judge_a, mt_judge.member_id;


ALTER TABLE public.q_sinsa_a OWNER TO jaotdbadmin;

--
-- Name: q_sinsa_b1; Type: VIEW; Schema: public; Owner: jaotdbadmin
--

CREATE VIEW q_sinsa_b1 AS
    SELECT t_e_result.judge_b1 AS judge, mt_judge.member_id FROM t_case, t_e_result, mt_judge WHERE (((t_case.input_no = t_e_result.input_no) AND (t_e_result.judge_b1 = mt_judge.judge_cd)) AND ((t_case.input_status = 2) OR (t_case.input_status = 4))) GROUP BY t_e_result.judge_b1, mt_judge.member_id;


ALTER TABLE public.q_sinsa_b1 OWNER TO jaotdbadmin;

--
-- Name: q_sinsa_b2; Type: VIEW; Schema: public; Owner: jaotdbadmin
--

CREATE VIEW q_sinsa_b2 AS
    SELECT t_e_result.judge_b2 AS judge, mt_judge.member_id FROM t_case, t_e_result, mt_judge WHERE (((t_case.input_no = t_e_result.input_no) AND (t_e_result.judge_b2 = mt_judge.judge_cd)) AND ((t_case.input_status = 2) OR (t_case.input_status = 3))) GROUP BY t_e_result.judge_b2, mt_judge.member_id;


ALTER TABLE public.q_sinsa_b2 OWNER TO jaotdbadmin;

--
-- Name: q_sinsa_union; Type: VIEW; Schema: public; Owner: jaotdbadmin
--

CREATE VIEW q_sinsa_union AS
    (SELECT q_sinsa_a.judge, q_sinsa_a.member_id FROM q_sinsa_a UNION SELECT q_sinsa_b1.judge, q_sinsa_b1.member_id FROM q_sinsa_b1) UNION SELECT q_sinsa_b2.judge, q_sinsa_b2.member_id FROM q_sinsa_b2;


ALTER TABLE public.q_sinsa_union OWNER TO jaotdbadmin;

--
-- Name: q_t_case; Type: VIEW; Schema: public; Owner: jaotdbadmin
--

CREATE VIEW q_t_case AS
    SELECT t_case.seq_no, replace(replace((t_case.title)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS title_rpl, t_case.open_flg, t_case.member_id, t_case.input_no, t_case.disease_main_cd, replace(replace((t_case.disease_main_other)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS disease_main_other_rpl, t_case.disease_sub_cd, t_case.disease_sub_other, replace(replace((t_case.disease_sub_other)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS disease_sub_other_rpl, t_case.stage_cd, t_case.age, t_case.age_flg, t_case.sex, replace(replace((t_case.policy_other)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS policy_other_rpl, t_case.area_cd, replace(replace((t_case.area_other)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS area_other_rpl, t_case.service_cd, replace(replace((t_case.service_other)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS service_other_rpl, replace(replace((t_case.syudan_other)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS syudan_other_rpl, t_case.period_from, t_case.period_to, replace(replace((t_case.frequency)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS frequency_rpl, t_case.keyword_1, t_case.keyword_2, t_case.keyword_3, replace(replace((t_case.keyword_other1)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS keyword_other1_rpl, replace(replace((t_case.keyword_other2)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS keyword_other2_rpl, replace(replace((t_case.keyword_other3)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS keyword_other3_rpl, t_case.theme_cd, t_case.finalprocess, t_case.speciali_field_cd, t_case.input_status, t_case.authorization_cd, t_case.authorization_cd_new, replace(replace((t_case.authorization_other)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS authorization_other_rpl FROM t_case;


ALTER TABLE public.q_t_case OWNER TO jaotdbadmin;

--
-- Name: t_case2; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_case2 (
    input_no smallint NOT NULL,
    member_id character varying(8),
    purpose text,
    introduction text,
    evaluation text,
    policy text,
    plan text,
    passage text,
    result text,
    consideration text,
    image_flg smallint,
    height smallint,
    width smallint,
    reference text,
    icf_1 smallint,
    icf_1_text character varying(30),
    icf_1_intervention smallint,
    icf_1_intervention_text character varying(30),
    icf_1_append_intervention smallint,
    icf_1_append_intervention_text character varying(30),
    icf_1_result smallint,
    icf_1_result_text character varying(30),
    icf_2 smallint,
    icf_2_text character varying(30),
    icf_2_intervention smallint,
    icf_2_intervention_text character varying(30),
    icf_2_append_intervention smallint,
    icf_2_append_intervention_text character varying(30),
    icf_2_result smallint,
    icf_2_result_text character varying(30),
    icf_3 smallint,
    icf_3_text character varying(30),
    icf_3_intervention smallint,
    icf_3_intervention_text character varying(30),
    icf_3_append_intervention smallint,
    icf_3_append_intervention_text character varying(30),
    icf_3_result smallint,
    icf_3_result_text character varying(30),
    icf_4 smallint,
    icf_4_text character varying(30),
    icf_4_intervention smallint,
    icf_4_intervention_text character varying(30),
    icf_4_append_intervention smallint,
    icf_4_append_intervention_text character varying(30),
    icf_4_result smallint,
    icf_4_result_text character varying(30),
    extra_icf_1 smallint,
    extra_icf_1_text character varying(30),
    extra_icf_1_intervention smallint,
    extra_icf_1_intervention_text character varying(30),
    extra_icf_1_result smallint,
    extra_icf_1_result_text character varying(30),
    extra_icf_2 smallint,
    extra_icf_2_text character varying(30),
    extra_icf_2_intervention smallint,
    extra_icf_2_intervention_text character varying(30),
    extra_icf_2_result smallint,
    extra_icf_2_result_text character varying(30),
    incidental_icf_1_result smallint,
    incidental_icf_1_result_text character varying(30),
    incidental_icf_2_result smallint,
    incidental_icf_2_result_text character varying(30)
);


ALTER TABLE public.t_case2 OWNER TO jaotdbadmin;

--
-- Name: COLUMN t_case2.icf_1; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_1 IS '生活機能１';


--
-- Name: COLUMN t_case2.icf_1_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_1_text IS '生活機能１内容';


--
-- Name: COLUMN t_case2.icf_1_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_1_intervention IS '生活機能１に対する介入';


--
-- Name: COLUMN t_case2.icf_1_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_1_intervention_text IS '生活機能１に対する介入内容';


--
-- Name: COLUMN t_case2.icf_1_append_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_1_append_intervention IS '生活機能１に対する追加介入';


--
-- Name: COLUMN t_case2.icf_1_append_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_1_append_intervention_text IS '生活機能１に対する追加介入内容';


--
-- Name: COLUMN t_case2.icf_1_result; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_1_result IS '生活機能１についての成果';


--
-- Name: COLUMN t_case2.icf_1_result_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_1_result_text IS '生活機能１についての成果内容';


--
-- Name: COLUMN t_case2.icf_2; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_2 IS '生活機能２';


--
-- Name: COLUMN t_case2.icf_2_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_2_text IS '生活機能２内容';


--
-- Name: COLUMN t_case2.icf_2_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_2_intervention IS '生活機能２に対する介入';


--
-- Name: COLUMN t_case2.icf_2_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_2_intervention_text IS '生活機能２に対する介入内容';


--
-- Name: COLUMN t_case2.icf_2_append_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_2_append_intervention IS '生活機能２に対する追加介入';


--
-- Name: COLUMN t_case2.icf_2_append_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_2_append_intervention_text IS '生活機能２に対する追加介入内容';


--
-- Name: COLUMN t_case2.icf_2_result; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_2_result IS '生活機能２についての成果';


--
-- Name: COLUMN t_case2.icf_2_result_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_2_result_text IS '生活機能２についての成果内容';


--
-- Name: COLUMN t_case2.icf_3; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_3 IS '生活機能３';


--
-- Name: COLUMN t_case2.icf_3_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_3_text IS '生活機能３内容';


--
-- Name: COLUMN t_case2.icf_3_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_3_intervention IS '生活機能３に対する介入';


--
-- Name: COLUMN t_case2.icf_3_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_3_intervention_text IS '生活機能３に対する介入内容';


--
-- Name: COLUMN t_case2.icf_3_append_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_3_append_intervention IS '生活機能３に対する追加介入';


--
-- Name: COLUMN t_case2.icf_3_append_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_3_append_intervention_text IS '生活機能３に対する追加介入内容';


--
-- Name: COLUMN t_case2.icf_3_result; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_3_result IS '生活機能３についての成果';


--
-- Name: COLUMN t_case2.icf_3_result_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_3_result_text IS '生活機能３についての成果内容';


--
-- Name: COLUMN t_case2.icf_4; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_4 IS '生活機能４';


--
-- Name: COLUMN t_case2.icf_4_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_4_text IS '生活機能４内容';


--
-- Name: COLUMN t_case2.icf_4_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_4_intervention IS '生活機能４に対する介入';


--
-- Name: COLUMN t_case2.icf_4_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_4_intervention_text IS '生活機能４に対する介入内容';


--
-- Name: COLUMN t_case2.icf_4_append_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_4_append_intervention IS '生活機能４に対する追加介入';


--
-- Name: COLUMN t_case2.icf_4_append_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_4_append_intervention_text IS '生活機能４に対する追加介入内容';


--
-- Name: COLUMN t_case2.icf_4_result; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_4_result IS '生活機能４についての成果';


--
-- Name: COLUMN t_case2.icf_4_result_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.icf_4_result_text IS '生活機能４についての成果内容';


--
-- Name: COLUMN t_case2.extra_icf_1; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_1 IS '追加した生活機能１';


--
-- Name: COLUMN t_case2.extra_icf_1_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_1_text IS '追加した生活機能１内容';


--
-- Name: COLUMN t_case2.extra_icf_1_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_1_intervention IS '追加した生活機能１に対する介入';


--
-- Name: COLUMN t_case2.extra_icf_1_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_1_intervention_text IS '追加した生活機能１に対する介入内容';


--
-- Name: COLUMN t_case2.extra_icf_1_result; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_1_result IS '追加した生活機能１についての成果';


--
-- Name: COLUMN t_case2.extra_icf_1_result_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_1_result_text IS '追加した生活機能１についての成果内容';


--
-- Name: COLUMN t_case2.extra_icf_2; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_2 IS '追加した生活機能２';


--
-- Name: COLUMN t_case2.extra_icf_2_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_2_text IS '追加した生活機能２内容';


--
-- Name: COLUMN t_case2.extra_icf_2_intervention; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_2_intervention IS '追加した生活機能２に対する介入';


--
-- Name: COLUMN t_case2.extra_icf_2_intervention_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_2_intervention_text IS '追加した生活機能２に対する介入内容';


--
-- Name: COLUMN t_case2.extra_icf_2_result; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_2_result IS '追加した生活機能２についての成果';


--
-- Name: COLUMN t_case2.extra_icf_2_result_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.extra_icf_2_result_text IS '追加した生活機能２についての成果内容';


--
-- Name: COLUMN t_case2.incidental_icf_1_result; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.incidental_icf_1_result IS '付随した成果１';


--
-- Name: COLUMN t_case2.incidental_icf_1_result_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.incidental_icf_1_result_text IS '付随した成果内容１';


--
-- Name: COLUMN t_case2.incidental_icf_2_result; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.incidental_icf_2_result IS '付随した成果２';


--
-- Name: COLUMN t_case2.incidental_icf_2_result_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_case2.incidental_icf_2_result_text IS '付随した成果内容２';


--
-- Name: q_t_case2; Type: VIEW; Schema: public; Owner: jaotdbadmin
--

CREATE VIEW q_t_case2 AS
    SELECT t_case2.input_no, t_case2.member_id, replace(replace(t_case2.purpose, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS purpose_rpl, replace(replace(t_case2.introduction, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS introduction_rpl, replace(replace(t_case2.evaluation, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS evaluation_rpl, replace(replace(t_case2.policy, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS policy_rpl, replace(replace(t_case2.plan, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS plan_rpl, replace(replace(t_case2.passage, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS passage_rpl, replace(replace(t_case2.result, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS result_rpl, replace(replace(t_case2.consideration, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS consideration_rpl, t_case2.image_flg, t_case2.height, t_case2.width FROM t_case2;


ALTER TABLE public.q_t_case2 OWNER TO jaotdbadmin;

--
-- Name: t_evaluation_sonota; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_evaluation_sonota (
    seq integer NOT NULL,
    input_no smallint,
    umu_chk smallint,
    evaluation_no smallint,
    evaluation_subno smallint,
    start_time smallint,
    end_time smallint,
    evaluation_title character varying(50),
    unit character varying(5)
);


ALTER TABLE public.t_evaluation_sonota OWNER TO jaotdbadmin;

--
-- Name: q_t_evaluation_sonota; Type: VIEW; Schema: public; Owner: jaotdbadmin
--

CREATE VIEW q_t_evaluation_sonota AS
    SELECT t_evaluation_sonota.seq, t_evaluation_sonota.input_no, t_evaluation_sonota.umu_chk, t_evaluation_sonota.evaluation_no, t_evaluation_sonota.evaluation_subno, t_evaluation_sonota.start_time, t_evaluation_sonota.end_time, replace(replace((t_evaluation_sonota.evaluation_title)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS evaluation_title_rpl, replace(replace((t_evaluation_sonota.unit)::text, '〜'::text, '★波★'::text), '−'::text, '★棒★'::text) AS unit_rpl FROM t_evaluation_sonota;


ALTER TABLE public.q_t_evaluation_sonota OWNER TO jaotdbadmin;

--
-- Name: q_test; Type: VIEW; Schema: public; Owner: pguser
--

CREATE VIEW q_test AS
    SELECT q_t_case.seq_no, q_t_case.title_rpl, q_t_case.open_flg, q_t_case.member_id, q_t_case.input_no, q_t_case.disease_main_cd, q_t_case.disease_main_other_rpl, q_t_case.disease_sub_cd, q_t_case.disease_sub_other_rpl, q_t_case.stage_cd, q_t_case.age, q_t_case.age_flg, q_t_case.sex, q_t_case.policy_other_rpl, q_t_case.area_cd, q_t_case.area_other_rpl, q_t_case.service_cd, q_t_case.service_other_rpl, q_t_case.syudan_other_rpl, q_t_case.period_from, q_t_case.period_to, q_t_case.frequency_rpl, q_t_case.keyword_1, q_t_case.keyword_2, q_t_case.keyword_3, q_t_case.keyword_other1_rpl, q_t_case.keyword_other2_rpl, q_t_case.keyword_other3_rpl, q_t_case.theme_cd, q_t_case2.purpose_rpl, q_t_case2.introduction_rpl, q_t_case2.evaluation_rpl, q_t_case2.policy_rpl, q_t_case2.plan_rpl, q_t_case2.passage_rpl, q_t_case2.result_rpl, q_t_case2.consideration_rpl, q_t_case2.image_flg, q_t_case.authorization_cd, q_t_case.authorization_cd_new, q_t_case.authorization_other_rpl, q_t_case.finalprocess, q_t_case.input_status, q_t_case.speciali_field_cd FROM q_t_case, q_t_case2 WHERE (q_t_case.input_no = q_t_case2.input_no);


ALTER TABLE public.q_test OWNER TO pguser;

--
-- Name: t_caseinfo; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_caseinfo (
    seq integer NOT NULL,
    input_no character varying(14),
    master_code integer
);


ALTER TABLE public.t_caseinfo OWNER TO jaotdbadmin;

--
-- Name: t_e_result_oukagai; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_e_result_oukagai (
    input_no smallint NOT NULL,
    joutai smallint,
    judge_a smallint,
    judge_b1 smallint,
    judge_b2 smallint,
    update date,
    agree_date_a date,
    agree_date_b1 date,
    agree_date_b2 date,
    comp_date date,
    check_a text,
    check_b1 text,
    check_b2 text,
    agreement_flg smallint,
    agree_mail_date_a date,
    agree_mail_date_b1 date,
    agree_mail_date_b2 date,
    agree_tokusoku_date_a date,
    agree_tokusoku_date_b1 date,
    agree_tokusoku_date_b2 date
);


ALTER TABLE public.t_e_result_oukagai OWNER TO jaotdbadmin;

--
-- Name: t_e_result_oukagai_back; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_e_result_oukagai_back (
    input_no smallint,
    judge_no smallint,
    judge_type character varying(2),
    input_date date,
    input_comment text
);


ALTER TABLE public.t_e_result_oukagai_back OWNER TO jaotdbadmin;

--
-- Name: t_evaluation; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_evaluation (
    seq integer NOT NULL,
    input_no smallint,
    umu_chk smallint,
    evaluation_no smallint,
    evaluation_subno smallint,
    start_time smallint,
    end_time smallint,
    unit character varying(5)
);


ALTER TABLE public.t_evaluation OWNER TO jaotdbadmin;

--
-- Name: t_evaluation_t; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_evaluation_t (
    seq integer NOT NULL,
    input_no smallint,
    umu_chk smallint,
    evaluation_no smallint,
    evaluation_subno smallint,
    start_time smallint,
    end_time smallint
);


ALTER TABLE public.t_evaluation_t OWNER TO jaotdbadmin;

--
-- Name: t_icf; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_icf (
    seq integer NOT NULL,
    input_no smallint NOT NULL,
    icf_type icf_type_enum NOT NULL,
    group_no smallint NOT NULL,
    icf_text character varying(200),
    functioning smallint DEFAULT 0 NOT NULL,
    activities smallint DEFAULT 0 NOT NULL,
    participation smallint DEFAULT 0 NOT NULL,
    environment smallint DEFAULT 0 NOT NULL,
    personal smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.t_icf OWNER TO jaotdbadmin;

--
-- Name: TABLE t_icf; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON TABLE t_icf IS 'ICF分類実データテーブル';


--
-- Name: COLUMN t_icf.input_no; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_icf.input_no IS '関連づく事例受付番号';


--
-- Name: COLUMN t_icf.icf_type; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_icf.icf_type IS 'ICF弁別子';


--
-- Name: COLUMN t_icf.group_no; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_icf.group_no IS 'ICFグループ番号';


--
-- Name: COLUMN t_icf.icf_text; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_icf.icf_text IS '内容';


--
-- Name: COLUMN t_icf.functioning; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_icf.functioning IS '機能';


--
-- Name: COLUMN t_icf.activities; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_icf.activities IS '活動';


--
-- Name: COLUMN t_icf.participation; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_icf.participation IS '参加';


--
-- Name: COLUMN t_icf.environment; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_icf.environment IS '環境';


--
-- Name: COLUMN t_icf.personal; Type: COMMENT; Schema: public; Owner: jaotdbadmin
--

COMMENT ON COLUMN t_icf.personal IS '個人';


--
-- Name: t_icf_seq_seq; Type: SEQUENCE; Schema: public; Owner: jaotdbadmin
--

CREATE SEQUENCE t_icf_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_icf_seq_seq OWNER TO jaotdbadmin;

--
-- Name: t_icf_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jaotdbadmin
--

ALTER SEQUENCE t_icf_seq_seq OWNED BY t_icf.seq;


--
-- Name: t_login_miss; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_login_miss (
    kainno character varying(32),
    password character varying(32),
    input_date timestamp without time zone,
    ip_address character varying(15),
    browser_name character varying(300),
    referer_path text,
    end_flg smallint
);


ALTER TABLE public.t_login_miss OWNER TO jaotdbadmin;

--
-- Name: t_md5text; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_md5text (
    input_no integer NOT NULL,
    judge smallint NOT NULL,
    md5_text character varying(254)
);


ALTER TABLE public.t_md5text OWNER TO jaotdbadmin;

--
-- Name: t_mtdlp_id_seq; Type: SEQUENCE; Schema: public; Owner: jaotdbadmin
--

CREATE SEQUENCE t_mtdlp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_mtdlp_id_seq OWNER TO jaotdbadmin;

--
-- Name: t_mtdlp; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_mtdlp (
    id integer DEFAULT nextval('t_mtdlp_id_seq'::regclass) NOT NULL,
    input_no smallint,
    jury_id smallint,
    total smallint,
    judge smallint,
    rate_0_0 smallint,
    rate_0_1 smallint,
    rate_1_0 smallint,
    rate_1_1 smallint,
    rate_1_2 smallint,
    rate_2_0 smallint,
    rate_2_1 smallint,
    rate_2_2 smallint,
    rate_2_3 smallint,
    rate_2_4 smallint,
    rate_2_5 smallint,
    rate_2_6 smallint,
    rate_2_7 smallint,
    rate_2_8 smallint,
    rate_2_9 smallint,
    rate_3_0 smallint,
    rate_3_1 smallint,
    rate_3_2 smallint,
    rate_4_0 smallint,
    rate_4_1 smallint,
    rate_4_2 smallint,
    rate_5_0 smallint,
    rate_5_1 smallint,
    rate_5_2 smallint,
    rate_5_3 smallint,
    rate_5_4 smallint,
    rate_5_5 smallint,
    rate_6_0 smallint,
    rate_6_2 smallint,
    rate_7_0 smallint,
    rate_7_1 smallint,
    rate_7_2 smallint,
    rate_7_3 smallint,
    result_0 smallint,
    result_1 smallint,
    result_2 smallint,
    result_3 smallint,
    result_4 smallint,
    result_5 smallint,
    result_6 smallint,
    result_7 smallint,
    rate_6_1 smallint,
    jury_division text
);


ALTER TABLE public.t_mtdlp OWNER TO jaotdbadmin;

--
-- Name: t_search_purpose; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_search_purpose (
    seq integer NOT NULL,
    search_purpose_cd smallint,
    details_memo text
);


ALTER TABLE public.t_search_purpose OWNER TO jaotdbadmin;

--
-- Name: t_speciali_field; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_speciali_field (
    judge_cd smallint NOT NULL,
    speciali_field_cd smallint NOT NULL
);


ALTER TABLE public.t_speciali_field OWNER TO jaotdbadmin;

--
-- Name: t_yubin_tmp; Type: TABLE; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE TABLE t_yubin_tmp (
    zititai_no character varying(7),
    yubin_no_old character varying(5),
    yubin_no character varying(7),
    kana1 character varying(200),
    kana2 character varying(200),
    kana3 character varying(200),
    jusyo1 character varying(200),
    jusyo2 character varying(200),
    jusyo3 character varying(200),
    flg1 smallint,
    flg2 smallint,
    flg3 smallint,
    flg4 smallint,
    flg5 smallint,
    flg6 smallint,
    flg7 smallint
);


ALTER TABLE public.t_yubin_tmp OWNER TO jaotdbadmin;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jaotdbadmin
--

ALTER TABLE ONLY mt_case_kugiri ALTER COLUMN id SET DEFAULT nextval('mt_case_kugiri_id_seq'::regclass);


--
-- Name: seq; Type: DEFAULT; Schema: public; Owner: jaotdbadmin
--

ALTER TABLE ONLY t_icf ALTER COLUMN seq SET DEFAULT nextval('t_icf_seq_seq'::regclass);


--
-- Name: active_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY active_sessions
    ADD CONSTRAINT active_sessions_pkey PRIMARY KEY (sid, name);


--
-- Name: active_sessions_split_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY active_sessions_split
    ADD CONSTRAINT active_sessions_split_pkey PRIMARY KEY (ct_name, ct_sid, ct_pos);


--
-- Name: auth_user_md5_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY auth_user_md5
    ADD CONSTRAINT auth_user_md5_pkey PRIMARY KEY (user_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (user_id);


--
-- Name: mt_authorization_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_authorization
    ADD CONSTRAINT mt_authorization_pkey PRIMARY KEY (authorization_cd);


--
-- Name: mt_case_kugiri_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_case_kugiri
    ADD CONSTRAINT mt_case_kugiri_pkey PRIMARY KEY (id);


--
-- Name: mt_disease_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_disease
    ADD CONSTRAINT mt_disease_pkey PRIMARY KEY (disease_cd);


--
-- Name: mt_evaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_evaluation
    ADD CONSTRAINT mt_evaluation_pkey PRIMARY KEY (evaluation_no, evaluation_subno);


--
-- Name: mt_info_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_info
    ADD CONSTRAINT mt_info_pkey PRIMARY KEY (seq);


--
-- Name: mt_judge_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_judge
    ADD CONSTRAINT mt_judge_pkey PRIMARY KEY (judge_cd);


--
-- Name: mt_keyword_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_keyword
    ADD CONSTRAINT mt_keyword_pkey PRIMARY KEY (keyword_cd);


--
-- Name: mt_search_purpose_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_search_purpose
    ADD CONSTRAINT mt_search_purpose_pkey PRIMARY KEY (search_purpose_cd);


--
-- Name: mt_seikatsu_edit_member_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_seikatsu_edit_member
    ADD CONSTRAINT mt_seikatsu_edit_member_pkey PRIMARY KEY (member_id);


--
-- Name: mt_service_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_service
    ADD CONSTRAINT mt_service_pkey PRIMARY KEY (service_cd);


--
-- Name: mt_speciali_field_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_speciali_field
    ADD CONSTRAINT mt_speciali_field_pkey PRIMARY KEY (speciali_field_cd);


--
-- Name: mt_stage_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_stage
    ADD CONSTRAINT mt_stage_pkey PRIMARY KEY (stage_cd);


--
-- Name: mt_theme_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_theme
    ADD CONSTRAINT mt_theme_pkey PRIMARY KEY (theme_cd);


--
-- Name: mt_type_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY mt_type
    ADD CONSTRAINT mt_type_pkey PRIMARY KEY (type_no, data_no);


--
-- Name: t_case2_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_case2
    ADD CONSTRAINT t_case2_pkey PRIMARY KEY (input_no);


--
-- Name: t_case_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_case
    ADD CONSTRAINT t_case_pkey PRIMARY KEY (input_no);


--
-- Name: t_caseinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_caseinfo
    ADD CONSTRAINT t_caseinfo_pkey PRIMARY KEY (seq);


--
-- Name: t_e_result_oukagai_id; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_e_result_oukagai
    ADD CONSTRAINT t_e_result_oukagai_id PRIMARY KEY (input_no);


--
-- Name: t_e_result_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_e_result
    ADD CONSTRAINT t_e_result_pkey PRIMARY KEY (input_no);


--
-- Name: t_evaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_evaluation
    ADD CONSTRAINT t_evaluation_pkey PRIMARY KEY (seq);


--
-- Name: t_evaluation_sonota_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_evaluation_sonota
    ADD CONSTRAINT t_evaluation_sonota_pkey PRIMARY KEY (seq);


--
-- Name: t_evaluation_t_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_evaluation_t
    ADD CONSTRAINT t_evaluation_t_pkey PRIMARY KEY (seq);


--
-- Name: t_icf_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_icf
    ADD CONSTRAINT t_icf_pkey PRIMARY KEY (seq);


--
-- Name: t_search_purpose_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_search_purpose
    ADD CONSTRAINT t_search_purpose_pkey PRIMARY KEY (seq);


--
-- Name: t_speciali_field_pkey; Type: CONSTRAINT; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

ALTER TABLE ONLY t_speciali_field
    ADD CONSTRAINT t_speciali_field_pkey PRIMARY KEY (judge_cd, speciali_field_cd);


--
-- Name: id; Type: INDEX; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE UNIQUE INDEX id ON t_mtdlp USING btree (id);


--
-- Name: idx_input_no_t_case; Type: INDEX; Schema: public; Owner: jaotdbadmin; Tablespace: 
--

CREATE UNIQUE INDEX idx_input_no_t_case ON t_case USING btree (input_no);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: active_sessions; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE active_sessions FROM PUBLIC;
REVOKE ALL ON TABLE active_sessions FROM jaotdbadmin;
GRANT ALL ON TABLE active_sessions TO jaotdbadmin;


--
-- Name: active_tokens; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE active_tokens FROM PUBLIC;
REVOKE ALL ON TABLE active_tokens FROM jaotdbadmin;
GRANT ALL ON TABLE active_tokens TO jaotdbadmin;


--
-- Name: auth_user; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE auth_user FROM PUBLIC;
REVOKE ALL ON TABLE auth_user FROM jaotdbadmin;
GRANT ALL ON TABLE auth_user TO jaotdbadmin;


--
-- Name: auth_user_md5; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE auth_user_md5 FROM PUBLIC;
REVOKE ALL ON TABLE auth_user_md5 FROM jaotdbadmin;
GRANT ALL ON TABLE auth_user_md5 TO jaotdbadmin;


--
-- Name: mt_evaluation; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_evaluation FROM PUBLIC;
REVOKE ALL ON TABLE mt_evaluation FROM jaotdbadmin;
GRANT ALL ON TABLE mt_evaluation TO jaotdbadmin;


--
-- Name: e_n_c; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE e_n_c FROM PUBLIC;
REVOKE ALL ON TABLE e_n_c FROM jaotdbadmin;
GRANT ALL ON TABLE e_n_c TO jaotdbadmin;


--
-- Name: mojicode; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mojicode FROM PUBLIC;
REVOKE ALL ON TABLE mojicode FROM jaotdbadmin;
GRANT ALL ON TABLE mojicode TO jaotdbadmin;


--
-- Name: mt_authorization; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_authorization FROM PUBLIC;
REVOKE ALL ON TABLE mt_authorization FROM jaotdbadmin;
GRANT ALL ON TABLE mt_authorization TO jaotdbadmin;


--
-- Name: mt_disease; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_disease FROM PUBLIC;
REVOKE ALL ON TABLE mt_disease FROM jaotdbadmin;
GRANT ALL ON TABLE mt_disease TO jaotdbadmin;


--
-- Name: mt_info; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_info FROM PUBLIC;
REVOKE ALL ON TABLE mt_info FROM jaotdbadmin;
GRANT ALL ON TABLE mt_info TO jaotdbadmin;


--
-- Name: mt_judge; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_judge FROM PUBLIC;
REVOKE ALL ON TABLE mt_judge FROM jaotdbadmin;
GRANT ALL ON TABLE mt_judge TO jaotdbadmin;


--
-- Name: mt_keyword; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_keyword FROM PUBLIC;
REVOKE ALL ON TABLE mt_keyword FROM jaotdbadmin;
GRANT ALL ON TABLE mt_keyword TO jaotdbadmin;


--
-- Name: mt_search_purpose; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_search_purpose FROM PUBLIC;
REVOKE ALL ON TABLE mt_search_purpose FROM jaotdbadmin;
GRANT ALL ON TABLE mt_search_purpose TO jaotdbadmin;


--
-- Name: mt_service; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_service FROM PUBLIC;
REVOKE ALL ON TABLE mt_service FROM jaotdbadmin;
GRANT ALL ON TABLE mt_service TO jaotdbadmin;


--
-- Name: mt_speciali_field; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_speciali_field FROM PUBLIC;
REVOKE ALL ON TABLE mt_speciali_field FROM jaotdbadmin;
GRANT ALL ON TABLE mt_speciali_field TO jaotdbadmin;


--
-- Name: mt_stage; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_stage FROM PUBLIC;
REVOKE ALL ON TABLE mt_stage FROM jaotdbadmin;
GRANT ALL ON TABLE mt_stage TO jaotdbadmin;


--
-- Name: mt_theme; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_theme FROM PUBLIC;
REVOKE ALL ON TABLE mt_theme FROM jaotdbadmin;
GRANT ALL ON TABLE mt_theme TO jaotdbadmin;


--
-- Name: mt_type; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE mt_type FROM PUBLIC;
REVOKE ALL ON TABLE mt_type FROM jaotdbadmin;
GRANT ALL ON TABLE mt_type TO jaotdbadmin;


--
-- Name: t_case; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_case FROM PUBLIC;
REVOKE ALL ON TABLE t_case FROM jaotdbadmin;
GRANT ALL ON TABLE t_case TO jaotdbadmin;


--
-- Name: t_e_result; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_e_result FROM PUBLIC;
REVOKE ALL ON TABLE t_e_result FROM jaotdbadmin;
GRANT ALL ON TABLE t_e_result TO jaotdbadmin;


--
-- Name: t_case2; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_case2 FROM PUBLIC;
REVOKE ALL ON TABLE t_case2 FROM jaotdbadmin;
GRANT ALL ON TABLE t_case2 TO jaotdbadmin;


--
-- Name: t_evaluation_sonota; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_evaluation_sonota FROM PUBLIC;
REVOKE ALL ON TABLE t_evaluation_sonota FROM jaotdbadmin;
GRANT ALL ON TABLE t_evaluation_sonota TO jaotdbadmin;


--
-- Name: t_caseinfo; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_caseinfo FROM PUBLIC;
REVOKE ALL ON TABLE t_caseinfo FROM jaotdbadmin;
GRANT ALL ON TABLE t_caseinfo TO jaotdbadmin;


--
-- Name: t_evaluation; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_evaluation FROM PUBLIC;
REVOKE ALL ON TABLE t_evaluation FROM jaotdbadmin;
GRANT ALL ON TABLE t_evaluation TO jaotdbadmin;


--
-- Name: t_evaluation_t; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_evaluation_t FROM PUBLIC;
REVOKE ALL ON TABLE t_evaluation_t FROM jaotdbadmin;
GRANT ALL ON TABLE t_evaluation_t TO jaotdbadmin;


--
-- Name: t_login_miss; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_login_miss FROM PUBLIC;
REVOKE ALL ON TABLE t_login_miss FROM jaotdbadmin;
GRANT ALL ON TABLE t_login_miss TO jaotdbadmin;


--
-- Name: t_search_purpose; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_search_purpose FROM PUBLIC;
REVOKE ALL ON TABLE t_search_purpose FROM jaotdbadmin;
GRANT ALL ON TABLE t_search_purpose TO jaotdbadmin;


--
-- Name: t_speciali_field; Type: ACL; Schema: public; Owner: jaotdbadmin
--

REVOKE ALL ON TABLE t_speciali_field FROM PUBLIC;
REVOKE ALL ON TABLE t_speciali_field FROM jaotdbadmin;
GRANT ALL ON TABLE t_speciali_field TO jaotdbadmin;


--
-- PostgreSQL database dump complete
--

\connect jizen

SET default_transaction_read_only = off;

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
-- Name: jizen; Type: COMMENT; Schema: -; Owner: pguser
--

COMMENT ON DATABASE jizen IS '学会事前登録システム';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE active_sessions (
    sid character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    val text,
    changed character varying(32) NOT NULL
);


ALTER TABLE public.active_sessions OWNER TO jizen_local;

--
-- Name: active_tokens; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE active_tokens (
    token_id character varying(32),
    auth_user character varying(32),
    browser_name text,
    ip_address character varying(15),
    create_time character varying(12)
);


ALTER TABLE public.active_tokens OWNER TO jizen_local;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE auth_user (
    user_id integer NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(200),
    perms character varying(32)
);


ALTER TABLE public.auth_user OWNER TO jizen_local;

--
-- Name: jizen_seq; Type: SEQUENCE; Schema: public; Owner: jizen_local
--

CREATE SEQUENCE jizen_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.jizen_seq OWNER TO jizen_local;

--
-- Name: t_shinsei_old; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_shinsei_old (
    login_id character varying(8) NOT NULL,
    kaiin_no integer NOT NULL,
    simei character varying(50),
    furigana character varying(50),
    mail_address character varying(200),
    shisetu_name character varying(200),
    shisetu_null boolean,
    renrakusaki smallint,
    tdfk character varying(10),
    jusyo character varying(200),
    tel character varying(15),
    fax character varying(15)
);


ALTER TABLE public.t_shinsei_old OWNER TO jizen_local;

--
-- Name: q_shinsei_fix; Type: VIEW; Schema: public; Owner: jizen_local
--

CREATE VIEW q_shinsei_fix AS
    SELECT auth_user.user_id, auth_user.username, auth_user.password, t_shinsei.kaiin_no, auth_user.mail_address AS au_mail_address, t_shinsei.simei, t_shinsei.furigana, t_shinsei.mail_address AS ts_mail_address, t_shinsei.shisetu_name, t_shinsei.shisetu_null, t_shinsei.renrakusaki, t_shinsei.jusyo, t_shinsei.tel FROM auth_user, t_shinsei_old t_shinsei WHERE ((auth_user.username)::text = (t_shinsei.login_id)::text);


ALTER TABLE public.q_shinsei_fix OWNER TO jizen_local;

--
-- Name: t_johou; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_johou (
    seq smallint,
    simekiri_nyuukin date,
    simekiri_touroku date,
    gakkaimei character varying(200),
    kouza character varying(200),
    itaku_mail character varying(200) NOT NULL,
    itaku_tel character varying(15) NOT NULL,
    itaku_url character varying(200) NOT NULL,
    syoumeisyo_soufu date NOT NULL,
    gakkai_seikyu integer NOT NULL,
    reception_seikyu integer NOT NULL
);


ALTER TABLE public.t_johou OWNER TO jizen_local;

--
-- Name: t_kari; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_kari (
    kari_kaiin_no integer,
    furigana character varying(50),
    touroku_date timestamp without time zone,
    simei character varying(50)
);


ALTER TABLE public.t_kari OWNER TO jizen_local;

--
-- Name: t_kyoukai_kaihi; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_kyoukai_kaihi (
    kaiin_no integer,
    flg boolean,
    furigana character varying(20)
);


ALTER TABLE public.t_kyoukai_kaihi OWNER TO jizen_local;

--
-- Name: t_log; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_log (
    seq bigint NOT NULL,
    kaiin_no character varying(10),
    user_agent text,
    user_agent_s character varying(20),
    login_date character varying(14)
);


ALTER TABLE public.t_log OWNER TO jizen_local;

--
-- Name: t_log_seq_seq; Type: SEQUENCE; Schema: public; Owner: jizen_local
--

CREATE SEQUENCE t_log_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_log_seq_seq OWNER TO jizen_local;

--
-- Name: t_log_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jizen_local
--

ALTER SEQUENCE t_log_seq_seq OWNED BY t_log.seq;


--
-- Name: t_nyukin; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_nyukin (
    kaiin_no integer NOT NULL,
    nyukin_flg boolean,
    simekiri_date date,
    kakunin_date date
);


ALTER TABLE public.t_nyukin OWNER TO jizen_local;

--
-- Name: t_paymentdata; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_paymentdata (
    shopid character varying(13),
    shoppass character varying(10),
    accessid character varying(32),
    accesspass character varying(32),
    orderid character varying(27),
    status character varying(13),
    jobcd character varying(7),
    amount character varying(10),
    tax character varying(10),
    currency character varying(3),
    forward character varying(7),
    method character varying(1),
    paytimes character varying(2),
    tranid character varying(28),
    approve character varying(7),
    trandate character varying(14),
    errcode character varying(3),
    errinfo character varying(9),
    paytype character varying(1),
    create_date timestamp without time zone
);


ALTER TABLE public.t_paymentdata OWNER TO jizen_local;

--
-- Name: t_shinsei; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_shinsei (
    seq integer DEFAULT nextval('jizen_seq'::regclass) NOT NULL,
    login_id character varying(8) NOT NULL,
    kaiin_no integer NOT NULL,
    simei character varying(50) NOT NULL,
    furigana character varying(50) NOT NULL,
    mail_address character varying(200) NOT NULL,
    shisetu_name character varying(200),
    shisetu_null boolean,
    renrakusaki smallint NOT NULL,
    tdfk smallint NOT NULL,
    jusyo character varying(200),
    tel character varying(15) NOT NULL,
    fax character varying(15),
    g_no smallint NOT NULL,
    kari_flg date,
    del_flg smallint,
    touroku_date timestamp without time zone NOT NULL,
    password character varying(32),
    mail_address_go character varying(200),
    taiki_flg boolean,
    shisetsu_flg boolean NOT NULL,
    reception_flg boolean NOT NULL,
    gakkai_seikyu integer NOT NULL,
    gakkai_nyukin integer NOT NULL,
    gakkai_nyukin_date date,
    reception_seikyu integer NOT NULL,
    reception_nyukin integer NOT NULL,
    reception_nyukin_date date,
    simekiri_date date,
    zip character(8),
    shiharai smallint,
    web_nyukin_date timestamp without time zone,
    kari_mail_date timestamp without time zone,
    touroku_mail_date timestamp without time zone,
    sankasyo_date date,
    daihyou_seq integer
);


ALTER TABLE public.t_shinsei OWNER TO jizen_local;

--
-- Name: COLUMN t_shinsei.shisetsu_flg; Type: COMMENT; Schema: public; Owner: jizen_local
--

COMMENT ON COLUMN t_shinsei.shisetsu_flg IS '施設から振込';


--
-- Name: COLUMN t_shinsei.zip; Type: COMMENT; Schema: public; Owner: jizen_local
--

COMMENT ON COLUMN t_shinsei.zip IS '郵便番号';


--
-- Name: COLUMN t_shinsei.shiharai; Type: COMMENT; Schema: public; Owner: jizen_local
--

COMMENT ON COLUMN t_shinsei.shiharai IS '支払方法';


--
-- Name: COLUMN t_shinsei.web_nyukin_date; Type: COMMENT; Schema: public; Owner: jizen_local
--

COMMENT ON COLUMN t_shinsei.web_nyukin_date IS 'Web支払完了メール送信日';


--
-- Name: COLUMN t_shinsei.kari_mail_date; Type: COMMENT; Schema: public; Owner: jizen_local
--

COMMENT ON COLUMN t_shinsei.kari_mail_date IS '仮登録メール送信日';


--
-- Name: COLUMN t_shinsei.touroku_mail_date; Type: COMMENT; Schema: public; Owner: jizen_local
--

COMMENT ON COLUMN t_shinsei.touroku_mail_date IS '本登録メール送信日';


--
-- Name: COLUMN t_shinsei.sankasyo_date; Type: COMMENT; Schema: public; Owner: jizen_local
--

COMMENT ON COLUMN t_shinsei.sankasyo_date IS '学会参加証発送日';


--
-- Name: COLUMN t_shinsei.daihyou_seq; Type: COMMENT; Schema: public; Owner: jizen_local
--

COMMENT ON COLUMN t_shinsei.daihyou_seq IS 'グループ代表者番号';


--
-- Name: t_torikeshi; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_torikeshi (
    kaiin_no integer,
    torikeshi_flg boolean
);


ALTER TABLE public.t_torikeshi OWNER TO jizen_local;

--
-- Name: t_torikeshi_login_id; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_torikeshi_login_id (
    user_id integer,
    username character varying(32)
);


ALTER TABLE public.t_torikeshi_login_id OWNER TO jizen_local;

--
-- Name: t_yubin; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_yubin (
    yubin_no character varying(7),
    jusyo1 character varying(200),
    jusyo2 character varying(200),
    jusyo3 character varying(200)
);


ALTER TABLE public.t_yubin OWNER TO jizen_local;

--
-- Name: t_yubin_tmp; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE t_yubin_tmp (
    zititai_no character varying(7),
    yubin_no_old character varying(5),
    yubin_no character varying(7),
    kana1 character varying(200),
    kana2 character varying(200),
    kana3 character varying(200),
    jusyo1 character varying(200),
    jusyo2 character varying(200),
    jusyo3 character varying(200),
    flg1 smallint,
    flg2 smallint,
    flg3 smallint,
    flg4 smallint,
    flg5 smallint,
    flg6 smallint
);


ALTER TABLE public.t_yubin_tmp OWNER TO jizen_local;

--
-- Name: tm_tdfk; Type: TABLE; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE TABLE tm_tdfk (
    tdfk_cd smallint,
    tdfk_name character varying(10)
);


ALTER TABLE public.tm_tdfk OWNER TO jizen_local;

--
-- Name: seq; Type: DEFAULT; Schema: public; Owner: jizen_local
--

ALTER TABLE ONLY t_log ALTER COLUMN seq SET DEFAULT nextval('t_log_seq_seq'::regclass);


--
-- Name: auth_user_idx; Type: INDEX; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE UNIQUE INDEX auth_user_idx ON auth_user USING btree (user_id);


--
-- Name: t_johou_idx; Type: INDEX; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE UNIQUE INDEX t_johou_idx ON t_johou USING btree (seq);


--
-- Name: t_kyoukai_kaihi_idx; Type: INDEX; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE UNIQUE INDEX t_kyoukai_kaihi_idx ON t_kyoukai_kaihi USING btree (kaiin_no);


--
-- Name: t_log_idx; Type: INDEX; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE UNIQUE INDEX t_log_idx ON t_log USING btree (seq);


--
-- Name: t_nyukin_idx; Type: INDEX; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE UNIQUE INDEX t_nyukin_idx ON t_nyukin USING btree (kaiin_no);


--
-- Name: t_shinsei_idx; Type: INDEX; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE UNIQUE INDEX t_shinsei_idx ON t_shinsei_old USING btree (login_id);


--
-- Name: t_shinsei_idx_2; Type: INDEX; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE UNIQUE INDEX t_shinsei_idx_2 ON t_shinsei USING btree (seq);


--
-- Name: t_shinsei_idx_login_id; Type: INDEX; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE UNIQUE INDEX t_shinsei_idx_login_id ON t_shinsei USING btree (login_id);


--
-- Name: t_torikeshi_login_id_idx; Type: INDEX; Schema: public; Owner: jizen_local; Tablespace: 
--

CREATE UNIQUE INDEX t_torikeshi_login_id_idx ON t_torikeshi_login_id USING btree (user_id);


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

\connect keijiban

SET default_transaction_read_only = off;

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
-- Name: keijiban; Type: COMMENT; Schema: -; Owner: pguser
--

COMMENT ON DATABASE keijiban IS '会員掲示板システム';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: keijiban_local; Tablespace: 
--

CREATE TABLE active_sessions (
    sid character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    val text,
    changed character varying(32) NOT NULL
);


ALTER TABLE public.active_sessions OWNER TO keijiban_local;

--
-- Name: active_tokens; Type: TABLE; Schema: public; Owner: keijiban_local; Tablespace: 
--

CREATE TABLE active_tokens (
    token_id character varying(32),
    auth_user character varying(32),
    browser_name character varying(300),
    ip_address character varying(15),
    create_time character varying(12)
);


ALTER TABLE public.active_tokens OWNER TO keijiban_local;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: keijiban_local; Tablespace: 
--

CREATE TABLE auth_user (
    user_id integer NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(64),
    perms character varying(255)
);


ALTER TABLE public.auth_user OWNER TO keijiban_local;

--
-- Name: mt_bbs; Type: TABLE; Schema: public; Owner: keijiban_local; Tablespace: 
--

CREATE TABLE mt_bbs (
    mseq_no smallint NOT NULL,
    mseq_no_e smallint NOT NULL,
    bbs_name character varying(200),
    request_section character varying(50),
    start_date date,
    end_date date,
    update_date timestamp without time zone
);


ALTER TABLE public.mt_bbs OWNER TO keijiban_local;

--
-- Name: t_authority; Type: TABLE; Schema: public; Owner: keijiban_local; Tablespace: 
--

CREATE TABLE t_authority (
    kaiinno integer NOT NULL,
    kengen1_sdate date,
    kengen1_edate date,
    kengen2_sdate date,
    kengen2_edate date,
    kengen3_sdate date,
    kengen3_edate date,
    kengen4_sdate date,
    kengen4_edate date,
    kengen5_sdate date,
    kengen5_edate date,
    kengen6_sdate date,
    kengen6_edate date,
    kengen7_sdate date,
    kengen7_edate date,
    kengen8_sdate date,
    kengen8_edate date,
    kengen9_sdate date,
    kengen9_edate date,
    kengen10_sdate date,
    kengen10_edate date,
    kengen11_sdate date,
    kengen11_edate date,
    kengen12_sdate date,
    kengen12_edate date,
    kengen13_sdate date,
    kengen13_edate date,
    kengen14_sdate date,
    kengen14_edate date,
    kengen15_sdate date,
    kengen15_edate date,
    kengen16_sdate date,
    kengen16_edate date,
    kengen17_sdate date,
    kengen17_edate date,
    kengen18_sdate date,
    kengen18_edate date,
    kengen19_sdate date,
    kengen19_edate date,
    kengen20_sdate date,
    kengen20_edate date,
    update_date timestamp without time zone
);


ALTER TABLE public.t_authority OWNER TO keijiban_local;

--
-- Name: t_bbs; Type: TABLE; Schema: public; Owner: keijiban_local; Tablespace: 
--

CREATE TABLE t_bbs (
    seq integer NOT NULL,
    mseq_no smallint NOT NULL,
    mseq_no_e smallint NOT NULL,
    details_no smallint NOT NULL,
    info_title character varying(200),
    info_honbun text,
    start_date date,
    end_date date,
    appending_word character varying(200),
    appending_e character varying(3),
    update_date timestamp without time zone,
    dell_flg smallint
);


ALTER TABLE public.t_bbs OWNER TO keijiban_local;

--
-- Name: t_login_miss; Type: TABLE; Schema: public; Owner: keijiban_local; Tablespace: 
--

CREATE TABLE t_login_miss (
    kainno character varying(32),
    password character varying(32),
    input_date timestamp without time zone,
    ip_address character varying(15),
    browser_name character varying(300),
    referer_path text,
    end_flg smallint
);


ALTER TABLE public.t_login_miss OWNER TO keijiban_local;

--
-- Name: active_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: keijiban_local; Tablespace: 
--

ALTER TABLE ONLY active_sessions
    ADD CONSTRAINT active_sessions_pkey PRIMARY KEY (sid, name);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: keijiban_local; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (user_id);


--
-- Name: mt_bbs_pkey; Type: CONSTRAINT; Schema: public; Owner: keijiban_local; Tablespace: 
--

ALTER TABLE ONLY mt_bbs
    ADD CONSTRAINT mt_bbs_pkey PRIMARY KEY (mseq_no, mseq_no_e);


--
-- Name: t_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: keijiban_local; Tablespace: 
--

ALTER TABLE ONLY t_authority
    ADD CONSTRAINT t_authority_pkey PRIMARY KEY (kaiinno);


--
-- Name: t_bbs_pkey; Type: CONSTRAINT; Schema: public; Owner: keijiban_local; Tablespace: 
--

ALTER TABLE ONLY t_bbs
    ADD CONSTRAINT t_bbs_pkey PRIMARY KEY (seq);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: active_sessions; Type: ACL; Schema: public; Owner: keijiban_local
--

REVOKE ALL ON TABLE active_sessions FROM PUBLIC;
REVOKE ALL ON TABLE active_sessions FROM keijiban_local;
GRANT ALL ON TABLE active_sessions TO keijiban_local;
GRANT ALL ON TABLE active_sessions TO keijiban_web;


--
-- Name: active_tokens; Type: ACL; Schema: public; Owner: keijiban_local
--

REVOKE ALL ON TABLE active_tokens FROM PUBLIC;
REVOKE ALL ON TABLE active_tokens FROM keijiban_local;
GRANT ALL ON TABLE active_tokens TO keijiban_local;
GRANT ALL ON TABLE active_tokens TO keijiban_web;


--
-- Name: auth_user; Type: ACL; Schema: public; Owner: keijiban_local
--

REVOKE ALL ON TABLE auth_user FROM PUBLIC;
REVOKE ALL ON TABLE auth_user FROM keijiban_local;
GRANT ALL ON TABLE auth_user TO keijiban_local;
GRANT ALL ON TABLE auth_user TO keijiban_web;


--
-- Name: mt_bbs; Type: ACL; Schema: public; Owner: keijiban_local
--

REVOKE ALL ON TABLE mt_bbs FROM PUBLIC;
REVOKE ALL ON TABLE mt_bbs FROM keijiban_local;
GRANT ALL ON TABLE mt_bbs TO keijiban_local;
GRANT SELECT ON TABLE mt_bbs TO keijiban_web;


--
-- Name: t_authority; Type: ACL; Schema: public; Owner: keijiban_local
--

REVOKE ALL ON TABLE t_authority FROM PUBLIC;
REVOKE ALL ON TABLE t_authority FROM keijiban_local;
GRANT ALL ON TABLE t_authority TO keijiban_local;
GRANT SELECT ON TABLE t_authority TO keijiban_web;


--
-- Name: t_bbs; Type: ACL; Schema: public; Owner: keijiban_local
--

REVOKE ALL ON TABLE t_bbs FROM PUBLIC;
REVOKE ALL ON TABLE t_bbs FROM keijiban_local;
GRANT ALL ON TABLE t_bbs TO keijiban_local;
GRANT SELECT ON TABLE t_bbs TO keijiban_web;


--
-- Name: t_login_miss; Type: ACL; Schema: public; Owner: keijiban_local
--

REVOKE ALL ON TABLE t_login_miss FROM PUBLIC;
REVOKE ALL ON TABLE t_login_miss FROM keijiban_local;
GRANT ALL ON TABLE t_login_miss TO keijiban_local;
GRANT ALL ON TABLE t_login_miss TO keijiban_web;


--
-- PostgreSQL database dump complete
--

\connect otwebdb_new

SET default_transaction_read_only = off;

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
-- Name: otwebdb_new; Type: COMMENT; Schema: -; Owner: pguser
--

COMMENT ON DATABASE otwebdb_new IS '会員システム';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE active_sessions (
    sid character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    val text,
    changed character varying(32) NOT NULL
);


ALTER TABLE public.active_sessions OWNER TO otwebdb_ad_new;

--
-- Name: active_tokens; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE active_tokens (
    token_id character varying(32),
    auth_user character varying(32),
    browser_name character varying(300),
    ip_address character varying(15),
    create_time character varying(12)
);


ALTER TABLE public.active_tokens OWNER TO otwebdb_ad_new;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE auth_user (
    user_id integer NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(64),
    perms character varying(255)
);


ALTER TABLE public.auth_user OWNER TO otwebdb_ad_new;

--
-- Name: t_control; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_control (
    seq integer NOT NULL,
    weblocal_update timestamp without time zone,
    localweb_update timestamp without time zone
);


ALTER TABLE public.t_control OWNER TO otwebdb_ad_new;

--
-- Name: t_hyousyou; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_hyousyou (
    seq integer,
    kaiinno integer,
    hyousyou character varying(50),
    hyousyou_nen smallint
);


ALTER TABLE public.t_hyousyou OWNER TO otwebdb_ad_new;

--
-- Name: t_kaihi; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_kaihi (
    seq integer NOT NULL,
    kaiinno integer,
    nendo smallint,
    kubun character varying(20),
    seikyugaku integer,
    nyuukingaku integer,
    zangaku integer,
    nyuukinbi character(10)
);


ALTER TABLE public.t_kaihi OWNER TO otwebdb_ad_new;

--
-- Name: t_kaiin; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_kaiin (
    kaiinno integer NOT NULL,
    name1 character varying(20),
    name2 character varying(20),
    furigana1 character varying(20),
    furigana2 character varying(20),
    nyuukaiymd character(10),
    kyuusei character varying(20),
    seibetu smallint,
    wfot character varying(12),
    hassoukubun smallint,
    age smallint,
    birthday date,
    zip character(8),
    address1 character varying(32),
    address2 character varying(32),
    address3 character varying(32),
    tel character varying(36),
    keitai character varying(36),
    kinmusakitel character varying(36),
    email character varying(50),
    kyoukaimail smallint,
    youseikou smallint,
    sikakusyutoku smallint,
    menkyono character varying(20),
    kenno character(2),
    zenninken character varying(6),
    sisetuno character varying(10),
    sisetunojyuu character varying(10),
    kinmujyouken character(2),
    sisetusuu smallint,
    syokusyumei character varying(40),
    syugyoumu character(2),
    sonota character varying(40),
    senmon_syu character(2),
    senmon_jyu character(2),
    sikkan_syu character(8),
    sikkan_jyu character(8),
    ryouiki_syu character(8),
    ninka_syu character(4),
    kaigo_syu character(2),
    webpass character varying(20),
    webflag boolean,
    kensikai character varying(10),
    sikaimail character varying(8),
    sikaihassou character varying(8),
    sikaisibu character varying(60),
    webupdate timestamp without time zone,
    kisoymd1 character(10),
    kisoymd2 character(10),
    kisoymd3 character(10),
    kisoymd4 character(10),
    kisoymd5 character(10),
    kyouikuymd character(10),
    kanriymd character(10),
    kenkyuuymd character(10),
    senmon1 character varying(50),
    senmonymd1 character(10),
    senmon2 character varying(50),
    senmonymd2 character(10),
    senmon3 character varying(50),
    senmonymd3 character(10),
    syoureiymd1 character(10),
    syoureiymd2 character(10),
    syoureiymd3 character(10),
    ninteino integer,
    ninteiymd1 character(10),
    ninteiymd2 character(10),
    ninteiymd3 character(10),
    ninteiymd4 character(10),
    ninteiymd5 character(10),
    ninteiymd6 character(10),
    ninteiymd7 character(10),
    ninteikaiji boolean,
    kanrenshikaku1 character(4),
    kanrenshikaku2 character(4),
    kanrenshikaku3 character(4),
    kanrenshikaku4 character(4),
    kanrenshikaku5 character(4),
    ninkabunrui character(4),
    jitaku_kenno character(2),
    shozoku_kenno character(2),
    kaiin_flg boolean,
    shougai_flg boolean,
    jichi_1 smallint,
    jichi_2 smallint,
    jichi_3 smallint,
    ninka_jyu character(4),
    gakui smallint,
    syougaisyajiritsu character(2),
    t_mokuteki character(2),
    t_nenrei smallint,
    t_niisu smallint,
    meiyo smallint,
    meiyo_nen reltime,
    jidoufukusihou character(2),
    jichi_4 smallint,
    jichi_5 smallint,
    jichi_6 smallint,
    jichi_6_input character varying(40),
    volunteer_kibou boolean
);


ALTER TABLE public.t_kaiin OWNER TO otwebdb_ad_new;

--
-- Name: t_kaiin_cnv; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_kaiin_cnv (
    kaiinno integer,
    sikkan_syu character(6),
    sikkan_jyu character(6),
    ninka_syu character(2)
);


ALTER TABLE public.t_kaiin_cnv OWNER TO otwebdb_ad_new;

--
-- Name: t_kaiin_old; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_kaiin_old (
    kaiinno integer NOT NULL,
    name1 character varying(20),
    name2 character varying(20),
    furigana1 character varying(20),
    furigana2 character varying(20),
    nyuukaiymd character(10),
    kyuusei character varying(20),
    seibetu smallint,
    wfot character varying(12),
    hassoukubun smallint,
    age smallint,
    birthday date,
    zip character(8),
    address1 character varying(32),
    address2 character varying(32),
    address3 character varying(32),
    tel character varying(36),
    keitai character varying(36),
    kinmusakitel character varying(36),
    email character varying(50),
    kyoukaimail smallint,
    youseikou smallint,
    sikakusyutoku smallint,
    menkyono character varying(20),
    kenno character(2),
    zenninken character varying(6),
    sisetuno character varying(10),
    sisetunojyuu character varying(10),
    kinmujyouken character(2),
    sisetusuu smallint,
    syokusyumei character varying(40),
    syugyoumu character(2),
    sonota character varying(40),
    senmon_syu character(2),
    senmon_jyu character(2),
    sikkan_syu character(4),
    sikkan_jyu character(4),
    ryouiki_syu character(8),
    ninka_syu character(2),
    kaigo_syu character(2),
    webpass character varying(20),
    webflag boolean,
    kensikai character varying(10),
    sikaimail character varying(8),
    sikaihassou character varying(8),
    sikaisibu character varying(60),
    webupdate timestamp without time zone,
    kisoymd1 character(10),
    kisoymd2 character(10),
    kisoymd3 character(10),
    kisoymd4 character(10),
    kisoymd5 character(10),
    kyouikuymd character(10),
    kanriymd character(10),
    kenkyuuymd character(10),
    senmon1 character varying(50),
    senmonymd1 character(10),
    senmon2 character varying(50),
    senmonymd2 character(10),
    senmon3 character varying(50),
    senmonymd3 character(10),
    syoureiymd1 character(10),
    syoureiymd2 character(10),
    syoureiymd3 character(10),
    ninteino integer,
    ninteiymd1 character(10),
    ninteiymd2 character(10),
    ninteiymd3 character(10),
    ninteiymd4 character(10),
    ninteiymd5 character(10),
    ninteiymd6 character(10),
    ninteiymd7 character(10),
    ninteikaiji boolean,
    kanrenshikaku1 character(4),
    kanrenshikaku2 character(4),
    kanrenshikaku3 character(4),
    kanrenshikaku4 character(4),
    kanrenshikaku5 character(4),
    ninkabunrui character(4),
    jitaku_kenno character(2),
    shozoku_kenno character(2),
    kaiin_flg boolean,
    shougai_flg boolean
);


ALTER TABLE public.t_kaiin_old OWNER TO otwebdb_ad_new;

--
-- Name: t_kaiin_wk; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_kaiin_wk (
    kaiinno integer
);


ALTER TABLE public.t_kaiin_wk OWNER TO otwebdb_ad_new;

--
-- Name: t_kyouiku; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_kyouiku (
    seq integer NOT NULL,
    kaiinno integer,
    kouzacd smallint,
    kouza character varying(256),
    jikansuu double precision,
    tanisuu double precision,
    nendo smallint
);


ALTER TABLE public.t_kyouiku OWNER TO otwebdb_ad_new;

--
-- Name: t_kyukai; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_kyukai (
    seq integer NOT NULL,
    kaiinno integer NOT NULL,
    kaisu smallint NOT NULL,
    kyukai_tetuduki smallint,
    kyukai_riyu smallint,
    fujuri_riyu smallint,
    kyukai_date_from date,
    kyukai_date_to date,
    torisage_tetuduki smallint,
    torisage_date date,
    torisage_riyu text,
    fukkai_date date,
    insatsu_date date
);


ALTER TABLE public.t_kyukai OWNER TO otwebdb_ad_new;

--
-- Name: t_lock_history; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_lock_history (
    kaiinno character varying(32),
    lock_date timestamp without time zone,
    lock_system character varying(30),
    end_flg smallint,
    kaiin_cnt smallint,
    jirei_cnt smallint,
    kenkyu_cnt smallint,
    bbs_cnt smallint,
    syogai_cnt smallint
);


ALTER TABLE public.t_lock_history OWNER TO otwebdb_ad_new;

--
-- Name: t_log; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_log (
    webupdate timestamp without time zone,
    kaiinno integer,
    name1 character varying(20),
    name2 character varying(20),
    seq integer,
    rewrite_flg smallint
);


ALTER TABLE public.t_log OWNER TO otwebdb_ad_new;

--
-- Name: t_login_miss; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_login_miss (
    kainno character varying(32),
    password character varying(32),
    input_date timestamp without time zone,
    ip_address character varying(15),
    browser_name character varying(300),
    referer_path text,
    end_flg smallint
);


ALTER TABLE public.t_login_miss OWNER TO otwebdb_ad_new;

--
-- Name: t_otpass; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_otpass (
    otpass character varying(20)
);


ALTER TABLE public.t_otpass OWNER TO otwebdb_ad_new;

--
-- Name: t_sikaijyoho; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_sikaijyoho (
    seq integer NOT NULL,
    kaiinno integer,
    kensikai character varying(10),
    nendo smallint,
    kubun character varying(20),
    seikyugaku integer,
    nyuukingaku integer,
    zangaku integer,
    nyuukinbi character(10)
);


ALTER TABLE public.t_sikaijyoho OWNER TO otwebdb_ad_new;

--
-- Name: t_sikaiyakuin; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_sikaiyakuin (
    seq integer NOT NULL,
    kaiinno integer,
    kensikai character varying(10),
    busyo character varying(120),
    yakusyoku character varying(80),
    ninyoufrom character(10),
    ninyouto character(10)
);


ALTER TABLE public.t_sikaiyakuin OWNER TO otwebdb_ad_new;

--
-- Name: t_yakuinrireki; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_yakuinrireki (
    seq integer NOT NULL,
    kaiinno integer,
    busyo character varying(120),
    yakusyoku character varying(80),
    ninyoufrom character(10),
    ninyouto character(10)
);


ALTER TABLE public.t_yakuinrireki OWNER TO otwebdb_ad_new;

--
-- Name: t_yubin; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_yubin (
    yubin_no character varying(7),
    jusyo1 character varying(200),
    jusyo2 character varying(200),
    jusyo3 character varying(200)
);


ALTER TABLE public.t_yubin OWNER TO otwebdb_ad_new;

--
-- Name: t_yubin_tmp; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE t_yubin_tmp (
    zititai_no character varying(7),
    yubin_no_old character varying(5),
    yubin_no character varying(7),
    kana1 character varying(200),
    kana2 character varying(200),
    kana3 character varying(200),
    jusyo1 character varying(200),
    jusyo2 character varying(200),
    jusyo3 character varying(200),
    flg1 smallint,
    flg2 smallint,
    flg3 smallint,
    flg4 smallint,
    flg5 smallint,
    flg6 smallint
);


ALTER TABLE public.t_yubin_tmp OWNER TO otwebdb_ad_new;

--
-- Name: tm_hassoukubun; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_hassoukubun (
    no smallint NOT NULL,
    naiyou character varying(8)
);


ALTER TABLE public.tm_hassoukubun OWNER TO otwebdb_ad_new;

--
-- Name: tm_jidoufukusihou; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_jidoufukusihou (
    no character(2) NOT NULL,
    naiyou character varying(50)
);


ALTER TABLE public.tm_jidoufukusihou OWNER TO otwebdb_ad_new;

--
-- Name: tm_kaigohoken; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_kaigohoken (
    no character(2) NOT NULL,
    naiyou character varying(60)
);


ALTER TABLE public.tm_kaigohoken OWNER TO otwebdb_ad_new;

--
-- Name: tm_kanrenshikaku; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_kanrenshikaku (
    no character(4) NOT NULL,
    naiyou character varying(30)
);


ALTER TABLE public.tm_kanrenshikaku OWNER TO otwebdb_ad_new;

--
-- Name: tm_kinmujyouken; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_kinmujyouken (
    no character(2) NOT NULL,
    naiyou character varying(60)
);


ALTER TABLE public.tm_kinmujyouken OWNER TO otwebdb_ad_new;

--
-- Name: tm_ninkabunrui; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_ninkabunrui (
    no character(4) NOT NULL,
    naiyou character varying(50)
);


ALTER TABLE public.tm_ninkabunrui OWNER TO otwebdb_ad_new;

--
-- Name: tm_ninkasisetu; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_ninkasisetu (
    no character(4) NOT NULL,
    naiyou character varying(60)
);


ALTER TABLE public.tm_ninkasisetu OWNER TO otwebdb_ad_new;

--
-- Name: tm_ninkasisetu_bak; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_ninkasisetu_bak (
    no character(2) NOT NULL,
    naiyou character varying(60)
);


ALTER TABLE public.tm_ninkasisetu_bak OWNER TO otwebdb_ad_new;

--
-- Name: tm_omonagyoumu; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_omonagyoumu (
    no character(2) NOT NULL,
    naiyou character varying(60)
);


ALTER TABLE public.tm_omonagyoumu OWNER TO otwebdb_ad_new;

--
-- Name: tm_ryouiki; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_ryouiki (
    no character varying(12) NOT NULL,
    naiyou character varying(50),
    sisetusyubetu character(2),
    sisetucyou character varying(32)
);


ALTER TABLE public.tm_ryouiki OWNER TO otwebdb_ad_new;

--
-- Name: tm_senmonbunya; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_senmonbunya (
    no character(2) NOT NULL,
    naiyou character varying(60)
);


ALTER TABLE public.tm_senmonbunya OWNER TO otwebdb_ad_new;

--
-- Name: tm_sisetumeibo; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_sisetumeibo (
    kenno character(2),
    youseikou smallint,
    siseturenban smallint,
    sisetuno character varying(10) NOT NULL,
    sisetuname1 character varying(64),
    sisetukana1 character varying(64),
    sisetuname2 character varying(64),
    sisetukana2 character varying(64),
    zip character(8),
    address1 character varying(64),
    address2 character varying(64),
    address3 character varying(64),
    tel character varying(36),
    kaisetusya character varying(60),
    fax character varying(36)
);


ALTER TABLE public.tm_sisetumeibo OWNER TO otwebdb_ad_new;

--
-- Name: tm_syougaisyajiritsu; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_syougaisyajiritsu (
    no character(2) NOT NULL,
    naiyou character varying(50)
);


ALTER TABLE public.tm_syougaisyajiritsu OWNER TO otwebdb_ad_new;

--
-- Name: tm_taisyosyazokusei; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_taisyosyazokusei (
    no character(2) NOT NULL,
    naiyou character varying(50)
);


ALTER TABLE public.tm_taisyosyazokusei OWNER TO otwebdb_ad_new;

--
-- Name: tm_taisyousikkan; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_taisyousikkan (
    no character(8) NOT NULL,
    naiyou character varying(80)
);


ALTER TABLE public.tm_taisyousikkan OWNER TO otwebdb_ad_new;

--
-- Name: tm_taisyousikkan_bak; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_taisyousikkan_bak (
    no character(4) NOT NULL,
    naiyou character varying(40)
);


ALTER TABLE public.tm_taisyousikkan_bak OWNER TO otwebdb_ad_new;

--
-- Name: tm_todoufuken; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_todoufuken (
    no character(2) NOT NULL,
    meisyou character varying(10)
);


ALTER TABLE public.tm_todoufuken OWNER TO otwebdb_ad_new;

--
-- Name: tm_youseikou; Type: TABLE; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE TABLE tm_youseikou (
    no smallint NOT NULL,
    naiyou character varying(60)
);


ALTER TABLE public.tm_youseikou OWNER TO otwebdb_ad_new;

--
-- Name: active_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY active_sessions
    ADD CONSTRAINT active_sessions_pkey PRIMARY KEY (sid, name);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (user_id);


--
-- Name: t_control_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY t_control
    ADD CONSTRAINT t_control_pkey PRIMARY KEY (seq);


--
-- Name: t_kaihi_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY t_kaihi
    ADD CONSTRAINT t_kaihi_pkey PRIMARY KEY (seq);


--
-- Name: t_kaiin_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY t_kaiin
    ADD CONSTRAINT t_kaiin_pkey PRIMARY KEY (kaiinno);


--
-- Name: t_kyouiku_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY t_kyouiku
    ADD CONSTRAINT t_kyouiku_pkey PRIMARY KEY (seq);


--
-- Name: t_kyukai_seq_key; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY t_kyukai
    ADD CONSTRAINT t_kyukai_seq_key UNIQUE (seq);


--
-- Name: t_sikaijyoho_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY t_sikaijyoho
    ADD CONSTRAINT t_sikaijyoho_pkey PRIMARY KEY (seq);


--
-- Name: t_sikaiyakuin_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY t_sikaiyakuin
    ADD CONSTRAINT t_sikaiyakuin_pkey PRIMARY KEY (seq);


--
-- Name: t_yakuinrireki_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY t_yakuinrireki
    ADD CONSTRAINT t_yakuinrireki_pkey PRIMARY KEY (seq);


--
-- Name: tm_hassoukubun_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_hassoukubun
    ADD CONSTRAINT tm_hassoukubun_pkey PRIMARY KEY (no);


--
-- Name: tm_kaigohoken_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_kaigohoken
    ADD CONSTRAINT tm_kaigohoken_pkey PRIMARY KEY (no);


--
-- Name: tm_kanrenshikaku_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_kanrenshikaku
    ADD CONSTRAINT tm_kanrenshikaku_pkey PRIMARY KEY (no);


--
-- Name: tm_kinmujyouken_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_kinmujyouken
    ADD CONSTRAINT tm_kinmujyouken_pkey PRIMARY KEY (no);


--
-- Name: tm_ninkabunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_ninkabunrui
    ADD CONSTRAINT tm_ninkabunrui_pkey PRIMARY KEY (no);


--
-- Name: tm_ninkasisetu_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_ninkasisetu
    ADD CONSTRAINT tm_ninkasisetu_pkey PRIMARY KEY (no);


--
-- Name: tm_omonagyoumu_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_omonagyoumu
    ADD CONSTRAINT tm_omonagyoumu_pkey PRIMARY KEY (no);


--
-- Name: tm_ryouiki_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_ryouiki
    ADD CONSTRAINT tm_ryouiki_pkey PRIMARY KEY (no);


--
-- Name: tm_senmonbunya_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_senmonbunya
    ADD CONSTRAINT tm_senmonbunya_pkey PRIMARY KEY (no);


--
-- Name: tm_sisetumeibo_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_sisetumeibo
    ADD CONSTRAINT tm_sisetumeibo_pkey PRIMARY KEY (sisetuno);


--
-- Name: tm_syougaisyajiritsu_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_syougaisyajiritsu
    ADD CONSTRAINT tm_syougaisyajiritsu_pkey PRIMARY KEY (no);


--
-- Name: tm_taisyosyazokusei_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_taisyosyazokusei
    ADD CONSTRAINT tm_taisyosyazokusei_pkey PRIMARY KEY (no);


--
-- Name: tm_taisyousikkan_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_taisyousikkan
    ADD CONSTRAINT tm_taisyousikkan_pkey PRIMARY KEY (no);


--
-- Name: tm_todoufuken_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_todoufuken
    ADD CONSTRAINT tm_todoufuken_pkey PRIMARY KEY (no);


--
-- Name: tm_youseikou_pkey; Type: CONSTRAINT; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

ALTER TABLE ONLY tm_youseikou
    ADD CONSTRAINT tm_youseikou_pkey PRIMARY KEY (no);


--
-- Name: idx_seq_t_log; Type: INDEX; Schema: public; Owner: otwebdb_ad_new; Tablespace: 
--

CREATE UNIQUE INDEX idx_seq_t_log ON t_log USING btree (seq);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: active_sessions; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE active_sessions FROM PUBLIC;
REVOKE ALL ON TABLE active_sessions FROM otwebdb_ad_new;
GRANT ALL ON TABLE active_sessions TO otwebdb_ad_new;


--
-- Name: active_tokens; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE active_tokens FROM PUBLIC;
REVOKE ALL ON TABLE active_tokens FROM otwebdb_ad_new;
GRANT ALL ON TABLE active_tokens TO otwebdb_ad_new;


--
-- Name: auth_user; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE auth_user FROM PUBLIC;
REVOKE ALL ON TABLE auth_user FROM otwebdb_ad_new;
GRANT ALL ON TABLE auth_user TO otwebdb_ad_new;


--
-- Name: t_control; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_control FROM PUBLIC;
REVOKE ALL ON TABLE t_control FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_control TO otwebdb_ad_new;


--
-- Name: t_hyousyou; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_hyousyou FROM PUBLIC;
REVOKE ALL ON TABLE t_hyousyou FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_hyousyou TO otwebdb_ad_new;


--
-- Name: t_kaihi; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_kaihi FROM PUBLIC;
REVOKE ALL ON TABLE t_kaihi FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_kaihi TO otwebdb_ad_new;


--
-- Name: t_kaiin; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_kaiin FROM PUBLIC;
REVOKE ALL ON TABLE t_kaiin FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_kaiin TO otwebdb_ad_new;


--
-- Name: t_kaiin_cnv; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_kaiin_cnv FROM PUBLIC;
REVOKE ALL ON TABLE t_kaiin_cnv FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_kaiin_cnv TO otwebdb_ad_new;


--
-- Name: t_kaiin_old; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_kaiin_old FROM PUBLIC;
REVOKE ALL ON TABLE t_kaiin_old FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_kaiin_old TO otwebdb_ad_new;


--
-- Name: t_kaiin_wk; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_kaiin_wk FROM PUBLIC;
REVOKE ALL ON TABLE t_kaiin_wk FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_kaiin_wk TO otwebdb_ad_new;


--
-- Name: t_kyouiku; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_kyouiku FROM PUBLIC;
REVOKE ALL ON TABLE t_kyouiku FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_kyouiku TO otwebdb_ad_new;


--
-- Name: t_lock_history; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_lock_history FROM PUBLIC;
REVOKE ALL ON TABLE t_lock_history FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_lock_history TO otwebdb_ad_new;


--
-- Name: t_log; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_log FROM PUBLIC;
REVOKE ALL ON TABLE t_log FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_log TO otwebdb_ad_new;


--
-- Name: t_login_miss; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_login_miss FROM PUBLIC;
REVOKE ALL ON TABLE t_login_miss FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_login_miss TO otwebdb_ad_new;


--
-- Name: t_otpass; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_otpass FROM PUBLIC;
REVOKE ALL ON TABLE t_otpass FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_otpass TO otwebdb_ad_new;


--
-- Name: t_sikaijyoho; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_sikaijyoho FROM PUBLIC;
REVOKE ALL ON TABLE t_sikaijyoho FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_sikaijyoho TO otwebdb_ad_new;


--
-- Name: t_sikaiyakuin; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_sikaiyakuin FROM PUBLIC;
REVOKE ALL ON TABLE t_sikaiyakuin FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_sikaiyakuin TO otwebdb_ad_new;


--
-- Name: t_yakuinrireki; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE t_yakuinrireki FROM PUBLIC;
REVOKE ALL ON TABLE t_yakuinrireki FROM otwebdb_ad_new;
GRANT ALL ON TABLE t_yakuinrireki TO otwebdb_ad_new;


--
-- Name: tm_hassoukubun; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_hassoukubun FROM PUBLIC;
REVOKE ALL ON TABLE tm_hassoukubun FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_hassoukubun TO otwebdb_ad_new;


--
-- Name: tm_jidoufukusihou; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_jidoufukusihou FROM PUBLIC;
REVOKE ALL ON TABLE tm_jidoufukusihou FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_jidoufukusihou TO otwebdb_ad_new;


--
-- Name: tm_kaigohoken; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_kaigohoken FROM PUBLIC;
REVOKE ALL ON TABLE tm_kaigohoken FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_kaigohoken TO otwebdb_ad_new;


--
-- Name: tm_kanrenshikaku; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_kanrenshikaku FROM PUBLIC;
REVOKE ALL ON TABLE tm_kanrenshikaku FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_kanrenshikaku TO otwebdb_ad_new;


--
-- Name: tm_kinmujyouken; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_kinmujyouken FROM PUBLIC;
REVOKE ALL ON TABLE tm_kinmujyouken FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_kinmujyouken TO otwebdb_ad_new;


--
-- Name: tm_ninkabunrui; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_ninkabunrui FROM PUBLIC;
REVOKE ALL ON TABLE tm_ninkabunrui FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_ninkabunrui TO otwebdb_ad_new;


--
-- Name: tm_ninkasisetu; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_ninkasisetu FROM PUBLIC;
REVOKE ALL ON TABLE tm_ninkasisetu FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_ninkasisetu TO otwebdb_ad_new;


--
-- Name: tm_ninkasisetu_bak; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_ninkasisetu_bak FROM PUBLIC;
REVOKE ALL ON TABLE tm_ninkasisetu_bak FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_ninkasisetu_bak TO otwebdb_ad_new;


--
-- Name: tm_omonagyoumu; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_omonagyoumu FROM PUBLIC;
REVOKE ALL ON TABLE tm_omonagyoumu FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_omonagyoumu TO otwebdb_ad_new;


--
-- Name: tm_ryouiki; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_ryouiki FROM PUBLIC;
REVOKE ALL ON TABLE tm_ryouiki FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_ryouiki TO otwebdb_ad_new;


--
-- Name: tm_senmonbunya; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_senmonbunya FROM PUBLIC;
REVOKE ALL ON TABLE tm_senmonbunya FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_senmonbunya TO otwebdb_ad_new;


--
-- Name: tm_sisetumeibo; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_sisetumeibo FROM PUBLIC;
REVOKE ALL ON TABLE tm_sisetumeibo FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_sisetumeibo TO otwebdb_ad_new;


--
-- Name: tm_syougaisyajiritsu; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_syougaisyajiritsu FROM PUBLIC;
REVOKE ALL ON TABLE tm_syougaisyajiritsu FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_syougaisyajiritsu TO otwebdb_ad_new;


--
-- Name: tm_taisyosyazokusei; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_taisyosyazokusei FROM PUBLIC;
REVOKE ALL ON TABLE tm_taisyosyazokusei FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_taisyosyazokusei TO otwebdb_ad_new;


--
-- Name: tm_taisyousikkan; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_taisyousikkan FROM PUBLIC;
REVOKE ALL ON TABLE tm_taisyousikkan FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_taisyousikkan TO otwebdb_ad_new;


--
-- Name: tm_taisyousikkan_bak; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_taisyousikkan_bak FROM PUBLIC;
REVOKE ALL ON TABLE tm_taisyousikkan_bak FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_taisyousikkan_bak TO otwebdb_ad_new;


--
-- Name: tm_todoufuken; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_todoufuken FROM PUBLIC;
REVOKE ALL ON TABLE tm_todoufuken FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_todoufuken TO otwebdb_ad_new;


--
-- Name: tm_youseikou; Type: ACL; Schema: public; Owner: otwebdb_ad_new
--

REVOKE ALL ON TABLE tm_youseikou FROM PUBLIC;
REVOKE ALL ON TABLE tm_youseikou FROM otwebdb_ad_new;
GRANT ALL ON TABLE tm_youseikou TO otwebdb_ad_new;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect syogai

SET default_transaction_read_only = off;

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
-- Name: syogai; Type: COMMENT; Schema: -; Owner: pguser
--

COMMENT ON DATABASE syogai IS '生涯教育システム';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE active_sessions (
    sid character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    val text,
    changed character varying(32) NOT NULL
);


ALTER TABLE public.active_sessions OWNER TO syogai_web;

--
-- Name: active_tokens; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE active_tokens (
    token_id character varying(32),
    auth_user character varying(32),
    browser_name character varying(300),
    ip_address character varying(15),
    create_time character varying(12)
);


ALTER TABLE public.active_tokens OWNER TO syogai_web;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE auth_user (
    user_id integer NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(64),
    perms character varying(255)
);


ALTER TABLE public.auth_user OWNER TO syogai_web;

--
-- Name: ct_免除理由; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE "ct_免除理由" (
    "番号" integer NOT NULL,
    "内容" character varying(200)
);


ALTER TABLE public."ct_免除理由" OWNER TO syogai_web;

--
-- Name: ct_発表先区分; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE "ct_発表先区分" (
    "番号" integer NOT NULL,
    "内容" character varying(100)
);


ALTER TABLE public."ct_発表先区分" OWNER TO syogai_web;

--
-- Name: mojicode; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE mojicode (
    sjis character varying(4) NOT NULL,
    euc character varying(4),
    utf_8 character varying(6),
    utf_16 character varying(6),
    view_moji character varying(4)
);


ALTER TABLE public.mojicode OWNER TO syogai_web;

--
-- Name: mt_bunrui; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE mt_bunrui (
    syubetsu_cd integer NOT NULL,
    senmon_cd integer NOT NULL,
    bunrui_cd integer NOT NULL,
    bunrui_name character varying(100)
);


ALTER TABLE public.mt_bunrui OWNER TO syogai_web;

--
-- Name: mt_jyokyo; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE mt_jyokyo (
    jyokyo_type smallint NOT NULL,
    jyokyo_name character varying(20)
);


ALTER TABLE public.mt_jyokyo OWNER TO syogai_web;

--
-- Name: mt_kengen; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE mt_kengen (
    kaiinno integer NOT NULL
);


ALTER TABLE public.mt_kengen OWNER TO syogai_web;

--
-- Name: mt_rinsyou; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE mt_rinsyou (
    kaiinno integer NOT NULL,
    syokyu integer,
    syokyuymd date,
    syokyuymd2 date,
    cyuukyuu integer,
    cyuukyuuymd date,
    cyuukyuuymd2 date,
    jyoukyuu integer,
    jyoukyuuymd date,
    jyoukyuuymd2 date,
    rinsyou_nintei_no integer,
    rinsyou_ninteiymd date,
    bikou character varying(100),
    ptotstymd date,
    nintei_ot integer
);


ALTER TABLE public.mt_rinsyou OWNER TO syogai_web;

--
-- Name: mt_senmon; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE mt_senmon (
    senmon_cd integer NOT NULL,
    senmon_name character varying(100)
);


ALTER TABLE public.mt_senmon OWNER TO syogai_web;

--
-- Name: mt_syubetsu; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE mt_syubetsu (
    syubetsu_cd integer NOT NULL,
    syubetsu_name character varying(100)
);


ALTER TABLE public.mt_syubetsu OWNER TO syogai_web;

--
-- Name: mt_syusai; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE mt_syusai (
    syusai_cd integer NOT NULL,
    syusai_name character varying(100)
);


ALTER TABLE public.mt_syusai OWNER TO syogai_web;

--
-- Name: t_kensyu_kaiin; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_kensyu_kaiin (
    kaiinno integer NOT NULL,
    kiso_manryo_date date,
    nintei_bango integer,
    nintei_manryo_date date,
    fukushiyougu_nintei_date date,
    fukushiyougu_bango integer,
    ninchisyo_nintei_date date,
    ninchisyo_bango integer,
    tegeka_nintei_date date,
    tegeka_bango integer,
    tokubetsu_nintei_date date,
    tokubetsu_bango integer,
    kouji_nintei_date date,
    kouji_bango integer,
    seishin_nintei_date date,
    seishin_bango integer,
    sessyoku_nintei_date date,
    sessyoku_bango integer,
    kiso_biko text,
    nintei_kyouikuho_date date,
    nintei_kanriunei_date date,
    nintei_kenkyuho_date date,
    nintei_biko text,
    jirei_ronbun1_happyou integer,
    jirei_ronbun1_bikou character varying(100),
    jirei_ronbun1_sonota character varying(100),
    jirei_ronbun2_happyou integer,
    jirei_ronbun2_bikou character varying(100),
    jirei_ronbun2_sonota character varying(100),
    houmon_nintei_date date,
    houmon_bango integer
);


ALTER TABLE public.t_kensyu_kaiin OWNER TO syogai_web;

--
-- Name: t_kensyu_kaiin_org; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_kensyu_kaiin_org (
    kaiinno integer NOT NULL,
    kiso_manryo_date date,
    nintei_bango integer,
    nintei_manryo_date date,
    fukushiyougu_nintei_date date,
    fukushiyougu_bango integer,
    ninchisyo_nintei_date date,
    ninchisyo_bango integer,
    tegeka_nintei_date date,
    tegeka_bango integer,
    tokubetsu_nintei_date date,
    tokubetsu_bango integer,
    kouji_nintei_date date,
    kouji_bango integer,
    seishin_nintei_date date,
    seishin_bango integer,
    sessyoku_nintei_date date,
    sessyoku_bango integer,
    kiso_biko text,
    nintei_kyouikuho_date date,
    nintei_kanriunei_date date,
    nintei_kenkyuho_date date,
    nintei_biko text,
    jirei_ronbun1_happyou integer,
    jirei_ronbun1_bikou character varying(100),
    jirei_ronbun1_sonota character varying(100),
    jirei_ronbun2_happyou integer,
    jirei_ronbun2_bikou character varying(100),
    jirei_ronbun2_sonota character varying(100)
);


ALTER TABLE public.t_kensyu_kaiin_org OWNER TO syogai_web;

--
-- Name: q_kensyu_kaiin_del; Type: VIEW; Schema: public; Owner: syogai_web
--

CREATE VIEW q_kensyu_kaiin_del AS
    SELECT t_kensyu_kaiin_org.kaiinno FROM (t_kensyu_kaiin_org LEFT JOIN t_kensyu_kaiin ON ((t_kensyu_kaiin_org.kaiinno = t_kensyu_kaiin.kaiinno))) WHERE (t_kensyu_kaiin.kaiinno IS NULL) ORDER BY t_kensyu_kaiin_org.kaiinno;


ALTER TABLE public.q_kensyu_kaiin_del OWNER TO syogai_web;

--
-- Name: t_category_m; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_category_m (
    category_cd integer NOT NULL,
    category_name character varying(250),
    category_description character varying(200)
);


ALTER TABLE public.t_category_m OWNER TO syogai_web;

--
-- Name: t_jyokyo; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_jyokyo (
    kaiinno integer NOT NULL,
    jyokyo_now smallint
);


ALTER TABLE public.t_jyokyo OWNER TO syogai_web;

--
-- Name: t_kari; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_kari (
    kojin_no integer NOT NULL,
    kari_date timestamp without time zone DEFAULT now() NOT NULL,
    mail_para character varying(200) NOT NULL,
    oubo text NOT NULL,
    email character varying(100)
);


ALTER TABLE public.t_kari OWNER TO syogai_web;

--
-- Name: t_kensyu_m; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_kensyu_m (
    nendo smallint NOT NULL,
    kensyu_no character varying(6) NOT NULL,
    kaisuu smallint NOT NULL,
    ki smallint,
    kensyu_name character varying(200),
    category_name1 character varying(100),
    category_name2 character varying(100),
    kensyu_syurui smallint,
    mokuteki text,
    kaisai_shisetsu character varying(200),
    kaisai_schedule text,
    kaisai_days double precision,
    kaisai_time_from time without time zone,
    kaisai_time_to time without time zone,
    sanka_jouken text,
    suisen smallint,
    teiin smallint,
    moushikomi_method integer DEFAULT 0,
    uketsuke_date date,
    shimekiri_date date,
    syonichi_syuugou_place character varying(200),
    about_syukketsu character varying(200),
    fukusou character varying(200),
    i_u_flg smallint,
    update_date date,
    insert_date date,
    dl_file_name character varying(200),
    recommend_path character varying(10),
    koushi_disp_flg smallint,
    koushi_no_webdisp1 integer,
    koushi_no_webdisp2 integer,
    koushi_no_webdisp3 integer,
    koushi_no_webdisp4 integer,
    koushi_no_webdisp5 integer,
    koushi_no_webdisp6 integer,
    sonota text,
    jukou_charge integer,
    kaisai_shisetsu2 character varying(200),
    koushi_free text
);


ALTER TABLE public.t_kensyu_m OWNER TO syogai_web;

--
-- Name: t_kensyu_m_sougou; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_kensyu_m_sougou (
    nendo smallint NOT NULL,
    kensyu_no character varying(6) NOT NULL,
    kensyu_name_sougou character varying(200),
    mokuteki_sougou text,
    sanka_jouken_sougou text,
    teiin_1time smallint,
    kaisai_days_1time double precision,
    kaisuu_goukei smallint,
    kaisai_yotei_schedule text,
    i_u_flg smallint,
    update_date date,
    insert_date date,
    tantou_mail character varying(200),
    kaisai_yotei_schedule2 character varying(200),
    kaisai_yotei_schedule3 character varying(200),
    kaisai_yotei_schedule_time character varying(200),
    kaisai_yotei_schedule_time2 character varying(200),
    kaisai_yotei_schedule_time3 character varying(200),
    kamoku_jikanwari text
);


ALTER TABLE public.t_kensyu_m_sougou OWNER TO syogai_web;

--
-- Name: t_kensyu_rireki; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_kensyu_rireki (
    kaiinno integer,
    syubetsu_cd integer,
    kaisu integer,
    jyukou_date date,
    kensyu_cd integer,
    kouzamei character varying(100),
    nissu integer,
    point integer,
    syusaisya character varying(20),
    menjoriyu character varying(20),
    menjoriyu_bikou character varying(100),
    bangou integer,
    result integer,
    withdrawal integer,
    case_type integer
);


ALTER TABLE public.t_kensyu_rireki OWNER TO syogai_web;

--
-- Name: t_kensyu_rireki_org; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_kensyu_rireki_org (
    kaiinno integer,
    syubetsu_cd integer,
    kaisu integer,
    jyukou_date date,
    kensyu_cd integer,
    kouzamei character varying(100),
    nissu integer,
    point integer,
    syusaisya character varying(20),
    menjoriyu character varying(20),
    menjoriyu_bikou character varying(100)
);


ALTER TABLE public.t_kensyu_rireki_org OWNER TO syogai_web;

--
-- Name: t_koushi_m; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_koushi_m (
    koushi_no integer NOT NULL,
    koushi_name character varying(64),
    koushi_furigana character varying(64),
    seibetsu smallint,
    kinmusaki_name character varying(100),
    kinmusaki_gakubu_busyo character varying(100),
    yakusyoku_name character varying(100),
    kinmu_place character varying(200),
    insert_date date
);


ALTER TABLE public.t_koushi_m OWNER TO syogai_web;

--
-- Name: t_kyoukai_kaihi; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_kyoukai_kaihi (
    kaiin_no integer,
    flg boolean
);


ALTER TABLE public.t_kyoukai_kaihi OWNER TO syogai_web;

--
-- Name: t_lock_history; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_lock_history (
    kojin_no character varying(32),
    lock_date timestamp without time zone,
    end_flg smallint
);


ALTER TABLE public.t_lock_history OWNER TO syogai_web;

--
-- Name: t_login_miss; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_login_miss (
    kainno character varying(32),
    password character varying(32),
    input_date timestamp without time zone,
    ip_address character varying(15),
    browser_name character varying(300),
    referer_path text,
    end_flg smallint
);


ALTER TABLE public.t_login_miss OWNER TO syogai_web;

--
-- Name: t_mobile_flg; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_mobile_flg (
    kojin_no character varying(10) NOT NULL,
    flg smallint
);


ALTER TABLE public.t_mobile_flg OWNER TO syogai_web;

--
-- Name: t_mtdlp_rireki; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_mtdlp_rireki (
    kaiinno integer NOT NULL,
    kiso_1 date,
    kiso_2 date,
    kiso_hakkoubi date,
    kiso_no integer,
    zirei_date date,
    zissen_hakkoubi date,
    zissen_no integer,
    shidou_hakkoubi date,
    shidou_no integer
);


ALTER TABLE public.t_mtdlp_rireki OWNER TO syogai_web;

--
-- Name: TABLE t_mtdlp_rireki; Type: COMMENT; Schema: public; Owner: syogai_web
--

COMMENT ON TABLE t_mtdlp_rireki IS 'MTDLP情報格納テーブル';


--
-- Name: COLUMN t_mtdlp_rireki.kiso_1; Type: COMMENT; Schema: public; Owner: syogai_web
--

COMMENT ON COLUMN t_mtdlp_rireki.kiso_1 IS '基礎研修1';


--
-- Name: COLUMN t_mtdlp_rireki.kiso_2; Type: COMMENT; Schema: public; Owner: syogai_web
--

COMMENT ON COLUMN t_mtdlp_rireki.kiso_2 IS '基礎研修2';


--
-- Name: COLUMN t_mtdlp_rireki.kiso_hakkoubi; Type: COMMENT; Schema: public; Owner: syogai_web
--

COMMENT ON COLUMN t_mtdlp_rireki.kiso_hakkoubi IS '基礎研修修了証発行日';


--
-- Name: COLUMN t_mtdlp_rireki.kiso_no; Type: COMMENT; Schema: public; Owner: syogai_web
--

COMMENT ON COLUMN t_mtdlp_rireki.kiso_no IS '基礎研修修了証番号';


--
-- Name: COLUMN t_mtdlp_rireki.zirei_date; Type: COMMENT; Schema: public; Owner: syogai_web
--

COMMENT ON COLUMN t_mtdlp_rireki.zirei_date IS '事例発表日';


--
-- Name: COLUMN t_mtdlp_rireki.zissen_hakkoubi; Type: COMMENT; Schema: public; Owner: syogai_web
--

COMMENT ON COLUMN t_mtdlp_rireki.zissen_hakkoubi IS '実践者研修修了証発行日';


--
-- Name: COLUMN t_mtdlp_rireki.zissen_no; Type: COMMENT; Schema: public; Owner: syogai_web
--

COMMENT ON COLUMN t_mtdlp_rireki.zissen_no IS '実践者研修修了証番号';


--
-- Name: t_otoiawase_no_seq; Type: SEQUENCE; Schema: public; Owner: syogai_web
--

CREATE SEQUENCE t_otoiawase_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_otoiawase_no_seq OWNER TO syogai_web;

--
-- Name: t_oubo; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_oubo (
    nendo smallint NOT NULL,
    kensyu_no character varying(6) NOT NULL,
    kaisuu smallint NOT NULL,
    seiri_no smallint NOT NULL,
    moushikomi_method smallint DEFAULT 3,
    shisetsu_no integer,
    syuugyou_kbn smallint,
    tsuusan_kinmu_kikan_nen smallint,
    risyoku_kikan_nen smallint,
    syokusyu_cd smallint,
    yakusyoku_cd_genzai smallint,
    oubojoutai_flg smallint,
    more_reason smallint,
    suisenjou_uketori_flg smallint,
    suisen_jun smallint,
    suisen_reason text,
    kibou_jun smallint,
    result_print_flg smallint DEFAULT 2,
    i_u_flg smallint,
    update_date date,
    insert_date date,
    jitai_date date,
    shisetsu_no_kensyu integer,
    risyoku_kikan_nen_kensyu smallint,
    risyoku_kikan_tsuki_kensyu smallint,
    mailaddress character varying(200),
    syogai character varying(200),
    sentaku smallint,
    keiken smallint,
    kojin_no integer,
    browser_name text,
    nyukin_date date,
    souhu_date date
);


ALTER TABLE public.t_oubo OWNER TO syogai_web;

--
-- Name: t_rireki; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_rireki (
    bangou integer NOT NULL,
    kenno character varying(2),
    kaiinno integer,
    syubetsu_cd integer,
    kouzamei character varying(100),
    senmon_cd integer,
    bunrui_cd integer,
    jyukou_date date,
    nissu integer,
    syusai_cd integer,
    point integer,
    input_date timestamp without time zone,
    syori_date timestamp without time zone,
    file_name character varying(100),
    hanei smallint
);


ALTER TABLE public.t_rireki OWNER TO syogai_web;

--
-- Name: t_rireki_bangou_seq; Type: SEQUENCE; Schema: public; Owner: syogai_web
--

CREATE SEQUENCE t_rireki_bangou_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_rireki_bangou_seq OWNER TO syogai_web;

--
-- Name: t_rireki_bangou_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: syogai_web
--

ALTER SEQUENCE t_rireki_bangou_seq OWNED BY t_rireki.bangou;


--
-- Name: t_rireki_sub; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_rireki_sub (
    bangou integer NOT NULL,
    kaiinno integer NOT NULL,
    kaiin_name character varying(50),
    jyokyo smallint,
    jyuko_date date
);


ALTER TABLE public.t_rireki_sub OWNER TO syogai_web;

--
-- Name: COLUMN t_rireki_sub.jyuko_date; Type: COMMENT; Schema: public; Owner: syogai_web
--

COMMENT ON COLUMN t_rireki_sub.jyuko_date IS 'ファイル内の受講年月日を格納する';


--
-- Name: t_syozaichi_m; Type: TABLE; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE TABLE t_syozaichi_m (
    syozaichi_no smallint NOT NULL,
    syozaichi_name character varying(20),
    syozaichi_gyou smallint
);


ALTER TABLE public.t_syozaichi_m OWNER TO syogai_web;

--
-- Name: bangou; Type: DEFAULT; Schema: public; Owner: syogai_web
--

ALTER TABLE ONLY t_rireki ALTER COLUMN bangou SET DEFAULT nextval('t_rireki_bangou_seq'::regclass);


--
-- Name: active_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY active_sessions
    ADD CONSTRAINT active_sessions_pkey PRIMARY KEY (sid, name);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (user_id);


--
-- Name: mt_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY mt_bunrui
    ADD CONSTRAINT mt_bunrui_pkey PRIMARY KEY (syubetsu_cd, senmon_cd, bunrui_cd);


--
-- Name: mt_kengen_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY mt_kengen
    ADD CONSTRAINT mt_kengen_pkey PRIMARY KEY (kaiinno);


--
-- Name: mt_rinsyou_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY mt_rinsyou
    ADD CONSTRAINT mt_rinsyou_pkey PRIMARY KEY (kaiinno);


--
-- Name: mt_senmon_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY mt_senmon
    ADD CONSTRAINT mt_senmon_pkey PRIMARY KEY (senmon_cd);


--
-- Name: mt_syubetsu_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY mt_syubetsu
    ADD CONSTRAINT mt_syubetsu_pkey PRIMARY KEY (syubetsu_cd);


--
-- Name: mt_syusai_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY mt_syusai
    ADD CONSTRAINT mt_syusai_pkey PRIMARY KEY (syusai_cd);


--
-- Name: t_kari_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY t_kari
    ADD CONSTRAINT t_kari_pkey PRIMARY KEY (kojin_no, kari_date);


--
-- Name: t_kensyu_kaiin_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY t_kensyu_kaiin
    ADD CONSTRAINT t_kensyu_kaiin_pkey PRIMARY KEY (kaiinno);


--
-- Name: t_koushi_m_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY t_koushi_m
    ADD CONSTRAINT t_koushi_m_pkey PRIMARY KEY (koushi_no);


--
-- Name: t_rireki_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY t_rireki
    ADD CONSTRAINT t_rireki_pkey PRIMARY KEY (bangou);


--
-- Name: t_rireki_sub_pkey; Type: CONSTRAINT; Schema: public; Owner: syogai_web; Tablespace: 
--

ALTER TABLE ONLY t_rireki_sub
    ADD CONSTRAINT t_rireki_sub_pkey PRIMARY KEY (bangou, kaiinno);


--
-- Name: category_pkey; Type: INDEX; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE UNIQUE INDEX category_pkey ON t_category_m USING btree (category_cd);


--
-- Name: mt_jyokyo_pkey; Type: INDEX; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE UNIQUE INDEX mt_jyokyo_pkey ON mt_jyokyo USING btree (jyokyo_type);


--
-- Name: t_jyokyo_pkey; Type: INDEX; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE UNIQUE INDEX t_jyokyo_pkey ON t_jyokyo USING btree (kaiinno);


--
-- Name: t_kensyu_m_pkey; Type: INDEX; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE UNIQUE INDEX t_kensyu_m_pkey ON t_kensyu_m USING btree (nendo, kensyu_no, kaisuu);


--
-- Name: t_kensyu_m_sougou_pkey; Type: INDEX; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE UNIQUE INDEX t_kensyu_m_sougou_pkey ON t_kensyu_m_sougou USING btree (nendo, kensyu_no);


--
-- Name: t_kyoukai_kaihi_idx; Type: INDEX; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE UNIQUE INDEX t_kyoukai_kaihi_idx ON t_kyoukai_kaihi USING btree (kaiin_no);


--
-- Name: t_oubo_pkey; Type: INDEX; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE UNIQUE INDEX t_oubo_pkey ON t_oubo USING btree (nendo, kensyu_no, kaisuu, seiri_no);


--
-- Name: t_syozaichi_m_pkey; Type: INDEX; Schema: public; Owner: syogai_web; Tablespace: 
--

CREATE UNIQUE INDEX t_syozaichi_m_pkey ON t_syozaichi_m USING btree (syozaichi_no);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: active_sessions; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE active_sessions FROM PUBLIC;
REVOKE ALL ON TABLE active_sessions FROM syogai_web;
GRANT ALL ON TABLE active_sessions TO syogai_web;


--
-- Name: active_tokens; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE active_tokens FROM PUBLIC;
REVOKE ALL ON TABLE active_tokens FROM syogai_web;
GRANT ALL ON TABLE active_tokens TO syogai_web;


--
-- Name: auth_user; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE auth_user FROM PUBLIC;
REVOKE ALL ON TABLE auth_user FROM syogai_web;
GRANT ALL ON TABLE auth_user TO syogai_web;


--
-- Name: mojicode; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE mojicode FROM PUBLIC;
REVOKE ALL ON TABLE mojicode FROM syogai_web;
GRANT ALL ON TABLE mojicode TO syogai_web;


--
-- Name: mt_bunrui; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE mt_bunrui FROM PUBLIC;
REVOKE ALL ON TABLE mt_bunrui FROM syogai_web;
GRANT ALL ON TABLE mt_bunrui TO syogai_web;


--
-- Name: mt_kengen; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE mt_kengen FROM PUBLIC;
REVOKE ALL ON TABLE mt_kengen FROM syogai_web;
GRANT ALL ON TABLE mt_kengen TO syogai_web;


--
-- Name: mt_rinsyou; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE mt_rinsyou FROM PUBLIC;
REVOKE ALL ON TABLE mt_rinsyou FROM syogai_web;
GRANT ALL ON TABLE mt_rinsyou TO syogai_web;


--
-- Name: mt_senmon; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE mt_senmon FROM PUBLIC;
REVOKE ALL ON TABLE mt_senmon FROM syogai_web;
GRANT ALL ON TABLE mt_senmon TO syogai_web;


--
-- Name: mt_syubetsu; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE mt_syubetsu FROM PUBLIC;
REVOKE ALL ON TABLE mt_syubetsu FROM syogai_web;
GRANT ALL ON TABLE mt_syubetsu TO syogai_web;


--
-- Name: mt_syusai; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE mt_syusai FROM PUBLIC;
REVOKE ALL ON TABLE mt_syusai FROM syogai_web;
GRANT ALL ON TABLE mt_syusai TO syogai_web;


--
-- Name: t_kensyu_kaiin; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_kensyu_kaiin FROM PUBLIC;
REVOKE ALL ON TABLE t_kensyu_kaiin FROM syogai_web;
GRANT ALL ON TABLE t_kensyu_kaiin TO syogai_web;


--
-- Name: t_category_m; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_category_m FROM PUBLIC;
REVOKE ALL ON TABLE t_category_m FROM syogai_web;
GRANT ALL ON TABLE t_category_m TO syogai_web;


--
-- Name: t_kensyu_m; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_kensyu_m FROM PUBLIC;
REVOKE ALL ON TABLE t_kensyu_m FROM syogai_web;
GRANT ALL ON TABLE t_kensyu_m TO syogai_web;


--
-- Name: t_kensyu_m_sougou; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_kensyu_m_sougou FROM PUBLIC;
REVOKE ALL ON TABLE t_kensyu_m_sougou FROM syogai_web;
GRANT ALL ON TABLE t_kensyu_m_sougou TO syogai_web;


--
-- Name: t_kensyu_rireki; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_kensyu_rireki FROM PUBLIC;
REVOKE ALL ON TABLE t_kensyu_rireki FROM syogai_web;
GRANT ALL ON TABLE t_kensyu_rireki TO syogai_web;


--
-- Name: t_koushi_m; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_koushi_m FROM PUBLIC;
REVOKE ALL ON TABLE t_koushi_m FROM syogai_web;
GRANT ALL ON TABLE t_koushi_m TO syogai_web;
GRANT ALL ON TABLE t_koushi_m TO PUBLIC;


--
-- Name: t_lock_history; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_lock_history FROM PUBLIC;
REVOKE ALL ON TABLE t_lock_history FROM syogai_web;
GRANT ALL ON TABLE t_lock_history TO syogai_web;
GRANT ALL ON TABLE t_lock_history TO PUBLIC;


--
-- Name: t_login_miss; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_login_miss FROM PUBLIC;
REVOKE ALL ON TABLE t_login_miss FROM syogai_web;
GRANT ALL ON TABLE t_login_miss TO syogai_web;


--
-- Name: t_mobile_flg; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_mobile_flg FROM PUBLIC;
REVOKE ALL ON TABLE t_mobile_flg FROM syogai_web;
GRANT ALL ON TABLE t_mobile_flg TO syogai_web;


--
-- Name: t_otoiawase_no_seq; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON SEQUENCE t_otoiawase_no_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE t_otoiawase_no_seq FROM syogai_web;
GRANT ALL ON SEQUENCE t_otoiawase_no_seq TO syogai_web;


--
-- Name: t_oubo; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_oubo FROM PUBLIC;
REVOKE ALL ON TABLE t_oubo FROM syogai_web;
GRANT ALL ON TABLE t_oubo TO syogai_web;


--
-- Name: t_rireki; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_rireki FROM PUBLIC;
REVOKE ALL ON TABLE t_rireki FROM syogai_web;
GRANT ALL ON TABLE t_rireki TO syogai_web;


--
-- Name: t_rireki_sub; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_rireki_sub FROM PUBLIC;
REVOKE ALL ON TABLE t_rireki_sub FROM syogai_web;
GRANT ALL ON TABLE t_rireki_sub TO syogai_web;


--
-- Name: t_syozaichi_m; Type: ACL; Schema: public; Owner: syogai_web
--

REVOKE ALL ON TABLE t_syozaichi_m FROM PUBLIC;
REVOKE ALL ON TABLE t_syozaichi_m FROM syogai_web;
GRANT ALL ON TABLE t_syozaichi_m TO syogai_web;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

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
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template database';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE active_sessions (
    sid character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    val text,
    changed character varying(32) NOT NULL
);


ALTER TABLE public.active_sessions OWNER TO zenken_local;

--
-- Name: active_tokens; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE active_tokens (
    token_id character varying(32),
    auth_user character varying(32),
    browser_name text,
    ip_address character varying(15),
    create_time character varying(12)
);


ALTER TABLE public.active_tokens OWNER TO zenken_local;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE auth_user (
    user_id integer NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(200),
    perms character varying(32)
);


ALTER TABLE public.auth_user OWNER TO zenken_local;

--
-- Name: jizen_seq; Type: SEQUENCE; Schema: public; Owner: zenken_local
--

CREATE SEQUENCE jizen_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.jizen_seq OWNER TO zenken_local;

--
-- Name: t_shinsei_old; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_shinsei_old (
    login_id character varying(8) NOT NULL,
    kaiin_no integer NOT NULL,
    simei character varying(50),
    furigana character varying(50),
    mail_address character varying(200),
    shisetu_name character varying(200),
    shisetu_null boolean,
    renrakusaki smallint,
    tdfk character varying(10),
    jusyo character varying(200),
    tel character varying(15),
    fax character varying(15)
);


ALTER TABLE public.t_shinsei_old OWNER TO zenken_local;

--
-- Name: q_shinsei_fix; Type: VIEW; Schema: public; Owner: zenken_local
--

CREATE VIEW q_shinsei_fix AS
    SELECT auth_user.user_id, auth_user.username, auth_user.password, t_shinsei.kaiin_no, auth_user.mail_address AS au_mail_address, t_shinsei.simei, t_shinsei.furigana, t_shinsei.mail_address AS ts_mail_address, t_shinsei.shisetu_name, t_shinsei.shisetu_null, t_shinsei.renrakusaki, t_shinsei.jusyo, t_shinsei.tel FROM auth_user, t_shinsei_old t_shinsei WHERE ((auth_user.username)::text = (t_shinsei.login_id)::text);


ALTER TABLE public.q_shinsei_fix OWNER TO zenken_local;

--
-- Name: t_johou; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_johou (
    seq smallint,
    simekiri_nyuukin date,
    simekiri_touroku date,
    gakkaimei character varying(200),
    kouza character varying(200)
);


ALTER TABLE public.t_johou OWNER TO zenken_local;

--
-- Name: t_kari; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_kari (
    kari_kaiin_no integer,
    furigana character varying(50),
    touroku_date timestamp without time zone,
    simei character varying(50)
);


ALTER TABLE public.t_kari OWNER TO zenken_local;

--
-- Name: t_kyoukai_kaihi; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_kyoukai_kaihi (
    kaiin_no integer,
    flg boolean,
    furigana character varying(20)
);


ALTER TABLE public.t_kyoukai_kaihi OWNER TO zenken_local;

--
-- Name: t_log; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_log (
    seq bigint NOT NULL,
    kaiin_no character varying(10),
    user_agent text,
    user_agent_s character varying(20),
    login_date character varying(14)
);


ALTER TABLE public.t_log OWNER TO zenken_local;

--
-- Name: t_log_seq_seq; Type: SEQUENCE; Schema: public; Owner: zenken_local
--

CREATE SEQUENCE t_log_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_log_seq_seq OWNER TO zenken_local;

--
-- Name: t_log_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zenken_local
--

ALTER SEQUENCE t_log_seq_seq OWNED BY t_log.seq;


--
-- Name: t_nyukin; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_nyukin (
    kaiin_no integer NOT NULL,
    nyukin_flg boolean,
    simekiri_date date,
    kakunin_date date
);


ALTER TABLE public.t_nyukin OWNER TO zenken_local;

--
-- Name: t_shinsei; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_shinsei (
    seq integer DEFAULT nextval('jizen_seq'::regclass) NOT NULL,
    login_id character varying(8) NOT NULL,
    kaiin_no integer NOT NULL,
    simei character varying(50) NOT NULL,
    furigana character varying(50) NOT NULL,
    mail_address character varying(200) NOT NULL,
    shisetu_name character varying(200),
    shisetu_null boolean,
    renrakusaki smallint NOT NULL,
    tdfk smallint NOT NULL,
    jusyo character varying(200),
    tel character varying(15) NOT NULL,
    fax character varying(15),
    g_no smallint NOT NULL,
    kari_flg date,
    del_flg smallint,
    touroku_date timestamp without time zone NOT NULL,
    password character varying(32),
    mail_address_go character varying(200),
    taiki_flg boolean
);


ALTER TABLE public.t_shinsei OWNER TO zenken_local;

--
-- Name: t_torikeshi; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_torikeshi (
    kaiin_no integer,
    torikeshi_flg boolean
);


ALTER TABLE public.t_torikeshi OWNER TO zenken_local;

--
-- Name: t_torikeshi_login_id; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_torikeshi_login_id (
    user_id integer,
    username character varying(32)
);


ALTER TABLE public.t_torikeshi_login_id OWNER TO zenken_local;

--
-- Name: tm_tdfk; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE tm_tdfk (
    tdfk_cd smallint,
    tdfk_name character varying(10)
);


ALTER TABLE public.tm_tdfk OWNER TO zenken_local;

--
-- Name: seq; Type: DEFAULT; Schema: public; Owner: zenken_local
--

ALTER TABLE ONLY t_log ALTER COLUMN seq SET DEFAULT nextval('t_log_seq_seq'::regclass);


--
-- Name: auth_user_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX auth_user_idx ON auth_user USING btree (user_id);


--
-- Name: t_johou_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_johou_idx ON t_johou USING btree (seq);


--
-- Name: t_kyoukai_kaihi_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_kyoukai_kaihi_idx ON t_kyoukai_kaihi USING btree (kaiin_no);


--
-- Name: t_log_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_log_idx ON t_log USING btree (seq);


--
-- Name: t_nyukin_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_nyukin_idx ON t_nyukin USING btree (kaiin_no);


--
-- Name: t_shinsei_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_shinsei_idx ON t_shinsei_old USING btree (login_id);


--
-- Name: t_shinsei_idx_2; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_shinsei_idx_2 ON t_shinsei USING btree (seq);


--
-- Name: t_shinsei_idx_login_id; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_shinsei_idx_login_id ON t_shinsei USING btree (login_id);


--
-- Name: t_torikeshi_login_id_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_torikeshi_login_id_idx ON t_torikeshi_login_id USING btree (user_id);


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

\connect zenken

SET default_transaction_read_only = off;

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
-- Name: zenken; Type: COMMENT; Schema: -; Owner: pguser
--

COMMENT ON DATABASE zenken IS '全国研修会システム';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_sessions; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE active_sessions (
    sid character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    val text,
    changed character varying(32) NOT NULL
);


ALTER TABLE public.active_sessions OWNER TO zenken_local;

--
-- Name: active_tokens; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE active_tokens (
    token_id character varying(32),
    auth_user character varying(32),
    browser_name text,
    ip_address character varying(15),
    create_time character varying(12)
);


ALTER TABLE public.active_tokens OWNER TO zenken_local;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE auth_user (
    user_id integer NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(32) NOT NULL,
    mail_address character varying(200),
    perms character varying(32)
);


ALTER TABLE public.auth_user OWNER TO zenken_local;

--
-- Name: jizen_seq; Type: SEQUENCE; Schema: public; Owner: zenken_local
--

CREATE SEQUENCE jizen_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.jizen_seq OWNER TO zenken_local;

--
-- Name: t_shinsei_old; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_shinsei_old (
    login_id character varying(8) NOT NULL,
    kaiin_no integer NOT NULL,
    simei character varying(50),
    furigana character varying(50),
    mail_address character varying(200),
    shisetu_name character varying(200),
    shisetu_null boolean,
    renrakusaki smallint,
    tdfk character varying(10),
    jusyo character varying(200),
    tel character varying(15),
    fax character varying(15)
);


ALTER TABLE public.t_shinsei_old OWNER TO zenken_local;

--
-- Name: q_shinsei_fix; Type: VIEW; Schema: public; Owner: zenken_local
--

CREATE VIEW q_shinsei_fix AS
    SELECT auth_user.user_id, auth_user.username, auth_user.password, t_shinsei.kaiin_no, auth_user.mail_address AS au_mail_address, t_shinsei.simei, t_shinsei.furigana, t_shinsei.mail_address AS ts_mail_address, t_shinsei.shisetu_name, t_shinsei.shisetu_null, t_shinsei.renrakusaki, t_shinsei.jusyo, t_shinsei.tel FROM auth_user, t_shinsei_old t_shinsei WHERE ((auth_user.username)::text = (t_shinsei.login_id)::text);


ALTER TABLE public.q_shinsei_fix OWNER TO zenken_local;

--
-- Name: t_johou; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_johou (
    seq smallint,
    simekiri_nyuukin date,
    simekiri_touroku date,
    gakkaimei character varying(200),
    kouza character varying(200)
);


ALTER TABLE public.t_johou OWNER TO zenken_local;

--
-- Name: t_kari; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_kari (
    kari_kaiin_no integer,
    furigana character varying(50),
    touroku_date timestamp without time zone,
    simei character varying(50)
);


ALTER TABLE public.t_kari OWNER TO zenken_local;

--
-- Name: t_kyoukai_kaihi; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_kyoukai_kaihi (
    kaiin_no integer,
    flg boolean,
    furigana character varying(20)
);


ALTER TABLE public.t_kyoukai_kaihi OWNER TO zenken_local;

--
-- Name: t_log; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_log (
    seq bigint NOT NULL,
    kaiin_no character varying(10),
    user_agent text,
    user_agent_s character varying(20),
    login_date character varying(14)
);


ALTER TABLE public.t_log OWNER TO zenken_local;

--
-- Name: t_log_seq_seq; Type: SEQUENCE; Schema: public; Owner: zenken_local
--

CREATE SEQUENCE t_log_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.t_log_seq_seq OWNER TO zenken_local;

--
-- Name: t_log_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zenken_local
--

ALTER SEQUENCE t_log_seq_seq OWNED BY t_log.seq;


--
-- Name: t_nyukin; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_nyukin (
    kaiin_no integer NOT NULL,
    nyukin_flg boolean,
    simekiri_date date,
    kakunin_date date
);


ALTER TABLE public.t_nyukin OWNER TO zenken_local;

--
-- Name: t_shinsei; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_shinsei (
    seq integer DEFAULT nextval('jizen_seq'::regclass) NOT NULL,
    login_id character varying(8) NOT NULL,
    kaiin_no integer NOT NULL,
    simei character varying(50) NOT NULL,
    furigana character varying(50) NOT NULL,
    mail_address character varying(200) NOT NULL,
    shisetu_name character varying(200),
    shisetu_null boolean,
    renrakusaki smallint NOT NULL,
    tdfk smallint NOT NULL,
    jusyo character varying(200),
    tel character varying(15) NOT NULL,
    fax character varying(15),
    g_no smallint NOT NULL,
    kari_flg date,
    del_flg smallint,
    touroku_date timestamp without time zone NOT NULL,
    password character varying(32),
    mail_address_go character varying(200),
    taiki_flg boolean
);


ALTER TABLE public.t_shinsei OWNER TO zenken_local;

--
-- Name: t_torikeshi; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_torikeshi (
    kaiin_no integer,
    torikeshi_flg boolean
);


ALTER TABLE public.t_torikeshi OWNER TO zenken_local;

--
-- Name: t_torikeshi_login_id; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE t_torikeshi_login_id (
    user_id integer,
    username character varying(32)
);


ALTER TABLE public.t_torikeshi_login_id OWNER TO zenken_local;

--
-- Name: tm_tdfk; Type: TABLE; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE TABLE tm_tdfk (
    tdfk_cd smallint,
    tdfk_name character varying(10)
);


ALTER TABLE public.tm_tdfk OWNER TO zenken_local;

--
-- Name: seq; Type: DEFAULT; Schema: public; Owner: zenken_local
--

ALTER TABLE ONLY t_log ALTER COLUMN seq SET DEFAULT nextval('t_log_seq_seq'::regclass);


--
-- Name: auth_user_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX auth_user_idx ON auth_user USING btree (user_id);


--
-- Name: t_johou_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_johou_idx ON t_johou USING btree (seq);


--
-- Name: t_kyoukai_kaihi_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_kyoukai_kaihi_idx ON t_kyoukai_kaihi USING btree (kaiin_no);


--
-- Name: t_log_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_log_idx ON t_log USING btree (seq);


--
-- Name: t_nyukin_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_nyukin_idx ON t_nyukin USING btree (kaiin_no);


--
-- Name: t_shinsei_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_shinsei_idx ON t_shinsei_old USING btree (login_id);


--
-- Name: t_shinsei_idx_2; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_shinsei_idx_2 ON t_shinsei USING btree (seq);


--
-- Name: t_shinsei_idx_login_id; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_shinsei_idx_login_id ON t_shinsei USING btree (login_id);


--
-- Name: t_torikeshi_login_id_idx; Type: INDEX; Schema: public; Owner: zenken_local; Tablespace: 
--

CREATE UNIQUE INDEX t_torikeshi_login_id_idx ON t_torikeshi_login_id USING btree (user_id);


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

--
-- PostgreSQL database cluster dump complete
--

