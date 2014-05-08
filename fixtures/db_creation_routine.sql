--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.8
-- Dumped by pg_dump version 9.1.8
-- Started on 2013-02-26 12:06:52 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 3482 (class 1262 OID 21625)
-- Name: metpetdb; Type: DATABASE; Schema: -; Owner: -
--

--CREATE DATABASE metpetdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


--\connect metpetdb

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 286 (class 3079 OID 11645)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 286
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 1421 (class 0 OID 0)
-- Name: box2d; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE box2d;


--
-- TOC entry 363 (class 1255 OID 16464)
-- Dependencies: 5 1421
-- Name: box2d_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2d_in(cstring) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_in';


--
-- TOC entry 364 (class 1255 OID 16465)
-- Dependencies: 5 1421
-- Name: box2d_out(box2d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2d_out(box2d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_out';


--
-- TOC entry 1420 (class 1247 OID 16441)
-- Dependencies: 5 363 364
-- Name: box2d; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE box2d (
    INTERNALLENGTH = 16,
    INPUT = box2d_in,
    OUTPUT = box2d_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


--
-- TOC entry 1409 (class 0 OID 0)
-- Name: box3d; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE box3d;


--
-- TOC entry 339 (class 1255 OID 16433)
-- Dependencies: 5 1409
-- Name: box3d_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d_in(cstring) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_in';


--
-- TOC entry 340 (class 1255 OID 16434)
-- Dependencies: 5 1409
-- Name: box3d_out(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d_out(box3d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_out';


--
-- TOC entry 1408 (class 1247 OID 16430)
-- Dependencies: 339 5 340
-- Name: box3d; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE box3d (
    INTERNALLENGTH = 48,
    INPUT = box3d_in,
    OUTPUT = box3d_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- TOC entry 1413 (class 0 OID 0)
-- Name: box3d_extent; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE box3d_extent;


--
-- TOC entry 341 (class 1255 OID 16437)
-- Dependencies: 5 1413
-- Name: box3d_extent_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d_extent_in(cstring) RETURNS box3d_extent
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_in';


--
-- TOC entry 342 (class 1255 OID 16438)
-- Dependencies: 5 1413
-- Name: box3d_extent_out(box3d_extent); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d_extent_out(box3d_extent) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_extent_out';


--
-- TOC entry 1412 (class 1247 OID 16436)
-- Dependencies: 342 5 341
-- Name: box3d_extent; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE box3d_extent (
    INTERNALLENGTH = 48,
    INPUT = box3d_extent_in,
    OUTPUT = box3d_extent_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- TOC entry 1417 (class 0 OID 0)
-- Name: chip; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE chip;


--
-- TOC entry 357 (class 1255 OID 16457)
-- Dependencies: 5 1417
-- Name: chip_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION chip_in(cstring) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_in';


--
-- TOC entry 358 (class 1255 OID 16458)
-- Dependencies: 5 1417
-- Name: chip_out(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION chip_out(chip) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_out';


--
-- TOC entry 1416 (class 1247 OID 16456)
-- Dependencies: 5 358 357
-- Name: chip; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE chip (
    INTERNALLENGTH = variable,
    INPUT = chip_in,
    OUTPUT = chip_out,
    ALIGNMENT = double,
    STORAGE = extended
);


--
-- TOC entry 1432 (class 0 OID 0)
-- Name: geography; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE geography;


--
-- TOC entry 963 (class 1255 OID 17191)
-- Dependencies: 5
-- Name: geography_analyze(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_analyze(internal) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'geography_analyze';


--
-- TOC entry 852 (class 1255 OID 17189)
-- Dependencies: 5 1432
-- Name: geography_in(cstring, oid, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_in(cstring, oid, integer) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_in';


--
-- TOC entry 914 (class 1255 OID 17190)
-- Dependencies: 5 1432
-- Name: geography_out(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_out(geography) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_out';


--
-- TOC entry 988 (class 1255 OID 17186)
-- Dependencies: 5
-- Name: geography_typmod_in(cstring[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_typmod_in(cstring[]) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_in';


--
-- TOC entry 989 (class 1255 OID 17187)
-- Dependencies: 5
-- Name: geography_typmod_out(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_typmod_out(integer) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_out';


--
-- TOC entry 1431 (class 1247 OID 17188)
-- Dependencies: 852 5 963 989 988 914
-- Name: geography; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE geography (
    INTERNALLENGTH = variable,
    INPUT = geography_in,
    OUTPUT = geography_out,
    TYPMOD_IN = geography_typmod_in,
    TYPMOD_OUT = geography_typmod_out,
    ANALYZE = geography_analyze,
    ALIGNMENT = double,
    STORAGE = main
);


--
-- TOC entry 1405 (class 0 OID 0)
-- Name: geometry; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE geometry;


--
-- TOC entry 309 (class 1255 OID 16402)
-- Dependencies: 5
-- Name: geometry_analyze(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_analyze(internal) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_analyze';


--
-- TOC entry 307 (class 1255 OID 16400)
-- Dependencies: 5 1405
-- Name: geometry_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_in(cstring) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_in';


--
-- TOC entry 308 (class 1255 OID 16401)
-- Dependencies: 5 1405
-- Name: geometry_out(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_out(geometry) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_out';


--
-- TOC entry 310 (class 1255 OID 16403)
-- Dependencies: 5 1405
-- Name: geometry_recv(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_recv(internal) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_recv';


--
-- TOC entry 311 (class 1255 OID 16404)
-- Dependencies: 5 1405
-- Name: geometry_send(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_send(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_send';


--
-- TOC entry 1404 (class 1247 OID 16394)
-- Dependencies: 5 310 311 309 307 308
-- Name: geometry; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE geometry (
    INTERNALLENGTH = variable,
    INPUT = geometry_in,
    OUTPUT = geometry_out,
    RECEIVE = geometry_recv,
    SEND = geometry_send,
    ANALYZE = geometry_analyze,
    DELIMITER = ':',
    ALIGNMENT = int4,
    STORAGE = main
);


--
-- TOC entry 1424 (class 1247 OID 16716)
-- Dependencies: 5 161
-- Name: geometry_dump; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE geometry_dump AS (
	path integer[],
	geom geometry
);


--
-- TOC entry 1436 (class 0 OID 0)
-- Name: gidx; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE gidx;


--
-- TOC entry 964 (class 1255 OID 17194)
-- Dependencies: 5 1436
-- Name: gidx_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gidx_in(cstring) RETURNS gidx
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'gidx_in';


--
-- TOC entry 965 (class 1255 OID 17195)
-- Dependencies: 5 1436
-- Name: gidx_out(gidx); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gidx_out(gidx) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'gidx_out';


--
-- TOC entry 1435 (class 1247 OID 17193)
-- Dependencies: 965 5 964
-- Name: gidx; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gidx (
    INTERNALLENGTH = variable,
    INPUT = gidx_in,
    OUTPUT = gidx_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- TOC entry 1428 (class 0 OID 0)
-- Name: pgis_abs; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE pgis_abs;


--
-- TOC entry 702 (class 1255 OID 16895)
-- Dependencies: 5 1428
-- Name: pgis_abs_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_abs_in(cstring) RETURNS pgis_abs
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_abs_in';


--
-- TOC entry 703 (class 1255 OID 16896)
-- Dependencies: 5 1428
-- Name: pgis_abs_out(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_abs_out(pgis_abs) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_abs_out';


--
-- TOC entry 1427 (class 1247 OID 16894)
-- Dependencies: 702 5 703
-- Name: pgis_abs; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE pgis_abs (
    INTERNALLENGTH = 8,
    INPUT = pgis_abs_in,
    OUTPUT = pgis_abs_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- TOC entry 1401 (class 0 OID 0)
-- Name: spheroid; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE spheroid;


--
-- TOC entry 300 (class 1255 OID 16391)
-- Dependencies: 5 1401
-- Name: spheroid_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION spheroid_in(cstring) RETURNS spheroid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ellipsoid_in';


--
-- TOC entry 301 (class 1255 OID 16392)
-- Dependencies: 5 1401
-- Name: spheroid_out(spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION spheroid_out(spheroid) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ellipsoid_out';


--
-- TOC entry 1400 (class 1247 OID 16388)
-- Dependencies: 5 301 300
-- Name: spheroid; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE spheroid (
    INTERNALLENGTH = 65,
    INPUT = spheroid_in,
    OUTPUT = spheroid_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- TOC entry 784 (class 1255 OID 16987)
-- Dependencies: 1404 5
-- Name: _st_asgeojson(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asgeojson(integer, geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asGeoJson';


--
-- TOC entry 1037 (class 1255 OID 17276)
-- Dependencies: 5 1431
-- Name: _st_asgeojson(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asgeojson(integer, geography, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_geojson';


--
-- TOC entry 767 (class 1255 OID 16970)
-- Dependencies: 5 1404
-- Name: _st_asgml(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asgml(integer, geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asGML';


--
-- TOC entry 1023 (class 1255 OID 17262)
-- Dependencies: 5 1431
-- Name: _st_asgml(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asgml(integer, geography, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_gml';


--
-- TOC entry 776 (class 1255 OID 16979)
-- Dependencies: 5 1404
-- Name: _st_askml(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_askml(integer, geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asKML';


--
-- TOC entry 1031 (class 1255 OID 17270)
-- Dependencies: 1431 5
-- Name: _st_askml(integer, geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_askml(integer, geography, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_kml';


--
-- TOC entry 1069 (class 1255 OID 17308)
-- Dependencies: 1431 5
-- Name: _st_bestsrid(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_bestsrid(geography) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_BestSRID($1,$1)$_$;


--
-- TOC entry 1068 (class 1255 OID 17307)
-- Dependencies: 5 1431 1431
-- Name: _st_bestsrid(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_bestsrid(geography, geography) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_bestsrid';


--
-- TOC entry 676 (class 1255 OID 16864)
-- Dependencies: 5 1404 1404
-- Name: _st_buffer(geometry, double precision, cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_buffer(geometry, double precision, cstring) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'buffer';


--
-- TOC entry 734 (class 1255 OID 16937)
-- Dependencies: 5 1404 1404
-- Name: _st_contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_contains(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'contains';


--
-- TOC entry 740 (class 1255 OID 16943)
-- Dependencies: 5 1404 1404
-- Name: _st_containsproperly(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_containsproperly(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'containsproperly';


--
-- TOC entry 736 (class 1255 OID 16939)
-- Dependencies: 5 1404 1404
-- Name: _st_coveredby(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_coveredby(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'coveredby';


--
-- TOC entry 738 (class 1255 OID 16941)
-- Dependencies: 5 1404 1404
-- Name: _st_covers(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_covers(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'covers';


--
-- TOC entry 1061 (class 1255 OID 17300)
-- Dependencies: 5 1431 1431
-- Name: _st_covers(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_covers(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_covers';


--
-- TOC entry 728 (class 1255 OID 16931)
-- Dependencies: 5 1404 1404
-- Name: _st_crosses(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_crosses(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'crosses';


--
-- TOC entry 952 (class 1255 OID 17153)
-- Dependencies: 5 1404 1404
-- Name: _st_dfullywithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_dfullywithin(geometry, geometry, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dfullywithin';


--
-- TOC entry 1045 (class 1255 OID 17284)
-- Dependencies: 1431 5 1431
-- Name: _st_distance(geography, geography, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_distance(geography, geography, double precision, boolean) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_distance';


--
-- TOC entry 570 (class 1255 OID 16721)
-- Dependencies: 5 1734 1424 1404
-- Name: _st_dumppoints(geometry, integer[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_dumppoints(the_geom geometry, cur_path integer[]) RETURNS SETOF geometry_dump
    LANGUAGE plpgsql
    AS $$
DECLARE
  tmp geometry_dump;
  tmp2 geometry_dump;
  nb_points integer;
  nb_geom integer;
  i integer;
  j integer;
  g geometry;
  
BEGIN
  
  RAISE DEBUG '%,%', cur_path, ST_GeometryType(the_geom);

  -- Special case (MULTI* OR GEOMETRYCOLLECTION) : iterate and return the DumpPoints of the geometries
  SELECT ST_NumGeometries(the_geom) INTO nb_geom;

  IF (nb_geom IS NOT NULL) THEN
    
    i = 1;
    FOR tmp2 IN SELECT (ST_Dump(the_geom)).* LOOP

      FOR tmp IN SELECT * FROM _ST_DumpPoints(tmp2.geom, cur_path || tmp2.path) LOOP
	    RETURN NEXT tmp;
      END LOOP;
      i = i + 1;
      
    END LOOP;

    RETURN;
  END IF;
  

  -- Special case (POLYGON) : return the points of the rings of a polygon
  IF (ST_GeometryType(the_geom) = 'ST_Polygon') THEN

    FOR tmp IN SELECT * FROM _ST_DumpPoints(ST_ExteriorRing(the_geom), cur_path || ARRAY[1]) LOOP
      RETURN NEXT tmp;
    END LOOP;
    
    j := ST_NumInteriorRings(the_geom);
    FOR i IN 1..j LOOP
        FOR tmp IN SELECT * FROM _ST_DumpPoints(ST_InteriorRingN(the_geom, i), cur_path || ARRAY[i+1]) LOOP
          RETURN NEXT tmp;
        END LOOP;
    END LOOP;
    
    RETURN;
  END IF;

    
  -- Special case (POINT) : return the point
  IF (ST_GeometryType(the_geom) = 'ST_Point') THEN

    tmp.path = cur_path || ARRAY[1];
    tmp.geom = the_geom;

    RETURN NEXT tmp;
    RETURN;

  END IF;


  -- Use ST_NumPoints rather than ST_NPoints to have a NULL value if the_geom isn't
  -- a LINESTRING or CIRCULARSTRING.
  SELECT ST_NumPoints(the_geom) INTO nb_points;

  -- This should never happen
  IF (nb_points IS NULL) THEN
    RAISE EXCEPTION 'Unexpected error while dumping geometry %', ST_AsText(the_geom);
  END IF;

  FOR i IN 1..nb_points LOOP
    tmp.path = cur_path || ARRAY[i];
    tmp.geom := ST_PointN(the_geom, i);
    RETURN NEXT tmp;
  END LOOP;
   
END
$$;


--
-- TOC entry 722 (class 1255 OID 16925)
-- Dependencies: 5 1404 1404
-- Name: _st_dwithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_dwithin(geometry, geometry, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_dwithin';


--
-- TOC entry 1046 (class 1255 OID 17285)
-- Dependencies: 1431 1431 5
-- Name: _st_dwithin(geography, geography, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_dwithin(geography, geography, double precision, boolean) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_dwithin';


--
-- TOC entry 756 (class 1255 OID 16959)
-- Dependencies: 1404 5 1404
-- Name: _st_equals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_equals(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geomequals';


--
-- TOC entry 1050 (class 1255 OID 17289)
-- Dependencies: 1431 5 1431
-- Name: _st_expand(geography, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_expand(geography, double precision) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_expand';


--
-- TOC entry 725 (class 1255 OID 16928)
-- Dependencies: 5 1404 1404
-- Name: _st_intersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_intersects(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'intersects';


--
-- TOC entry 682 (class 1255 OID 16870)
-- Dependencies: 1404 5 1404
-- Name: _st_linecrossingdirection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_linecrossingdirection(geometry, geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'ST_LineCrossingDirection';


--
-- TOC entry 950 (class 1255 OID 17151)
-- Dependencies: 5 1404 1404 1404
-- Name: _st_longestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_longestline(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_longestline2d';


--
-- TOC entry 946 (class 1255 OID 17147)
-- Dependencies: 5 1404 1404
-- Name: _st_maxdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_maxdistance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_maxdistance2d_linestring';


--
-- TOC entry 977 (class 1255 OID 17175)
-- Dependencies: 1404 1404 5
-- Name: _st_orderingequals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_orderingequals(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_same';


--
-- TOC entry 743 (class 1255 OID 16946)
-- Dependencies: 1404 1404 5
-- Name: _st_overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_overlaps(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'overlaps';


--
-- TOC entry 1060 (class 1255 OID 17299)
-- Dependencies: 5 1431 1431
-- Name: _st_pointoutside(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_pointoutside(geography) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_point_outside';


--
-- TOC entry 720 (class 1255 OID 16923)
-- Dependencies: 5 1404 1404
-- Name: _st_touches(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_touches(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'touches';


--
-- TOC entry 731 (class 1255 OID 16934)
-- Dependencies: 5 1404 1404
-- Name: _st_within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_within(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'within';


--
-- TOC entry 966 (class 1255 OID 17164)
-- Dependencies: 1734 5
-- Name: addauth(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addauth(text) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$ 
DECLARE
	lockid alias for $1;
	okay boolean;
	myrec record;
BEGIN
	-- check to see if table exists
	--  if not, CREATE TEMP TABLE mylock (transid xid, lockcode text)
	okay := 'f';
	FOR myrec IN SELECT * FROM pg_class WHERE relname = 'temp_lock_have_table' LOOP
		okay := 't';
	END LOOP; 
	IF (okay <> 't') THEN 
		CREATE TEMP TABLE temp_lock_have_table (transid xid, lockcode text);
			-- this will only work from pgsql7.4 up
			-- ON COMMIT DELETE ROWS;
	END IF;

	--  INSERT INTO mylock VALUES ( $1)
--	EXECUTE 'INSERT INTO temp_lock_have_table VALUES ( '||
--		quote_literal(getTransactionID()) || ',' ||
--		quote_literal(lockid) ||')';

	INSERT INTO temp_lock_have_table VALUES (getTransactionID(), lockid);

	RETURN true::boolean;
END;
$_$;


--
-- TOC entry 415 (class 1255 OID 16563)
-- Dependencies: 1404 5 1404
-- Name: addbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addBBOX';


--
-- TOC entry 597 (class 1255 OID 16765)
-- Dependencies: 1734 5
-- Name: addgeometrycolumn(character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addgeometrycolumn(character varying, character varying, integer, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT AddGeometryColumn('','',$1,$2,$3,$4,$5) into ret;
	RETURN ret;
END;
$_$;


--
-- TOC entry 596 (class 1255 OID 16764)
-- Dependencies: 5 1734
-- Name: addgeometrycolumn(character varying, character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addgeometrycolumn(character varying, character varying, character varying, integer, character varying, integer) RETURNS text
    LANGUAGE plpgsql STABLE STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT AddGeometryColumn('',$1,$2,$3,$4,$5,$6) into ret;
	RETURN ret;
END;
$_$;


--
-- TOC entry 595 (class 1255 OID 16763)
-- Dependencies: 5 1734
-- Name: addgeometrycolumn(character varying, character varying, character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addgeometrycolumn(character varying, character varying, character varying, character varying, integer, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1;
	schema_name alias for $2;
	table_name alias for $3;
	column_name alias for $4;
	new_srid alias for $5;
	new_type alias for $6;
	new_dim alias for $7;
	rec RECORD;
	sr varchar;
	real_schema name;
	sql text;

BEGIN

	-- Verify geometry type
	IF ( NOT ( (new_type = 'GEOMETRY') OR
			   (new_type = 'GEOMETRYCOLLECTION') OR
			   (new_type = 'POINT') OR
			   (new_type = 'MULTIPOINT') OR
			   (new_type = 'POLYGON') OR
			   (new_type = 'MULTIPOLYGON') OR
			   (new_type = 'LINESTRING') OR
			   (new_type = 'MULTILINESTRING') OR
			   (new_type = 'GEOMETRYCOLLECTIONM') OR
			   (new_type = 'POINTM') OR
			   (new_type = 'MULTIPOINTM') OR
			   (new_type = 'POLYGONM') OR
			   (new_type = 'MULTIPOLYGONM') OR
			   (new_type = 'LINESTRINGM') OR
			   (new_type = 'MULTILINESTRINGM') OR
			   (new_type = 'CIRCULARSTRING') OR
			   (new_type = 'CIRCULARSTRINGM') OR
			   (new_type = 'COMPOUNDCURVE') OR
			   (new_type = 'COMPOUNDCURVEM') OR
			   (new_type = 'CURVEPOLYGON') OR
			   (new_type = 'CURVEPOLYGONM') OR
			   (new_type = 'MULTICURVE') OR
			   (new_type = 'MULTICURVEM') OR
			   (new_type = 'MULTISURFACE') OR
			   (new_type = 'MULTISURFACEM')) )
	THEN
		RAISE EXCEPTION 'Invalid type name - valid ones are:
	POINT, MULTIPOINT,
	LINESTRING, MULTILINESTRING,
	POLYGON, MULTIPOLYGON,
	CIRCULARSTRING, COMPOUNDCURVE, MULTICURVE,
	CURVEPOLYGON, MULTISURFACE,
	GEOMETRY, GEOMETRYCOLLECTION,
	POINTM, MULTIPOINTM,
	LINESTRINGM, MULTILINESTRINGM,
	POLYGONM, MULTIPOLYGONM,
	CIRCULARSTRINGM, COMPOUNDCURVEM, MULTICURVEM
	CURVEPOLYGONM, MULTISURFACEM,
	or GEOMETRYCOLLECTIONM';
		RETURN 'fail';
	END IF;


	-- Verify dimension
	IF ( (new_dim >4) OR (new_dim <0) ) THEN
		RAISE EXCEPTION 'invalid dimension';
		RETURN 'fail';
	END IF;

	IF ( (new_type LIKE '%M') AND (new_dim!=3) ) THEN
		RAISE EXCEPTION 'TypeM needs 3 dimensions';
		RETURN 'fail';
	END IF;


	-- Verify SRID
	IF ( new_srid != -1 ) THEN
		SELECT SRID INTO sr FROM spatial_ref_sys WHERE SRID = new_srid;
		IF NOT FOUND THEN
			RAISE EXCEPTION 'AddGeometryColumns() - invalid SRID';
			RETURN 'fail';
		END IF;
	END IF;


	-- Verify schema
	IF ( schema_name IS NOT NULL AND schema_name != '' ) THEN
		sql := 'SELECT nspname FROM pg_namespace ' ||
			'WHERE text(nspname) = ' || quote_literal(schema_name) ||
			'LIMIT 1';
		RAISE DEBUG '%', sql;
		EXECUTE sql INTO real_schema;

		IF ( real_schema IS NULL ) THEN
			RAISE EXCEPTION 'Schema % is not a valid schemaname', quote_literal(schema_name);
			RETURN 'fail';
		END IF;
	END IF;

	IF ( real_schema IS NULL ) THEN
		RAISE DEBUG 'Detecting schema';
		sql := 'SELECT n.nspname AS schemaname ' ||
			'FROM pg_catalog.pg_class c ' ||
			  'JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace ' ||
			'WHERE c.relkind = ' || quote_literal('r') ||
			' AND n.nspname NOT IN (' || quote_literal('pg_catalog') || ', ' || quote_literal('pg_toast') || ')' ||
			' AND pg_catalog.pg_table_is_visible(c.oid)' ||
			' AND c.relname = ' || quote_literal(table_name);
		RAISE DEBUG '%', sql;
		EXECUTE sql INTO real_schema;

		IF ( real_schema IS NULL ) THEN
			RAISE EXCEPTION 'Table % does not occur in the search_path', quote_literal(table_name);
			RETURN 'fail';
		END IF;
	END IF;


	-- Add geometry column to table
	sql := 'ALTER TABLE ' ||
		quote_ident(real_schema) || '.' || quote_ident(table_name)
		|| ' ADD COLUMN ' || quote_ident(column_name) ||
		' geometry ';
	RAISE DEBUG '%', sql;
	EXECUTE sql;


	-- Delete stale record in geometry_columns (if any)
	sql := 'DELETE FROM geometry_columns WHERE
		f_table_catalog = ' || quote_literal('') ||
		' AND f_table_schema = ' ||
		quote_literal(real_schema) ||
		' AND f_table_name = ' || quote_literal(table_name) ||
		' AND f_geometry_column = ' || quote_literal(column_name);
	RAISE DEBUG '%', sql;
	EXECUTE sql;


	-- Add record in geometry_columns
	sql := 'INSERT INTO geometry_columns (f_table_catalog,f_table_schema,f_table_name,' ||
										  'f_geometry_column,coord_dimension,srid,type)' ||
		' VALUES (' ||
		quote_literal('') || ',' ||
		quote_literal(real_schema) || ',' ||
		quote_literal(table_name) || ',' ||
		quote_literal(column_name) || ',' ||
		new_dim::text || ',' ||
		new_srid::text || ',' ||
		quote_literal(new_type) || ')';
	RAISE DEBUG '%', sql;
	EXECUTE sql;


	-- Add table CHECKs
	sql := 'ALTER TABLE ' ||
		quote_ident(real_schema) || '.' || quote_ident(table_name)
		|| ' ADD CONSTRAINT '
		|| quote_ident('enforce_srid_' || column_name)
		|| ' CHECK (ST_SRID(' || quote_ident(column_name) ||
		') = ' || new_srid::text || ')' ;
	RAISE DEBUG '%', sql;
	EXECUTE sql;

	sql := 'ALTER TABLE ' ||
		quote_ident(real_schema) || '.' || quote_ident(table_name)
		|| ' ADD CONSTRAINT '
		|| quote_ident('enforce_dims_' || column_name)
		|| ' CHECK (ST_NDims(' || quote_ident(column_name) ||
		') = ' || new_dim::text || ')' ;
	RAISE DEBUG '%', sql;
	EXECUTE sql;

	IF ( NOT (new_type = 'GEOMETRY')) THEN
		sql := 'ALTER TABLE ' ||
			quote_ident(real_schema) || '.' || quote_ident(table_name) || ' ADD CONSTRAINT ' ||
			quote_ident('enforce_geotype_' || column_name) ||
			' CHECK (GeometryType(' ||
			quote_ident(column_name) || ')=' ||
			quote_literal(new_type) || ' OR (' ||
			quote_ident(column_name) || ') is null)';
		RAISE DEBUG '%', sql;
		EXECUTE sql;
	END IF;

	RETURN
		real_schema || '.' ||
		table_name || '.' || column_name ||
		' SRID:' || new_srid::text ||
		' TYPE:' || new_type ||
		' DIMS:' || new_dim::text || ' ';
END;
$_$;


--
-- TOC entry 546 (class 1255 OID 16694)
-- Dependencies: 5 1404 1404 1404
-- Name: addpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addpoint(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addpoint';


--
-- TOC entry 548 (class 1255 OID 16696)
-- Dependencies: 5 1404 1404 1404
-- Name: addpoint(geometry, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addpoint(geometry, geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addpoint';


--
-- TOC entry 314 (class 1255 OID 16408)
-- Dependencies: 1404 1404 5
-- Name: affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $2, $3, 0,  $4, $5, 0,  0, 0, 1,  $6, $7, 0)$_$;


--
-- TOC entry 312 (class 1255 OID 16406)
-- Dependencies: 1404 5 1404
-- Name: affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_affine';


--
-- TOC entry 467 (class 1255 OID 16615)
-- Dependencies: 5 1404
-- Name: area(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION area(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_area_polygon';


--
-- TOC entry 465 (class 1255 OID 16613)
-- Dependencies: 5 1404
-- Name: area2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION area2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_area_polygon';


--
-- TOC entry 833 (class 1255 OID 17036)
-- Dependencies: 5 1404
-- Name: asbinary(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION asbinary(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asBinary';


--
-- TOC entry 835 (class 1255 OID 17038)
-- Dependencies: 1404 5
-- Name: asbinary(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION asbinary(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asBinary';


--
-- TOC entry 514 (class 1255 OID 16662)
-- Dependencies: 5 1404
-- Name: asewkb(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION asewkb(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'WKBFromLWGEOM';


--
-- TOC entry 520 (class 1255 OID 16668)
-- Dependencies: 5 1404
-- Name: asewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION asewkb(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'WKBFromLWGEOM';


--
-- TOC entry 512 (class 1255 OID 16660)
-- Dependencies: 1404 5
-- Name: asewkt(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION asewkt(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asEWKT';


--
-- TOC entry 770 (class 1255 OID 16973)
-- Dependencies: 5 1404
-- Name: asgml(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION asgml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, 15, 0)$_$;


--
-- TOC entry 768 (class 1255 OID 16971)
-- Dependencies: 5 1404
-- Name: asgml(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION asgml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, 0)$_$;


--
-- TOC entry 516 (class 1255 OID 16664)
-- Dependencies: 5 1404
-- Name: ashexewkb(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ashexewkb(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asHEXEWKB';


--
-- TOC entry 518 (class 1255 OID 16666)
-- Dependencies: 5 1404
-- Name: ashexewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ashexewkb(geometry, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asHEXEWKB';


--
-- TOC entry 779 (class 1255 OID 16982)
-- Dependencies: 1404 5
-- Name: askml(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION askml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, transform($1,4326), 15)$_$;


--
-- TOC entry 777 (class 1255 OID 16980)
-- Dependencies: 5 1404
-- Name: askml(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION askml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, transform($1,4326), $2)$_$;


--
-- TOC entry 780 (class 1255 OID 16983)
-- Dependencies: 5 1404
-- Name: askml(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION askml(integer, geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, transform($2,4326), $3)$_$;


--
-- TOC entry 765 (class 1255 OID 16968)
-- Dependencies: 5 1404
-- Name: assvg(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION assvg(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


--
-- TOC entry 763 (class 1255 OID 16966)
-- Dependencies: 5 1404
-- Name: assvg(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION assvg(geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


--
-- TOC entry 761 (class 1255 OID 16964)
-- Dependencies: 1404 5
-- Name: assvg(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION assvg(geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


--
-- TOC entry 837 (class 1255 OID 17040)
-- Dependencies: 1404 5
-- Name: astext(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION astext(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asText';


--
-- TOC entry 477 (class 1255 OID 16625)
-- Dependencies: 5 1404 1404
-- Name: azimuth(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION azimuth(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_azimuth';


--
-- TOC entry 956 (class 1255 OID 17157)
-- Dependencies: 5 1404 1734
-- Name: bdmpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION bdmpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := multi(BuildArea(mline));

	RETURN geom;
END;
$_$;


--
-- TOC entry 954 (class 1255 OID 17155)
-- Dependencies: 1404 5 1734
-- Name: bdpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION bdpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := BuildArea(mline);

	IF GeometryType(geom) != 'POLYGON'
	THEN
		RAISE EXCEPTION 'Input returns more then a single polygon, try using BdMPolyFromText instead';
	END IF;

	RETURN geom;
END;
$_$;


--
-- TOC entry 691 (class 1255 OID 16879)
-- Dependencies: 5 1404 1404
-- Name: boundary(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION boundary(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'boundary';


--
-- TOC entry 608 (class 1255 OID 16809)
-- Dependencies: 5 1404
-- Name: box(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box(geometry) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX';


--
-- TOC entry 640 (class 1255 OID 16812)
-- Dependencies: 5 1408
-- Name: box(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box(box3d) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX';


--
-- TOC entry 344 (class 1255 OID 16442)
-- Dependencies: 1420 5 1412
-- Name: box2d(box3d_extent); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2d(box3d_extent) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX2DFLOAT4';


--
-- TOC entry 594 (class 1255 OID 16807)
-- Dependencies: 5 1420 1404
-- Name: box2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2d(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX2DFLOAT4';


--
-- TOC entry 638 (class 1255 OID 16810)
-- Dependencies: 1408 5 1420
-- Name: box2d(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2d(box3d) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX2DFLOAT4';


--
-- TOC entry 607 (class 1255 OID 16808)
-- Dependencies: 1404 1408 5
-- Name: box3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d(geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX3D';


--
-- TOC entry 639 (class 1255 OID 16811)
-- Dependencies: 1420 5 1408
-- Name: box3d(box2d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d(box2d) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_to_BOX3D';


--
-- TOC entry 343 (class 1255 OID 16440)
-- Dependencies: 1408 5 1412
-- Name: box3d_extent(box3d_extent); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d_extent(box3d_extent) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_extent_to_BOX3D';


--
-- TOC entry 642 (class 1255 OID 16814)
-- Dependencies: 5 1408
-- Name: box3dtobox(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3dtobox(box3d) RETURNS box
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT box($1)$_$;


--
-- TOC entry 674 (class 1255 OID 16862)
-- Dependencies: 1404 5 1404
-- Name: buffer(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION buffer(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'buffer';


--
-- TOC entry 679 (class 1255 OID 16867)
-- Dependencies: 1404 1404 5
-- Name: buffer(geometry, double precision, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION buffer(geometry, double precision, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Buffer($1, $2, $3)$_$;


--
-- TOC entry 559 (class 1255 OID 16707)
-- Dependencies: 5 1404 1404
-- Name: buildarea(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION buildarea(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_buildarea';


--
-- TOC entry 648 (class 1255 OID 16820)
-- Dependencies: 5 1404
-- Name: bytea(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION bytea(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_bytea';


--
-- TOC entry 747 (class 1255 OID 16950)
-- Dependencies: 1404 5 1404
-- Name: centroid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION centroid(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'centroid';


--
-- TOC entry 968 (class 1255 OID 17166)
-- Dependencies: 5
-- Name: checkauth(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION checkauth(text, text) RETURNS integer
    LANGUAGE sql
    AS $_$ SELECT CheckAuth('', $1, $2) $_$;


--
-- TOC entry 967 (class 1255 OID 17165)
-- Dependencies: 1734 5
-- Name: checkauth(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION checkauth(text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$ 
DECLARE
	schema text;
BEGIN
	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	if ( $1 != '' ) THEN
		schema = $1;
	ELSE
		SELECT current_schema() into schema;
	END IF;

	-- TODO: check for an already existing trigger ?

	EXECUTE 'CREATE TRIGGER check_auth BEFORE UPDATE OR DELETE ON ' 
		|| quote_ident(schema) || '.' || quote_ident($2)
		||' FOR EACH ROW EXECUTE PROCEDURE CheckAuthTrigger('
		|| quote_literal($3) || ')';

	RETURN 0;
END;
$_$;


--
-- TOC entry 969 (class 1255 OID 17167)
-- Dependencies: 5
-- Name: checkauthtrigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION checkauthtrigger() RETURNS trigger
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'check_authorization';


--
-- TOC entry 1080 (class 1255 OID 21626)
-- Dependencies: 5 1734
-- Name: chemical_analysis_elements_sync(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION chemical_analysis_elements_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO chemical_analysis_elements_dup(chemical_analysis_id, element_id, amount, precision, precision_type, measurement_unit, min_amount, max_amount, id)
    VALUES (NEW.chemical_analysis_id,NEW.element_id,NEW.amount,NEW.precision,NEW.precision_type, NEW.measurement_unit, NEW.min_amount, NEW.max_amount, nextval('chemical_analysis_elements_dup_seq')) ;
    RETURN NULL ;
END ;
$$;


--
-- TOC entry 1081 (class 1255 OID 21627)
-- Dependencies: 5 1734
-- Name: chemical_analysis_oxides_sync(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION chemical_analysis_oxides_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO chemical_analysis_oxides_dup(chemical_analysis_id,oxide_id,amount,precision, precision_type,measurement_unit,min_amount,max_amount,id)
    VALUES (NEW.chemical_analysis_id,NEW.oxide_id,NEW.amount,NEW.precision, NEW.precision_type,NEW.measurement_unit,NEW.min_amount,NEW.max_amount, nextval('chemical_analysis_oxides_dup_seq')) ;
    RETURN NULL ;
END ;
$$;


--
-- TOC entry 699 (class 1255 OID 16887)
-- Dependencies: 5 1404 1404 1404
-- Name: collect(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION collect(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'LWGEOM_collect';


--
-- TOC entry 572 (class 1255 OID 16723)
-- Dependencies: 5 1420 1420 1404
-- Name: combine_bbox(box2d, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION combine_bbox(box2d, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_combine';


--
-- TOC entry 574 (class 1255 OID 16725)
-- Dependencies: 5 1412 1412 1404
-- Name: combine_bbox(box3d_extent, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION combine_bbox(box3d_extent, geometry) RETURNS box3d_extent
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX3D_combine';


--
-- TOC entry 576 (class 1255 OID 16729)
-- Dependencies: 1408 1404 1408 5
-- Name: combine_bbox(box3d, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION combine_bbox(box3d, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX3D_combine';


--
-- TOC entry 434 (class 1255 OID 16582)
-- Dependencies: 5 1416
-- Name: compression(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION compression(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getCompression';


--
-- TOC entry 733 (class 1255 OID 16936)
-- Dependencies: 5 1404 1404
-- Name: contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION contains(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'contains';


--
-- TOC entry 680 (class 1255 OID 16868)
-- Dependencies: 5 1404 1404
-- Name: convexhull(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION convexhull(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'convexhull';


--
-- TOC entry 727 (class 1255 OID 16930)
-- Dependencies: 5 1404 1404
-- Name: crosses(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION crosses(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'crosses';


--
-- TOC entry 432 (class 1255 OID 16580)
-- Dependencies: 1416 5
-- Name: datatype(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION datatype(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getDatatype';


--
-- TOC entry 1090 (class 1255 OID 26933)
-- Dependencies: 5 1734
-- Name: denorm_minerals(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION denorm_minerals(input_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
   mineralstr TEXT;
   rec RECORD ;
BEGIN
   mineralstr = '';
   FOR rec IN SELECT m.name FROM sample_minerals s, minerals m 
          WHERE s.mineral_id = m.mineral_id AND s.sample_id = input_id
   LOOP
      mineralstr = mineralstr || rec.name || ', ';
   END LOOP ;

   mineralstr = trim(trailing ', ' from mineralstr);

   return mineralstr ;
END ;
$$;


--
-- TOC entry 689 (class 1255 OID 16877)
-- Dependencies: 1404 1404 1404 5
-- Name: difference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION difference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'difference';


--
-- TOC entry 799 (class 1255 OID 17002)
-- Dependencies: 1404 5
-- Name: dimension(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dimension(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dimension';


--
-- TOC entry 973 (class 1255 OID 17171)
-- Dependencies: 5 1734
-- Name: disablelongtransactions(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION disablelongtransactions() RETURNS text
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	rec RECORD;

BEGIN

	--
	-- Drop all triggers applied by CheckAuth()
	--
	FOR rec IN
		SELECT c.relname, t.tgname, t.tgargs FROM pg_trigger t, pg_class c, pg_proc p
		WHERE p.proname = 'checkauthtrigger' and t.tgfoid = p.oid and t.tgrelid = c.oid
	LOOP
		EXECUTE 'DROP TRIGGER ' || quote_ident(rec.tgname) ||
			' ON ' || quote_ident(rec.relname);
	END LOOP;

	--
	-- Drop the authorization_table table
	--
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorization_table' LOOP
		DROP TABLE authorization_table;
	END LOOP;

	--
	-- Drop the authorized_tables view
	--
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorized_tables' LOOP
		DROP VIEW authorized_tables;
	END LOOP;

	RETURN 'Long transactions support disabled';
END;
$$;


--
-- TOC entry 717 (class 1255 OID 16920)
-- Dependencies: 5 1404 1404
-- Name: disjoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION disjoint(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'disjoint';


--
-- TOC entry 473 (class 1255 OID 16621)
-- Dependencies: 5 1404 1404
-- Name: distance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION distance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_mindistance2d';


--
-- TOC entry 471 (class 1255 OID 16619)
-- Dependencies: 1404 1404 5
-- Name: distance_sphere(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION distance_sphere(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_distance_sphere';


--
-- TOC entry 469 (class 1255 OID 16617)
-- Dependencies: 1404 1400 5 1404
-- Name: distance_spheroid(geometry, geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION distance_spheroid(geometry, geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_distance_ellipsoid';


--
-- TOC entry 417 (class 1255 OID 16565)
-- Dependencies: 5 1404 1404
-- Name: dropbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dropBBOX';


--
-- TOC entry 600 (class 1255 OID 16768)
-- Dependencies: 1734 5
-- Name: dropgeometrycolumn(character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrycolumn(character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret text;
BEGIN
	SELECT DropGeometryColumn('','',$1,$2) into ret;
	RETURN ret;
END;
$_$;


--
-- TOC entry 599 (class 1255 OID 16767)
-- Dependencies: 5 1734
-- Name: dropgeometrycolumn(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrycolumn(character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret text;
BEGIN
	SELECT DropGeometryColumn('',$1,$2,$3) into ret;
	RETURN ret;
END;
$_$;


--
-- TOC entry 598 (class 1255 OID 16766)
-- Dependencies: 1734 5
-- Name: dropgeometrycolumn(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrycolumn(character varying, character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1;
	schema_name alias for $2;
	table_name alias for $3;
	column_name alias for $4;
	myrec RECORD;
	okay boolean;
	real_schema name;

BEGIN


	-- Find, check or fix schema_name
	IF ( schema_name != '' ) THEN
		okay = 'f';

		FOR myrec IN SELECT nspname FROM pg_namespace WHERE text(nspname) = schema_name LOOP
			okay := 't';
		END LOOP;

		IF ( okay <> 't' ) THEN
			RAISE NOTICE 'Invalid schema name - using current_schema()';
			SELECT current_schema() into real_schema;
		ELSE
			real_schema = schema_name;
		END IF;
	ELSE
		SELECT current_schema() into real_schema;
	END IF;

	-- Find out if the column is in the geometry_columns table
	okay = 'f';
	FOR myrec IN SELECT * from geometry_columns where f_table_schema = text(real_schema) and f_table_name = table_name and f_geometry_column = column_name LOOP
		okay := 't';
	END LOOP;
	IF (okay <> 't') THEN
		RAISE EXCEPTION 'column not found in geometry_columns table';
		RETURN 'f';
	END IF;

	-- Remove ref from geometry_columns table
	EXECUTE 'delete from geometry_columns where f_table_schema = ' ||
		quote_literal(real_schema) || ' and f_table_name = ' ||
		quote_literal(table_name)  || ' and f_geometry_column = ' ||
		quote_literal(column_name);

	-- Remove table column
	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) || '.' ||
		quote_ident(table_name) || ' DROP COLUMN ' ||
		quote_ident(column_name);

	RETURN real_schema || '.' || table_name || '.' || column_name ||' effectively removed.';

END;
$_$;


--
-- TOC entry 603 (class 1255 OID 16771)
-- Dependencies: 5
-- Name: dropgeometrytable(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrytable(character varying) RETURNS text
    LANGUAGE sql STRICT
    AS $_$ SELECT DropGeometryTable('','',$1) $_$;


--
-- TOC entry 602 (class 1255 OID 16770)
-- Dependencies: 5
-- Name: dropgeometrytable(character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrytable(character varying, character varying) RETURNS text
    LANGUAGE sql STRICT
    AS $_$ SELECT DropGeometryTable('',$1,$2) $_$;


--
-- TOC entry 601 (class 1255 OID 16769)
-- Dependencies: 1734 5
-- Name: dropgeometrytable(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrytable(character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1;
	schema_name alias for $2;
	table_name alias for $3;
	real_schema name;

BEGIN

	IF ( schema_name = '' ) THEN
		SELECT current_schema() into real_schema;
	ELSE
		real_schema = schema_name;
	END IF;

	-- Remove refs from geometry_columns table
	EXECUTE 'DELETE FROM geometry_columns WHERE ' ||
		'f_table_schema = ' || quote_literal(real_schema) ||
		' AND ' ||
		' f_table_name = ' || quote_literal(table_name);

	-- Remove table
	EXECUTE 'DROP TABLE '
		|| quote_ident(real_schema) || '.' ||
		quote_ident(table_name);

	RETURN
		real_schema || '.' ||
		table_name ||' dropped.';

END;
$_$;


--
-- TOC entry 566 (class 1255 OID 16717)
-- Dependencies: 5 1424 1404
-- Name: dump(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dump(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dump';


--
-- TOC entry 568 (class 1255 OID 16719)
-- Dependencies: 5 1424 1404
-- Name: dumprings(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dumprings(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dump_rings';


--
-- TOC entry 1082 (class 1255 OID 21628)
-- Dependencies: 1734 5
-- Name: element_mineral_types_sync(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION element_mineral_types_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO element_mineral_types_dup(id, element_id, mineral_type_id)
    VALUES (nextval('element_mineral_types_dup_seq'), NEW.element_id, NEW.mineral_type_id) ;
    RETURN NULL ;
END ;
$$;


--
-- TOC entry 971 (class 1255 OID 17169)
-- Dependencies: 5 1734
-- Name: enablelongtransactions(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION enablelongtransactions() RETURNS text
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	"query" text;
	exists bool;
	rec RECORD;

BEGIN

	exists = 'f';
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorization_table'
	LOOP
		exists = 't';
	END LOOP;

	IF NOT exists
	THEN
		"query" = 'CREATE TABLE authorization_table (
			toid oid, -- table oid
			rid text, -- row id
			expires timestamp,
			authid text
		)';
		EXECUTE "query";
	END IF;

	exists = 'f';
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorized_tables'
	LOOP
		exists = 't';
	END LOOP;

	IF NOT exists THEN
		"query" = 'CREATE VIEW authorized_tables AS ' ||
			'SELECT ' ||
			'n.nspname as schema, ' ||
			'c.relname as table, trim(' ||
			quote_literal(chr(92) || '000') ||
			' from t.tgargs) as id_column ' ||
			'FROM pg_trigger t, pg_class c, pg_proc p ' ||
			', pg_namespace n ' ||
			'WHERE p.proname = ' || quote_literal('checkauthtrigger') ||
			' AND c.relnamespace = n.oid' ||
			' AND t.tgfoid = p.oid and t.tgrelid = c.oid';
		EXECUTE "query";
	END IF;

	RETURN 'Long transactions support enabled';
END;
$$;


--
-- TOC entry 823 (class 1255 OID 17026)
-- Dependencies: 5 1404 1404
-- Name: endpoint(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION endpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_endpoint_linestring';


--
-- TOC entry 500 (class 1255 OID 16648)
-- Dependencies: 1404 5 1404
-- Name: envelope(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION envelope(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_envelope';


--
-- TOC entry 755 (class 1255 OID 16958)
-- Dependencies: 1404 1404 5
-- Name: equals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION equals(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geomequals';


--
-- TOC entry 580 (class 1255 OID 16735)
-- Dependencies: 1420 5
-- Name: estimated_extent(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION estimated_extent(text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-1.5', 'LWGEOM_estimated_extent';


--
-- TOC entry 578 (class 1255 OID 16733)
-- Dependencies: 1420 5
-- Name: estimated_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION estimated_extent(text, text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-1.5', 'LWGEOM_estimated_extent';


--
-- TOC entry 494 (class 1255 OID 16642)
-- Dependencies: 1408 5 1408
-- Name: expand(box3d, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION expand(box3d, double precision) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_expand';


--
-- TOC entry 496 (class 1255 OID 16644)
-- Dependencies: 1420 5 1420
-- Name: expand(box2d, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION expand(box2d, double precision) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_expand';


--
-- TOC entry 498 (class 1255 OID 16646)
-- Dependencies: 1404 5 1404
-- Name: expand(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION expand(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_expand';


--
-- TOC entry 801 (class 1255 OID 17004)
-- Dependencies: 1404 5 1404
-- Name: exteriorring(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION exteriorring(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_exteriorring_polygon';


--
-- TOC entry 428 (class 1255 OID 16576)
-- Dependencies: 5 1416
-- Name: factor(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION factor(chip) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getFactor';


--
-- TOC entry 584 (class 1255 OID 16739)
-- Dependencies: 5 1420 1734
-- Name: find_extent(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION find_extent(text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	tablename alias for $1;
	columnname alias for $2;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT extent("' || columnname || '") FROM "' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


--
-- TOC entry 582 (class 1255 OID 16737)
-- Dependencies: 1420 5 1734
-- Name: find_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION find_extent(text, text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	schemaname alias for $1;
	tablename alias for $2;
	columnname alias for $3;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT extent("' || columnname || '") FROM "' || schemaname || '"."' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


--
-- TOC entry 609 (class 1255 OID 16775)
-- Dependencies: 1734 5
-- Name: find_srid(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION find_srid(character varying, character varying, character varying) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	schem text;
	tabl text;
	sr int4;
BEGIN
	IF $1 IS NULL THEN
	  RAISE EXCEPTION 'find_srid() - schema is NULL!';
	END IF;
	IF $2 IS NULL THEN
	  RAISE EXCEPTION 'find_srid() - table name is NULL!';
	END IF;
	IF $3 IS NULL THEN
	  RAISE EXCEPTION 'find_srid() - column name is NULL!';
	END IF;
	schem = $1;
	tabl = $2;
-- if the table contains a . and the schema is empty
-- split the table into a schema and a table
-- otherwise drop through to default behavior
	IF ( schem = '' and tabl LIKE '%.%' ) THEN
	 schem = substr(tabl,1,strpos(tabl,'.')-1);
	 tabl = substr(tabl,length(schem)+2);
	ELSE
	 schem = schem || '%';
	END IF;

	select SRID into sr from geometry_columns where f_table_schema like schem and f_table_name = tabl and f_geometry_column = $3;
	IF NOT FOUND THEN
	   RAISE EXCEPTION 'find_srid() - couldnt find the corresponding SRID - is the geometry registered in the GEOMETRY_COLUMNS table?  Is there an uppercase/lowercase missmatch?';
	END IF;
	return sr;
END;
$_$;


--
-- TOC entry 587 (class 1255 OID 16758)
-- Dependencies: 1734 5
-- Name: fix_geometry_columns(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fix_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	mislinked record;
	result text;
	linked integer;
	deleted integer;
	foundschema integer;
BEGIN

	-- Since 7.3 schema support has been added.
	-- Previous postgis versions used to put the database name in
	-- the schema column. This needs to be fixed, so we try to
	-- set the correct schema for each geometry_colums record
	-- looking at table, column, type and srid.
	UPDATE geometry_columns SET f_table_schema = n.nspname
		FROM pg_namespace n, pg_class c, pg_attribute a,
			pg_constraint sridcheck, pg_constraint typecheck
			WHERE ( f_table_schema is NULL
		OR f_table_schema = ''
			OR f_table_schema NOT IN (
					SELECT nspname::varchar
					FROM pg_namespace nn, pg_class cc, pg_attribute aa
					WHERE cc.relnamespace = nn.oid
					AND cc.relname = f_table_name::name
					AND aa.attrelid = cc.oid
					AND aa.attname = f_geometry_column::name))
			AND f_table_name::name = c.relname
			AND c.oid = a.attrelid
			AND c.relnamespace = n.oid
			AND f_geometry_column::name = a.attname

			AND sridcheck.conrelid = c.oid
		AND sridcheck.consrc LIKE '(srid(% = %)'
			AND sridcheck.consrc ~ textcat(' = ', srid::text)

			AND typecheck.conrelid = c.oid
		AND typecheck.consrc LIKE
		'((geometrytype(%) = ''%''::text) OR (% IS NULL))'
			AND typecheck.consrc ~ textcat(' = ''', type::text)

			AND NOT EXISTS (
					SELECT oid FROM geometry_columns gc
					WHERE c.relname::varchar = gc.f_table_name
					AND n.nspname::varchar = gc.f_table_schema
					AND a.attname::varchar = gc.f_geometry_column
			);

	GET DIAGNOSTICS foundschema = ROW_COUNT;

	-- no linkage to system table needed
	return 'fixed:'||foundschema::text;

END;
$$;


--
-- TOC entry 479 (class 1255 OID 16627)
-- Dependencies: 5 1404 1404
-- Name: force_2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION force_2d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_2d';


--
-- TOC entry 483 (class 1255 OID 16631)
-- Dependencies: 5 1404 1404
-- Name: force_3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION force_3d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dz';


--
-- TOC entry 485 (class 1255 OID 16633)
-- Dependencies: 1404 1404 5
-- Name: force_3dm(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION force_3dm(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dm';


--
-- TOC entry 481 (class 1255 OID 16629)
-- Dependencies: 1404 5 1404
-- Name: force_3dz(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION force_3dz(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dz';


--
-- TOC entry 487 (class 1255 OID 16635)
-- Dependencies: 1404 1404 5
-- Name: force_4d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION force_4d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_4d';


--
-- TOC entry 489 (class 1255 OID 16637)
-- Dependencies: 1404 1404 5
-- Name: force_collection(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION force_collection(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_collection';


--
-- TOC entry 504 (class 1255 OID 16652)
-- Dependencies: 1404 1404 5
-- Name: forcerhr(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION forcerhr(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_forceRHR_poly';


--
-- TOC entry 1001 (class 1255 OID 17214)
-- Dependencies: 5 1431 1404
-- Name: geography(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography(geometry) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_from_geometry';


--
-- TOC entry 990 (class 1255 OID 17197)
-- Dependencies: 5 1431 1431
-- Name: geography(geography, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography(geography, integer, boolean) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_enforce_typmod';


--
-- TOC entry 1018 (class 1255 OID 17244)
-- Dependencies: 5 1431 1431
-- Name: geography_cmp(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_cmp(geography, geography) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_cmp';


--
-- TOC entry 1017 (class 1255 OID 17243)
-- Dependencies: 1431 5 1431
-- Name: geography_eq(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_eq(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_eq';


--
-- TOC entry 1016 (class 1255 OID 17242)
-- Dependencies: 1431 5 1431
-- Name: geography_ge(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_ge(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_ge';


--
-- TOC entry 1004 (class 1255 OID 17219)
-- Dependencies: 5
-- Name: geography_gist_compress(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_compress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_compress';


--
-- TOC entry 1003 (class 1255 OID 17218)
-- Dependencies: 5 1404
-- Name: geography_gist_consistent(internal, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_consistent(internal, geometry, integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_consistent';


--
-- TOC entry 1009 (class 1255 OID 17224)
-- Dependencies: 5
-- Name: geography_gist_decompress(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_decompress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_decompress';


--
-- TOC entry 1011 (class 1255 OID 17226)
-- Dependencies: 5
-- Name: geography_gist_join_selectivity(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_join_selectivity(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_join_selectivity';


--
-- TOC entry 1005 (class 1255 OID 17220)
-- Dependencies: 5
-- Name: geography_gist_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_penalty';


--
-- TOC entry 1006 (class 1255 OID 17221)
-- Dependencies: 5
-- Name: geography_gist_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_picksplit(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_picksplit';


--
-- TOC entry 1008 (class 1255 OID 17223)
-- Dependencies: 5 1420 1420
-- Name: geography_gist_same(box2d, box2d, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_same(box2d, box2d, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_same';


--
-- TOC entry 1010 (class 1255 OID 17225)
-- Dependencies: 5
-- Name: geography_gist_selectivity(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_selectivity(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_selectivity';


--
-- TOC entry 1007 (class 1255 OID 17222)
-- Dependencies: 5
-- Name: geography_gist_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_union(bytea, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_union';


--
-- TOC entry 1015 (class 1255 OID 17241)
-- Dependencies: 5 1431 1431
-- Name: geography_gt(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gt(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_gt';


--
-- TOC entry 1014 (class 1255 OID 17240)
-- Dependencies: 5 1431 1431
-- Name: geography_le(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_le(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_le';


--
-- TOC entry 1013 (class 1255 OID 17239)
-- Dependencies: 1431 1431 5
-- Name: geography_lt(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_lt(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_lt';


--
-- TOC entry 1012 (class 1255 OID 17227)
-- Dependencies: 5 1431 1431
-- Name: geography_overlaps(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_overlaps(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_overlaps';


--
-- TOC entry 998 (class 1255 OID 17206)
-- Dependencies: 5
-- Name: geography_typmod_dims(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_typmod_dims(integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_dims';


--
-- TOC entry 999 (class 1255 OID 17207)
-- Dependencies: 5
-- Name: geography_typmod_srid(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_typmod_srid(integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_srid';


--
-- TOC entry 1000 (class 1255 OID 17208)
-- Dependencies: 5
-- Name: geography_typmod_type(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_typmod_type(integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_type';


--
-- TOC entry 891 (class 1255 OID 17093)
-- Dependencies: 1404 5
-- Name: geomcollfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomcollfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 889 (class 1255 OID 17091)
-- Dependencies: 1404 5
-- Name: geomcollfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomcollfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 943 (class 1255 OID 17144)
-- Dependencies: 5 1404
-- Name: geomcollfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomcollfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromWKB($1)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 941 (class 1255 OID 17142)
-- Dependencies: 1404 5
-- Name: geomcollfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomcollfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromWKB($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 345 (class 1255 OID 16443)
-- Dependencies: 1404 5 1412
-- Name: geometry(box3d_extent); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(box3d_extent) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_LWGEOM';


--
-- TOC entry 643 (class 1255 OID 16815)
-- Dependencies: 1420 5 1404
-- Name: geometry(box2d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(box2d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_to_LWGEOM';


--
-- TOC entry 644 (class 1255 OID 16816)
-- Dependencies: 1404 5 1408
-- Name: geometry(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(box3d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_LWGEOM';


--
-- TOC entry 645 (class 1255 OID 16817)
-- Dependencies: 5 1404
-- Name: geometry(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'parse_WKT_lwgeom';


--
-- TOC entry 646 (class 1255 OID 16818)
-- Dependencies: 1404 5 1416
-- Name: geometry(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(chip) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_to_LWGEOM';


--
-- TOC entry 647 (class 1255 OID 16819)
-- Dependencies: 1404 5
-- Name: geometry(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_bytea';


--
-- TOC entry 1002 (class 1255 OID 17216)
-- Dependencies: 5 1404 1431
-- Name: geometry(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(geography) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geometry_from_geography';


--
-- TOC entry 402 (class 1255 OID 16517)
-- Dependencies: 1404 5 1404
-- Name: geometry_above(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_above(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_above';


--
-- TOC entry 403 (class 1255 OID 16518)
-- Dependencies: 1404 5 1404
-- Name: geometry_below(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_below(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_below';


--
-- TOC entry 376 (class 1255 OID 16478)
-- Dependencies: 1404 5 1404
-- Name: geometry_cmp(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_cmp(geometry, geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_cmp';


--
-- TOC entry 404 (class 1255 OID 16519)
-- Dependencies: 1404 5 1404
-- Name: geometry_contain(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_contain(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_contain';


--
-- TOC entry 405 (class 1255 OID 16520)
-- Dependencies: 1404 5 1404
-- Name: geometry_contained(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_contained(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_contained';


--
-- TOC entry 375 (class 1255 OID 16477)
-- Dependencies: 1404 5 1404
-- Name: geometry_eq(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_eq(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_eq';


--
-- TOC entry 374 (class 1255 OID 16476)
-- Dependencies: 1404 5 1404
-- Name: geometry_ge(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_ge(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_ge';


--
-- TOC entry 395 (class 1255 OID 16510)
-- Dependencies: 5
-- Name: geometry_gist_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_joinsel(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_joinsel';


--
-- TOC entry 394 (class 1255 OID 16509)
-- Dependencies: 5
-- Name: geometry_gist_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_sel(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_sel';


--
-- TOC entry 373 (class 1255 OID 16475)
-- Dependencies: 1404 5 1404
-- Name: geometry_gt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_gt';


--
-- TOC entry 372 (class 1255 OID 16474)
-- Dependencies: 5 1404 1404
-- Name: geometry_le(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_le(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_le';


--
-- TOC entry 400 (class 1255 OID 16515)
-- Dependencies: 5 1404 1404
-- Name: geometry_left(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_left(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_left';


--
-- TOC entry 371 (class 1255 OID 16473)
-- Dependencies: 1404 5 1404
-- Name: geometry_lt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_lt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_lt';


--
-- TOC entry 398 (class 1255 OID 16513)
-- Dependencies: 5 1404 1404
-- Name: geometry_overabove(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overabove(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overabove';


--
-- TOC entry 399 (class 1255 OID 16514)
-- Dependencies: 1404 5 1404
-- Name: geometry_overbelow(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overbelow(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overbelow';


--
-- TOC entry 406 (class 1255 OID 16521)
-- Dependencies: 1404 5 1404
-- Name: geometry_overlap(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overlap(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overlap';


--
-- TOC entry 396 (class 1255 OID 16511)
-- Dependencies: 1404 5 1404
-- Name: geometry_overleft(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overleft(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overleft';


--
-- TOC entry 397 (class 1255 OID 16512)
-- Dependencies: 1404 5 1404
-- Name: geometry_overright(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overright(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overright';


--
-- TOC entry 401 (class 1255 OID 16516)
-- Dependencies: 1404 5 1404
-- Name: geometry_right(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_right(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_right';


--
-- TOC entry 393 (class 1255 OID 16508)
-- Dependencies: 1404 5 1404
-- Name: geometry_same(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_same(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_samebox';


--
-- TOC entry 407 (class 1255 OID 16522)
-- Dependencies: 1404 5 1404
-- Name: geometry_samebox(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_samebox(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_samebox';


--
-- TOC entry 839 (class 1255 OID 17042)
-- Dependencies: 5 1404
-- Name: geometryfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometryfromtext(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


--
-- TOC entry 841 (class 1255 OID 17044)
-- Dependencies: 1404 5
-- Name: geometryfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometryfromtext(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


--
-- TOC entry 797 (class 1255 OID 17000)
-- Dependencies: 1404 1404 5
-- Name: geometryn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometryn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_geometryn_collection';


--
-- TOC entry 809 (class 1255 OID 17012)
-- Dependencies: 5 1404
-- Name: geometrytype(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometrytype(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_getTYPE';


--
-- TOC entry 522 (class 1255 OID 16670)
-- Dependencies: 5 1404
-- Name: geomfromewkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomfromewkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOMFromWKB';


--
-- TOC entry 524 (class 1255 OID 16672)
-- Dependencies: 5 1404
-- Name: geomfromewkt(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomfromewkt(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'parse_WKT_lwgeom';


--
-- TOC entry 843 (class 1255 OID 17046)
-- Dependencies: 1404 5
-- Name: geomfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geometryfromtext($1)$_$;


--
-- TOC entry 845 (class 1255 OID 17048)
-- Dependencies: 5 1404
-- Name: geomfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geometryfromtext($1, $2)$_$;


--
-- TOC entry 893 (class 1255 OID 17095)
-- Dependencies: 5 1404
-- Name: geomfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomfromwkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_WKB';


--
-- TOC entry 895 (class 1255 OID 17097)
-- Dependencies: 1404 5
-- Name: geomfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT setSRID(GeomFromWKB($1), $2)$_$;


--
-- TOC entry 697 (class 1255 OID 16885)
-- Dependencies: 5 1404 1404 1404
-- Name: geomunion(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomunion(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geomunion';


--
-- TOC entry 610 (class 1255 OID 16776)
-- Dependencies: 5 1734
-- Name: get_proj4_from_srid(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION get_proj4_from_srid(integer) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
BEGIN
	RETURN proj4text::text FROM spatial_ref_sys WHERE srid= $1;
END;
$_$;


--
-- TOC entry 420 (class 1255 OID 16568)
-- Dependencies: 1420 5 1404
-- Name: getbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION getbbox(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX2DFLOAT4';


--
-- TOC entry 419 (class 1255 OID 16567)
-- Dependencies: 1404 5
-- Name: getsrid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION getsrid(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_getSRID';


--
-- TOC entry 970 (class 1255 OID 17168)
-- Dependencies: 5
-- Name: gettransactionid(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gettransactionid() RETURNS xid
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'getTransactionID';


--
-- TOC entry 422 (class 1255 OID 16570)
-- Dependencies: 1404 5
-- Name: hasbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION hasbbox(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_hasBBOX';


--
-- TOC entry 426 (class 1255 OID 16574)
-- Dependencies: 5 1416
-- Name: height(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION height(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getHeight';


--
-- TOC entry 807 (class 1255 OID 17010)
-- Dependencies: 1404 5 1404
-- Name: interiorringn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION interiorringn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_interiorringn_polygon';


--
-- TOC entry 672 (class 1255 OID 16860)
-- Dependencies: 1404 5 1404 1404
-- Name: intersection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION intersection(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'intersection';


--
-- TOC entry 724 (class 1255 OID 16927)
-- Dependencies: 5 1404 1404
-- Name: intersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION intersects(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'intersects';


--
-- TOC entry 825 (class 1255 OID 17028)
-- Dependencies: 1404 5
-- Name: isclosed(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION isclosed(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_isclosed_linestring';


--
-- TOC entry 827 (class 1255 OID 17030)
-- Dependencies: 5 1404
-- Name: isempty(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION isempty(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_isempty';


--
-- TOC entry 749 (class 1255 OID 16952)
-- Dependencies: 5 1404
-- Name: isring(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION isring(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'isring';


--
-- TOC entry 753 (class 1255 OID 16956)
-- Dependencies: 1404 5
-- Name: issimple(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION issimple(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'issimple';


--
-- TOC entry 745 (class 1255 OID 16948)
-- Dependencies: 1404 5
-- Name: isvalid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION isvalid(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'isvalid';


--
-- TOC entry 451 (class 1255 OID 16599)
-- Dependencies: 1404 5
-- Name: length(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION length(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length_linestring';


--
-- TOC entry 449 (class 1255 OID 16597)
-- Dependencies: 5 1404
-- Name: length2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION length2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_linestring';


--
-- TOC entry 457 (class 1255 OID 16605)
-- Dependencies: 1404 5 1400
-- Name: length2d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION length2d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_ellipsoid';


--
-- TOC entry 447 (class 1255 OID 16595)
-- Dependencies: 5 1404
-- Name: length3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION length3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length_linestring';


--
-- TOC entry 453 (class 1255 OID 16601)
-- Dependencies: 1400 5 1404
-- Name: length3d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION length3d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length_ellipsoid_linestring';


--
-- TOC entry 455 (class 1255 OID 16603)
-- Dependencies: 1404 5 1400
-- Name: length_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION length_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length_ellipsoid_linestring';


--
-- TOC entry 661 (class 1255 OID 16849)
-- Dependencies: 1404 1404 5
-- Name: line_interpolate_point(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION line_interpolate_point(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_interpolate_point';


--
-- TOC entry 665 (class 1255 OID 16853)
-- Dependencies: 5 1404 1404
-- Name: line_locate_point(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION line_locate_point(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_locate_point';


--
-- TOC entry 663 (class 1255 OID 16851)
-- Dependencies: 5 1404 1404
-- Name: line_substring(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION line_substring(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_substring';


--
-- TOC entry 542 (class 1255 OID 16690)
-- Dependencies: 1404 5 1404
-- Name: linefrommultipoint(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linefrommultipoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_from_mpoint';


--
-- TOC entry 851 (class 1255 OID 17054)
-- Dependencies: 1404 5
-- Name: linefromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'LINESTRING'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 854 (class 1255 OID 17056)
-- Dependencies: 1404 5
-- Name: linefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'LINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 903 (class 1255 OID 17105)
-- Dependencies: 5 1404
-- Name: linefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'LINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 901 (class 1255 OID 17103)
-- Dependencies: 5 1404
-- Name: linefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 564 (class 1255 OID 16712)
-- Dependencies: 5 1404 1404
-- Name: linemerge(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linemerge(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'linemerge';


--
-- TOC entry 856 (class 1255 OID 17058)
-- Dependencies: 1404 5
-- Name: linestringfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linestringfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT LineFromText($1)$_$;


--
-- TOC entry 857 (class 1255 OID 17059)
-- Dependencies: 1404 5
-- Name: linestringfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linestringfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT LineFromText($1, $2)$_$;


--
-- TOC entry 907 (class 1255 OID 17109)
-- Dependencies: 5 1404
-- Name: linestringfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linestringfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'LINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 905 (class 1255 OID 17107)
-- Dependencies: 1404 5
-- Name: linestringfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION linestringfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 669 (class 1255 OID 16857)
-- Dependencies: 1404 5 1404
-- Name: locate_along_measure(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION locate_along_measure(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT locate_between_measures($1, $2, $2) $_$;


--
-- TOC entry 667 (class 1255 OID 16855)
-- Dependencies: 1404 5 1404
-- Name: locate_between_measures(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION locate_between_measures(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_locate_between_m';


--
-- TOC entry 961 (class 1255 OID 17162)
-- Dependencies: 5
-- Name: lockrow(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lockrow(text, text, text) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$ SELECT LockRow(current_schema(), $1, $2, $3, now()::timestamp+'1:00'); $_$;


--
-- TOC entry 960 (class 1255 OID 17161)
-- Dependencies: 5
-- Name: lockrow(text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lockrow(text, text, text, text) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$ SELECT LockRow($1, $2, $3, $4, now()::timestamp+'1:00'); $_$;


--
-- TOC entry 962 (class 1255 OID 17163)
-- Dependencies: 5
-- Name: lockrow(text, text, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lockrow(text, text, text, timestamp without time zone) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$ SELECT LockRow(current_schema(), $1, $2, $3, $4); $_$;


--
-- TOC entry 959 (class 1255 OID 17160)
-- Dependencies: 5 1734
-- Name: lockrow(text, text, text, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lockrow(text, text, text, text, timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$ 
DECLARE
	myschema alias for $1;
	mytable alias for $2;
	myrid   alias for $3;
	authid alias for $4;
	expires alias for $5;
	ret int;
	mytoid oid;
	myrec RECORD;
	
BEGIN

	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	EXECUTE 'DELETE FROM authorization_table WHERE expires < now()'; 

	SELECT c.oid INTO mytoid FROM pg_class c, pg_namespace n
		WHERE c.relname = mytable
		AND c.relnamespace = n.oid
		AND n.nspname = myschema;

	-- RAISE NOTICE 'toid: %', mytoid;

	FOR myrec IN SELECT * FROM authorization_table WHERE 
		toid = mytoid AND rid = myrid
	LOOP
		IF myrec.authid != authid THEN
			RETURN 0;
		ELSE
			RETURN 1;
		END IF;
	END LOOP;

	EXECUTE 'INSERT INTO authorization_table VALUES ('||
		quote_literal(mytoid::text)||','||quote_literal(myrid)||
		','||quote_literal(expires::text)||
		','||quote_literal(authid) ||')';

	GET DIAGNOSTICS ret = ROW_COUNT;

	RETURN ret;
END;
$_$;


--
-- TOC entry 972 (class 1255 OID 17170)
-- Dependencies: 1734 5
-- Name: longtransactionsenabled(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION longtransactionsenabled() RETURNS boolean
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	rec RECORD;
BEGIN
	FOR rec IN SELECT oid FROM pg_class WHERE relname = 'authorized_tables'
	LOOP
		return 't';
	END LOOP;
	return 'f';
END;
$$;


--
-- TOC entry 409 (class 1255 OID 16536)
-- Dependencies: 5
-- Name: lwgeom_gist_compress(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lwgeom_gist_compress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_compress';


--
-- TOC entry 408 (class 1255 OID 16535)
-- Dependencies: 5 1404
-- Name: lwgeom_gist_consistent(internal, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lwgeom_gist_consistent(internal, geometry, integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_consistent';


--
-- TOC entry 414 (class 1255 OID 16541)
-- Dependencies: 5
-- Name: lwgeom_gist_decompress(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lwgeom_gist_decompress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_decompress';


--
-- TOC entry 410 (class 1255 OID 16537)
-- Dependencies: 5
-- Name: lwgeom_gist_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lwgeom_gist_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_penalty';


--
-- TOC entry 411 (class 1255 OID 16538)
-- Dependencies: 5
-- Name: lwgeom_gist_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lwgeom_gist_picksplit(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_picksplit';


--
-- TOC entry 413 (class 1255 OID 16540)
-- Dependencies: 5 1420 1420
-- Name: lwgeom_gist_same(box2d, box2d, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lwgeom_gist_same(box2d, box2d, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_same';


--
-- TOC entry 412 (class 1255 OID 16539)
-- Dependencies: 5
-- Name: lwgeom_gist_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lwgeom_gist_union(bytea, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_union';


--
-- TOC entry 819 (class 1255 OID 17022)
-- Dependencies: 5 1404
-- Name: m(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION m(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_m_point';


--
-- TOC entry 535 (class 1255 OID 16683)
-- Dependencies: 1404 1404 1420 5
-- Name: makebox2d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makebox2d(geometry, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_construct';


--
-- TOC entry 537 (class 1255 OID 16685)
-- Dependencies: 1408 1404 1404 5
-- Name: makebox3d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makebox3d(geometry, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_construct';


--
-- TOC entry 544 (class 1255 OID 16692)
-- Dependencies: 1404 5 1404 1404
-- Name: makeline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makeline(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline';


--
-- TOC entry 539 (class 1255 OID 16687)
-- Dependencies: 1406 5 1404
-- Name: makeline_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makeline_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline_garray';


--
-- TOC entry 527 (class 1255 OID 16675)
-- Dependencies: 1404 5
-- Name: makepoint(double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makepoint(double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


--
-- TOC entry 529 (class 1255 OID 16677)
-- Dependencies: 1404 5
-- Name: makepoint(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makepoint(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


--
-- TOC entry 531 (class 1255 OID 16679)
-- Dependencies: 1404 5
-- Name: makepoint(double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makepoint(double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


--
-- TOC entry 533 (class 1255 OID 16681)
-- Dependencies: 1404 5
-- Name: makepointm(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makepointm(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint3dm';


--
-- TOC entry 557 (class 1255 OID 16705)
-- Dependencies: 5 1404 1404
-- Name: makepolygon(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makepolygon(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoly';


--
-- TOC entry 555 (class 1255 OID 16703)
-- Dependencies: 1406 5 1404 1404
-- Name: makepolygon(geometry, geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makepolygon(geometry, geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoly';


--
-- TOC entry 945 (class 1255 OID 17146)
-- Dependencies: 5 1404 1404
-- Name: max_distance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION max_distance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_maxdistance2d_linestring';


--
-- TOC entry 439 (class 1255 OID 16587)
-- Dependencies: 1404 5
-- Name: mem_size(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mem_size(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_mem_size';


--
-- TOC entry 868 (class 1255 OID 17070)
-- Dependencies: 5 1404
-- Name: mlinefromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mlinefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'MULTILINESTRING'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 866 (class 1255 OID 17068)
-- Dependencies: 5 1404
-- Name: mlinefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mlinefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 931 (class 1255 OID 17132)
-- Dependencies: 1404 5
-- Name: mlinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mlinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 929 (class 1255 OID 17130)
-- Dependencies: 1404 5
-- Name: mlinefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mlinefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 876 (class 1255 OID 17078)
-- Dependencies: 5 1404
-- Name: mpointfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mpointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'MULTIPOINT'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 874 (class 1255 OID 17076)
-- Dependencies: 1404 5
-- Name: mpointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mpointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1,$2)) = 'MULTIPOINT'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 920 (class 1255 OID 17121)
-- Dependencies: 5 1404
-- Name: mpointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mpointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOINT'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 918 (class 1255 OID 17119)
-- Dependencies: 5 1404
-- Name: mpointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mpointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1,$2)) = 'MULTIPOINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 883 (class 1255 OID 17085)
-- Dependencies: 5 1404
-- Name: mpolyfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mpolyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'MULTIPOLYGON'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 881 (class 1255 OID 17083)
-- Dependencies: 5 1404
-- Name: mpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'MULTIPOLYGON'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 935 (class 1255 OID 17136)
-- Dependencies: 5 1404
-- Name: mpolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mpolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 933 (class 1255 OID 17134)
-- Dependencies: 1404 5
-- Name: mpolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mpolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 492 (class 1255 OID 16640)
-- Dependencies: 1404 5 1404
-- Name: multi(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multi(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_multi';


--
-- TOC entry 927 (class 1255 OID 17128)
-- Dependencies: 1404 5
-- Name: multilinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multilinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 926 (class 1255 OID 17127)
-- Dependencies: 1404 5
-- Name: multilinefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multilinefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 870 (class 1255 OID 17072)
-- Dependencies: 5 1404
-- Name: multilinestringfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multilinestringfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MLineFromText($1)$_$;


--
-- TOC entry 872 (class 1255 OID 17074)
-- Dependencies: 5 1404
-- Name: multilinestringfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multilinestringfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MLineFromText($1, $2)$_$;


--
-- TOC entry 879 (class 1255 OID 17081)
-- Dependencies: 5 1404
-- Name: multipointfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multipointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPointFromText($1)$_$;


--
-- TOC entry 878 (class 1255 OID 17080)
-- Dependencies: 5 1404
-- Name: multipointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multipointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPointFromText($1, $2)$_$;


--
-- TOC entry 924 (class 1255 OID 17125)
-- Dependencies: 1404 5
-- Name: multipointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multipointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOINT'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 922 (class 1255 OID 17123)
-- Dependencies: 5 1404
-- Name: multipointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multipointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1,$2)) = 'MULTIPOINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 939 (class 1255 OID 17140)
-- Dependencies: 1404 5
-- Name: multipolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multipolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 937 (class 1255 OID 17138)
-- Dependencies: 5 1404
-- Name: multipolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multipolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 887 (class 1255 OID 17089)
-- Dependencies: 5 1404
-- Name: multipolygonfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multipolygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1)$_$;


--
-- TOC entry 885 (class 1255 OID 17087)
-- Dependencies: 5 1404
-- Name: multipolygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION multipolygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1, $2)$_$;


--
-- TOC entry 510 (class 1255 OID 16658)
-- Dependencies: 1404 5
-- Name: ndims(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ndims(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_ndims';


--
-- TOC entry 506 (class 1255 OID 16654)
-- Dependencies: 1404 1404 5
-- Name: noop(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION noop(geometry) RETURNS geometry
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_noop';


--
-- TOC entry 443 (class 1255 OID 16591)
-- Dependencies: 1404 5
-- Name: npoints(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION npoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_npoints';


--
-- TOC entry 445 (class 1255 OID 16593)
-- Dependencies: 5 1404
-- Name: nrings(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_nrings';


--
-- TOC entry 795 (class 1255 OID 16998)
-- Dependencies: 5 1404
-- Name: numgeometries(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION numgeometries(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numgeometries_collection';


--
-- TOC entry 805 (class 1255 OID 17008)
-- Dependencies: 1404 5
-- Name: numinteriorring(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION numinteriorring(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numinteriorrings_polygon';


--
-- TOC entry 803 (class 1255 OID 17006)
-- Dependencies: 5 1404
-- Name: numinteriorrings(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION numinteriorrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numinteriorrings_polygon';


--
-- TOC entry 793 (class 1255 OID 16996)
-- Dependencies: 5 1404
-- Name: numpoints(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION numpoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numpoints_linestring';


--
-- TOC entry 742 (class 1255 OID 16945)
-- Dependencies: 1404 1404 5
-- Name: overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "overlaps"(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'overlaps';


--
-- TOC entry 463 (class 1255 OID 16611)
-- Dependencies: 1404 5
-- Name: perimeter(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION perimeter(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter_poly';


--
-- TOC entry 461 (class 1255 OID 16609)
-- Dependencies: 5 1404
-- Name: perimeter2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION perimeter2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter2d_poly';


--
-- TOC entry 459 (class 1255 OID 16607)
-- Dependencies: 5 1404
-- Name: perimeter3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION perimeter3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter_poly';


--
-- TOC entry 705 (class 1255 OID 16899)
-- Dependencies: 5 1406 1427
-- Name: pgis_geometry_accum_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_accum_finalfn(pgis_abs) RETURNS geometry[]
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_accum_finalfn';


--
-- TOC entry 704 (class 1255 OID 16898)
-- Dependencies: 5 1427 1427 1404
-- Name: pgis_geometry_accum_transfn(pgis_abs, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_accum_transfn(pgis_abs, geometry) RETURNS pgis_abs
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_accum_transfn';


--
-- TOC entry 707 (class 1255 OID 16901)
-- Dependencies: 5 1404 1427
-- Name: pgis_geometry_collect_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_collect_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_collect_finalfn';


--
-- TOC entry 709 (class 1255 OID 16903)
-- Dependencies: 5 1404 1427
-- Name: pgis_geometry_makeline_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_makeline_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_makeline_finalfn';


--
-- TOC entry 708 (class 1255 OID 16902)
-- Dependencies: 5 1404 1427
-- Name: pgis_geometry_polygonize_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_polygonize_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_polygonize_finalfn';


--
-- TOC entry 706 (class 1255 OID 16900)
-- Dependencies: 5 1404 1427
-- Name: pgis_geometry_union_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_union_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_union_finalfn';


--
-- TOC entry 475 (class 1255 OID 16623)
-- Dependencies: 5 1404
-- Name: point_inside_circle(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION point_inside_circle(geometry, double precision, double precision, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_inside_circle_point';


--
-- TOC entry 847 (class 1255 OID 17050)
-- Dependencies: 5 1404
-- Name: pointfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'POINT'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 849 (class 1255 OID 17052)
-- Dependencies: 5 1404
-- Name: pointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'POINT'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 899 (class 1255 OID 17101)
-- Dependencies: 1404 5
-- Name: pointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POINT'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 897 (class 1255 OID 17099)
-- Dependencies: 1404 5
-- Name: pointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'POINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 811 (class 1255 OID 17014)
-- Dependencies: 5 1404 1404
-- Name: pointn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pointn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_pointn_linestring';


--
-- TOC entry 751 (class 1255 OID 16954)
-- Dependencies: 1404 5 1404
-- Name: pointonsurface(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pointonsurface(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pointonsurface';


--
-- TOC entry 858 (class 1255 OID 17060)
-- Dependencies: 5 1404
-- Name: polyfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION polyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'POLYGON'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 860 (class 1255 OID 17062)
-- Dependencies: 1404 5
-- Name: polyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION polyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'POLYGON'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 911 (class 1255 OID 17113)
-- Dependencies: 5 1404
-- Name: polyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION polyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 909 (class 1255 OID 17111)
-- Dependencies: 1404 5
-- Name: polyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION polyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'POLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 864 (class 1255 OID 17066)
-- Dependencies: 1404 5
-- Name: polygonfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION polygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT PolyFromText($1)$_$;


--
-- TOC entry 862 (class 1255 OID 17064)
-- Dependencies: 1404 5
-- Name: polygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION polygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT PolyFromText($1, $2)$_$;


--
-- TOC entry 916 (class 1255 OID 17117)
-- Dependencies: 1404 5
-- Name: polygonfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION polygonfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 913 (class 1255 OID 17115)
-- Dependencies: 1404 5
-- Name: polygonfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION polygonfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1,$2)) = 'POLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 561 (class 1255 OID 16709)
-- Dependencies: 5 1406 1404
-- Name: polygonize_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION polygonize_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'polygonize_garray';


--
-- TOC entry 588 (class 1255 OID 16759)
-- Dependencies: 5 1734
-- Name: populate_geometry_columns(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION populate_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	inserted    integer;
	oldcount    integer;
	probed      integer;
	stale       integer;
	gcs         RECORD;
	gc          RECORD;
	gsrid       integer;
	gndims      integer;
	gtype       text;
	query       text;
	gc_is_valid boolean;

BEGIN
	SELECT count(*) INTO oldcount FROM geometry_columns;
	inserted := 0;

	EXECUTE 'TRUNCATE geometry_columns';

	-- Count the number of geometry columns in all tables and views
	SELECT count(DISTINCT c.oid) INTO probed
	FROM pg_class c,
		 pg_attribute a,
		 pg_type t,
		 pg_namespace n
	WHERE (c.relkind = 'r' OR c.relkind = 'v')
	AND t.typname = 'geometry'
	AND a.attisdropped = false
	AND a.atttypid = t.oid
	AND a.attrelid = c.oid
	AND c.relnamespace = n.oid
	AND n.nspname NOT ILIKE 'pg_temp%';

	-- Iterate through all non-dropped geometry columns
	RAISE DEBUG 'Processing Tables.....';

	FOR gcs IN
	SELECT DISTINCT ON (c.oid) c.oid, n.nspname, c.relname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'r'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND n.nspname NOT ILIKE 'pg_temp%'
	LOOP

	inserted := inserted + populate_geometry_columns(gcs.oid);
	END LOOP;

	-- Add views to geometry columns table
	RAISE DEBUG 'Processing Views.....';
	FOR gcs IN
	SELECT DISTINCT ON (c.oid) c.oid, n.nspname, c.relname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'v'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
	LOOP

	inserted := inserted + populate_geometry_columns(gcs.oid);
	END LOOP;

	IF oldcount > inserted THEN
	stale = oldcount-inserted;
	ELSE
	stale = 0;
	END IF;

	RETURN 'probed:' ||probed|| ' inserted:'||inserted|| ' conflicts:'||probed-inserted|| ' deleted:'||stale;
END

$$;


--
-- TOC entry 589 (class 1255 OID 16760)
-- Dependencies: 5 1734
-- Name: populate_geometry_columns(oid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION populate_geometry_columns(tbl_oid oid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	gcs         RECORD;
	gc          RECORD;
	gsrid       integer;
	gndims      integer;
	gtype       text;
	query       text;
	gc_is_valid boolean;
	inserted    integer;

BEGIN
	inserted := 0;

	-- Iterate through all geometry columns in this table
	FOR gcs IN
	SELECT n.nspname, c.relname, a.attname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'r'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND n.nspname NOT ILIKE 'pg_temp%'
		AND c.oid = tbl_oid
	LOOP

	RAISE DEBUG 'Processing table %.%.%', gcs.nspname, gcs.relname, gcs.attname;

	DELETE FROM geometry_columns
	  WHERE f_table_schema = gcs.nspname
	  AND f_table_name = gcs.relname
	  AND f_geometry_column = gcs.attname;

	gc_is_valid := true;

	-- Try to find srid check from system tables (pg_constraint)
	gsrid :=
		(SELECT replace(replace(split_part(s.consrc, ' = ', 2), ')', ''), '(', '')
		 FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
		 WHERE n.nspname = gcs.nspname
		 AND c.relname = gcs.relname
		 AND a.attname = gcs.attname
		 AND a.attrelid = c.oid
		 AND s.connamespace = n.oid
		 AND s.conrelid = c.oid
		 AND a.attnum = ANY (s.conkey)
		 AND s.consrc LIKE '%srid(% = %');
	IF (gsrid IS NULL) THEN
		-- Try to find srid from the geometry itself
		EXECUTE 'SELECT srid(' || quote_ident(gcs.attname) || ')
				 FROM ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gsrid := gc.srid;

		-- Try to apply srid check to column
		IF (gsrid IS NOT NULL) THEN
			BEGIN
				EXECUTE 'ALTER TABLE ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
						 ADD CONSTRAINT ' || quote_ident('enforce_srid_' || gcs.attname) || '
						 CHECK (srid(' || quote_ident(gcs.attname) || ') = ' || gsrid || ')';
			EXCEPTION
				WHEN check_violation THEN
					RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not apply constraint CHECK (srid(%) = %)', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname), quote_ident(gcs.attname), gsrid;
					gc_is_valid := false;
			END;
		END IF;
	END IF;

	-- Try to find ndims check from system tables (pg_constraint)
	gndims :=
		(SELECT replace(split_part(s.consrc, ' = ', 2), ')', '')
		 FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
		 WHERE n.nspname = gcs.nspname
		 AND c.relname = gcs.relname
		 AND a.attname = gcs.attname
		 AND a.attrelid = c.oid
		 AND s.connamespace = n.oid
		 AND s.conrelid = c.oid
		 AND a.attnum = ANY (s.conkey)
		 AND s.consrc LIKE '%ndims(% = %');
	IF (gndims IS NULL) THEN
		-- Try to find ndims from the geometry itself
		EXECUTE 'SELECT ndims(' || quote_ident(gcs.attname) || ')
				 FROM ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gndims := gc.ndims;

		-- Try to apply ndims check to column
		IF (gndims IS NOT NULL) THEN
			BEGIN
				EXECUTE 'ALTER TABLE ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
						 ADD CONSTRAINT ' || quote_ident('enforce_dims_' || gcs.attname) || '
						 CHECK (ndims(' || quote_ident(gcs.attname) || ') = '||gndims||')';
			EXCEPTION
				WHEN check_violation THEN
					RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not apply constraint CHECK (ndims(%) = %)', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname), quote_ident(gcs.attname), gndims;
					gc_is_valid := false;
			END;
		END IF;
	END IF;

	-- Try to find geotype check from system tables (pg_constraint)
	gtype :=
		(SELECT replace(split_part(s.consrc, '''', 2), ')', '')
		 FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
		 WHERE n.nspname = gcs.nspname
		 AND c.relname = gcs.relname
		 AND a.attname = gcs.attname
		 AND a.attrelid = c.oid
		 AND s.connamespace = n.oid
		 AND s.conrelid = c.oid
		 AND a.attnum = ANY (s.conkey)
		 AND s.consrc LIKE '%geometrytype(% = %');
	IF (gtype IS NULL) THEN
		-- Try to find geotype from the geometry itself
		EXECUTE 'SELECT geometrytype(' || quote_ident(gcs.attname) || ')
				 FROM ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gtype := gc.geometrytype;
		--IF (gtype IS NULL) THEN
		--    gtype := 'GEOMETRY';
		--END IF;

		-- Try to apply geometrytype check to column
		IF (gtype IS NOT NULL) THEN
			BEGIN
				EXECUTE 'ALTER TABLE ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				ADD CONSTRAINT ' || quote_ident('enforce_geotype_' || gcs.attname) || '
				CHECK ((geometrytype(' || quote_ident(gcs.attname) || ') = ' || quote_literal(gtype) || ') OR (' || quote_ident(gcs.attname) || ' IS NULL))';
			EXCEPTION
				WHEN check_violation THEN
					-- No geometry check can be applied. This column contains a number of geometry types.
					RAISE WARNING 'Could not add geometry type check (%) to table column: %.%.%', gtype, quote_ident(gcs.nspname),quote_ident(gcs.relname),quote_ident(gcs.attname);
			END;
		END IF;
	END IF;

	IF (gsrid IS NULL) THEN
		RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine the srid', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
	ELSIF (gndims IS NULL) THEN
		RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine the number of dimensions', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
	ELSIF (gtype IS NULL) THEN
		RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine the geometry type', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
	ELSE
		-- Only insert into geometry_columns if table constraints could be applied.
		IF (gc_is_valid) THEN
			INSERT INTO geometry_columns (f_table_catalog,f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type)
			VALUES ('', gcs.nspname, gcs.relname, gcs.attname, gndims, gsrid, gtype);
			inserted := inserted + 1;
		END IF;
	END IF;
	END LOOP;

	-- Add views to geometry columns table
	FOR gcs IN
	SELECT n.nspname, c.relname, a.attname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'v'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND n.nspname NOT ILIKE 'pg_temp%'
		AND c.oid = tbl_oid
	LOOP
		RAISE DEBUG 'Processing view %.%.%', gcs.nspname, gcs.relname, gcs.attname;

	DELETE FROM geometry_columns
	  WHERE f_table_schema = gcs.nspname
	  AND f_table_name = gcs.relname
	  AND f_geometry_column = gcs.attname;
	  
		EXECUTE 'SELECT ndims(' || quote_ident(gcs.attname) || ')
				 FROM ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gndims := gc.ndims;

		EXECUTE 'SELECT srid(' || quote_ident(gcs.attname) || ')
				 FROM ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gsrid := gc.srid;

		EXECUTE 'SELECT geometrytype(' || quote_ident(gcs.attname) || ')
				 FROM ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gtype := gc.geometrytype;

		IF (gndims IS NULL) THEN
			RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine ndims', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
		ELSIF (gsrid IS NULL) THEN
			RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine srid', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
		ELSIF (gtype IS NULL) THEN
			RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine gtype', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
		ELSE
			query := 'INSERT INTO geometry_columns (f_table_catalog,f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) ' ||
					 'VALUES ('''', ' || quote_literal(gcs.nspname) || ',' || quote_literal(gcs.relname) || ',' || quote_literal(gcs.attname) || ',' || gndims || ',' || gsrid || ',' || quote_literal(gtype) || ')';
			EXECUTE query;
			inserted := inserted + 1;
		END IF;
	END LOOP;

	RETURN inserted;
END

$$;


--
-- TOC entry 416 (class 1255 OID 16564)
-- Dependencies: 5 1404 1404
-- Name: postgis_addbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_addbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addBBOX';


--
-- TOC entry 526 (class 1255 OID 16674)
-- Dependencies: 5
-- Name: postgis_cache_bbox(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_cache_bbox() RETURNS trigger
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'cache_bbox';


--
-- TOC entry 418 (class 1255 OID 16566)
-- Dependencies: 5 1404 1404
-- Name: postgis_dropbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_dropbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dropBBOX';


--
-- TOC entry 624 (class 1255 OID 16790)
-- Dependencies: 1734 5
-- Name: postgis_full_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_full_version() RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	libver text;
	projver text;
	geosver text;
	libxmlver text;
	usestats bool;
	dbproc text;
	relproc text;
	fullver text;
BEGIN
	SELECT postgis_lib_version() INTO libver;
	SELECT postgis_proj_version() INTO projver;
	SELECT postgis_geos_version() INTO geosver;
	SELECT postgis_libxml_version() INTO libxmlver;
	SELECT postgis_uses_stats() INTO usestats;
	SELECT postgis_scripts_installed() INTO dbproc;
	SELECT postgis_scripts_released() INTO relproc;

	fullver = 'POSTGIS="' || libver || '"';

	IF  geosver IS NOT NULL THEN
		fullver = fullver || ' GEOS="' || geosver || '"';
	END IF;

	IF  projver IS NOT NULL THEN
		fullver = fullver || ' PROJ="' || projver || '"';
	END IF;

	IF  libxmlver IS NOT NULL THEN
		fullver = fullver || ' LIBXML="' || libxmlver || '"';
	END IF;

	IF usestats THEN
		fullver = fullver || ' USE_STATS';
	END IF;

	-- fullver = fullver || ' DBPROC="' || dbproc || '"';
	-- fullver = fullver || ' RELPROC="' || relproc || '"';

	IF dbproc != relproc THEN
		fullver = fullver || ' (procs from ' || dbproc || ' need upgrade)';
	END IF;

	RETURN fullver;
END
$$;


--
-- TOC entry 620 (class 1255 OID 16786)
-- Dependencies: 5
-- Name: postgis_geos_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_geos_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_geos_version';


--
-- TOC entry 421 (class 1255 OID 16569)
-- Dependencies: 5 1404 1420
-- Name: postgis_getbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_getbbox(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX2DFLOAT4';


--
-- TOC entry 378 (class 1255 OID 16493)
-- Dependencies: 5
-- Name: postgis_gist_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_gist_joinsel(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_joinsel';


--
-- TOC entry 377 (class 1255 OID 16492)
-- Dependencies: 5
-- Name: postgis_gist_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_gist_sel(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_sel';


--
-- TOC entry 423 (class 1255 OID 16571)
-- Dependencies: 5 1404
-- Name: postgis_hasbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_hasbbox(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_hasBBOX';


--
-- TOC entry 623 (class 1255 OID 16789)
-- Dependencies: 5
-- Name: postgis_lib_build_date(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_lib_build_date() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_lib_build_date';


--
-- TOC entry 617 (class 1255 OID 16783)
-- Dependencies: 5
-- Name: postgis_lib_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_lib_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_lib_version';


--
-- TOC entry 621 (class 1255 OID 16787)
-- Dependencies: 5
-- Name: postgis_libxml_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_libxml_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_libxml_version';


--
-- TOC entry 507 (class 1255 OID 16655)
-- Dependencies: 1404 5 1404
-- Name: postgis_noop(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_noop(geometry) RETURNS geometry
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_noop';


--
-- TOC entry 615 (class 1255 OID 16781)
-- Dependencies: 5
-- Name: postgis_proj_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_proj_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_proj_version';


--
-- TOC entry 622 (class 1255 OID 16788)
-- Dependencies: 5
-- Name: postgis_scripts_build_date(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_scripts_build_date() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '2012-10-07 12:25:36'::text AS version$$;


--
-- TOC entry 616 (class 1255 OID 16782)
-- Dependencies: 5
-- Name: postgis_scripts_installed(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_scripts_installed() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '1.5 r7360'::text AS version$$;


--
-- TOC entry 618 (class 1255 OID 16784)
-- Dependencies: 5
-- Name: postgis_scripts_released(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_scripts_released() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_scripts_released';


--
-- TOC entry 611 (class 1255 OID 16777)
-- Dependencies: 1404 5 1404
-- Name: postgis_transform_geometry(geometry, text, text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_transform_geometry(geometry, text, text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'transform_geom';


--
-- TOC entry 619 (class 1255 OID 16785)
-- Dependencies: 5
-- Name: postgis_uses_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_uses_stats() RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_uses_stats';


--
-- TOC entry 614 (class 1255 OID 16780)
-- Dependencies: 5
-- Name: postgis_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_version';


--
-- TOC entry 590 (class 1255 OID 16762)
-- Dependencies: 1734 5
-- Name: probe_geometry_columns(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION probe_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	inserted integer;
	oldcount integer;
	probed integer;
	stale integer;
BEGIN

	SELECT count(*) INTO oldcount FROM geometry_columns;

	SELECT count(*) INTO probed
		FROM pg_class c, pg_attribute a, pg_type t,
			pg_namespace n,
			pg_constraint sridcheck, pg_constraint typecheck

		WHERE t.typname = 'geometry'
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND sridcheck.connamespace = n.oid
		AND typecheck.connamespace = n.oid
		AND sridcheck.conrelid = c.oid
		AND sridcheck.consrc LIKE '(srid('||a.attname||') = %)'
		AND typecheck.conrelid = c.oid
		AND typecheck.consrc LIKE
		'((geometrytype('||a.attname||') = ''%''::text) OR (% IS NULL))'
		;

	INSERT INTO geometry_columns SELECT
		''::varchar as f_table_catalogue,
		n.nspname::varchar as f_table_schema,
		c.relname::varchar as f_table_name,
		a.attname::varchar as f_geometry_column,
		2 as coord_dimension,
		trim(both  ' =)' from
			replace(replace(split_part(
				sridcheck.consrc, ' = ', 2), ')', ''), '(', ''))::integer AS srid,
		trim(both ' =)''' from substr(typecheck.consrc,
			strpos(typecheck.consrc, '='),
			strpos(typecheck.consrc, '::')-
			strpos(typecheck.consrc, '=')
			))::varchar as type
		FROM pg_class c, pg_attribute a, pg_type t,
			pg_namespace n,
			pg_constraint sridcheck, pg_constraint typecheck
		WHERE t.typname = 'geometry'
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND sridcheck.connamespace = n.oid
		AND typecheck.connamespace = n.oid
		AND sridcheck.conrelid = c.oid
		AND sridcheck.consrc LIKE '(st_srid('||a.attname||') = %)'
		AND typecheck.conrelid = c.oid
		AND typecheck.consrc LIKE
		'((geometrytype('||a.attname||') = ''%''::text) OR (% IS NULL))'

			AND NOT EXISTS (
					SELECT oid FROM geometry_columns gc
					WHERE c.relname::varchar = gc.f_table_name
					AND n.nspname::varchar = gc.f_table_schema
					AND a.attname::varchar = gc.f_geometry_column
			);

	GET DIAGNOSTICS inserted = ROW_COUNT;

	IF oldcount > probed THEN
		stale = oldcount-probed;
	ELSE
		stale = 0;
	END IF;

	RETURN 'probed:'||probed::text||
		' inserted:'||inserted::text||
		' conflicts:'||(probed-inserted)::text||
		' stale:'||stale::text;
END

$$;


--
-- TOC entry 713 (class 1255 OID 16916)
-- Dependencies: 5 1404 1404
-- Name: relate(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION relate(geometry, geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'relate_full';


--
-- TOC entry 715 (class 1255 OID 16918)
-- Dependencies: 5 1404 1404
-- Name: relate(geometry, geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION relate(geometry, geometry, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'relate_pattern';


--
-- TOC entry 550 (class 1255 OID 16698)
-- Dependencies: 5 1404 1404
-- Name: removepoint(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION removepoint(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_removepoint';


--
-- TOC entry 586 (class 1255 OID 16757)
-- Dependencies: 5
-- Name: rename_geometry_table_constraints(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION rename_geometry_table_constraints() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT 'rename_geometry_table_constraint() is obsoleted'::text
$$;


--
-- TOC entry 502 (class 1255 OID 16650)
-- Dependencies: 1404 5 1404
-- Name: reverse(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION reverse(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_reverse';


--
-- TOC entry 319 (class 1255 OID 16412)
-- Dependencies: 5 1404 1404
-- Name: rotate(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION rotate(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT rotateZ($1, $2)$_$;


--
-- TOC entry 321 (class 1255 OID 16414)
-- Dependencies: 5 1404 1404
-- Name: rotatex(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION rotatex(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1, 1, 0, 0, 0, cos($2), -sin($2), 0, sin($2), cos($2), 0, 0, 0)$_$;


--
-- TOC entry 323 (class 1255 OID 16416)
-- Dependencies: 1404 1404 5
-- Name: rotatey(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION rotatey(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  cos($2), 0, sin($2),  0, 1, 0,  -sin($2), 0, cos($2), 0,  0, 0)$_$;


--
-- TOC entry 316 (class 1255 OID 16410)
-- Dependencies: 1404 5 1404
-- Name: rotatez(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION rotatez(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  cos($2), -sin($2), 0,  sin($2), cos($2), 0,  0, 0, 1,  0, 0, 0)$_$;


--
-- TOC entry 1083 (class 1255 OID 21629)
-- Dependencies: 1734 5
-- Name: sample_metamorphic_grades_sync(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sample_metamorphic_grades_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO sample_metamorphic_grades_dup(sample_id,metamorphic_grade_id,id)
    VALUES (NEW.sample_id,NEW.metamorphic_grade_id, nextval('sample_metamorphic_grades_dup_seq')) ;
    RETURN NULL ;
END ;
$$;


--
-- TOC entry 1084 (class 1255 OID 21630)
-- Dependencies: 1734 5
-- Name: sample_metamorphic_regions_sync(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sample_metamorphic_regions_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO sample_metamorphic_regions_dup(sample_id,metamorphic_region_id,id)
    VALUES (NEW.sample_id,NEW.metamorphic_region_id, nextval('sample_metamorphic_regions_dup_seq')) ;
    RETURN NULL ;
END ;
$$;


--
-- TOC entry 1085 (class 1255 OID 21631)
-- Dependencies: 5 1734
-- Name: sample_minerals_sync(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sample_minerals_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO sample_minerals_dup(mineral_id, sample_id, amount,id)
    VALUES (NEW.mineral_id, NEW.sample_id, NEW.amount, nextval('sample_minerals_dup_seq')) ;
    RETURN NULL ;
END ;
$$;


--
-- TOC entry 1086 (class 1255 OID 21632)
-- Dependencies: 5 1734
-- Name: sample_reference_sync(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sample_reference_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO sample_reference_dup(sample_id,reference_id,id)
    VALUES (NEW.sample_id,NEW.reference_id, nextval('sample_reference_dup_seq')) ;
    RETURN NULL ;
END ;
$$;


--
-- TOC entry 1087 (class 1255 OID 21633)
-- Dependencies: 1734 5
-- Name: sample_regions_sync(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sample_regions_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO sample_regions_dup(sample_id,region_id,id)
    VALUES (NEW.sample_id,NEW.region_id, nextval('sample_regions_dup_seq')) ;
    RETURN NULL ;
END ;
$$;


--
-- TOC entry 331 (class 1255 OID 16424)
-- Dependencies: 5 1404 1404
-- Name: scale(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION scale(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT scale($1, $2, $3, 1)$_$;


--
-- TOC entry 329 (class 1255 OID 16422)
-- Dependencies: 5 1404 1404
-- Name: scale(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION scale(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $2, 0, 0,  0, $3, 0,  0, 0, $4,  0, 0, 0)$_$;


--
-- TOC entry 985 (class 1255 OID 17183)
-- Dependencies: 1404 1404 5
-- Name: se_envelopesintersect(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION se_envelopesintersect(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ 
	SELECT $1 && $2
	$_$;


--
-- TOC entry 979 (class 1255 OID 17177)
-- Dependencies: 5 1404
-- Name: se_is3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION se_is3d(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_hasz';


--
-- TOC entry 980 (class 1255 OID 17178)
-- Dependencies: 5 1404
-- Name: se_ismeasured(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION se_ismeasured(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_hasm';


--
-- TOC entry 986 (class 1255 OID 17184)
-- Dependencies: 1404 1404 5
-- Name: se_locatealong(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION se_locatealong(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT locate_between_measures($1, $2, $2) $_$;


--
-- TOC entry 987 (class 1255 OID 17185)
-- Dependencies: 1404 5 1404
-- Name: se_locatebetween(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION se_locatebetween(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_locate_between_m';


--
-- TOC entry 983 (class 1255 OID 17181)
-- Dependencies: 5 1404
-- Name: se_m(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION se_m(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_m_point';


--
-- TOC entry 982 (class 1255 OID 17180)
-- Dependencies: 1404 5
-- Name: se_z(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION se_z(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_z_point';


--
-- TOC entry 659 (class 1255 OID 16847)
-- Dependencies: 5 1404 1404
-- Name: segmentize(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION segmentize(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_segmentize2d';


--
-- TOC entry 437 (class 1255 OID 16585)
-- Dependencies: 1416 5 1416
-- Name: setfactor(chip, real); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION setfactor(chip, real) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_setFactor';


--
-- TOC entry 552 (class 1255 OID 16700)
-- Dependencies: 5 1404 1404 1404
-- Name: setpoint(geometry, integer, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION setpoint(geometry, integer, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_setpoint_linestring';


--
-- TOC entry 436 (class 1255 OID 16584)
-- Dependencies: 1416 1416 5
-- Name: setsrid(chip, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION setsrid(chip, integer) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_setSRID';


--
-- TOC entry 831 (class 1255 OID 17034)
-- Dependencies: 5 1404 1404
-- Name: setsrid(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION setsrid(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_setSRID';


--
-- TOC entry 335 (class 1255 OID 16428)
-- Dependencies: 1404 5 1404
-- Name: shift_longitude(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION shift_longitude(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_longitude_shift';


--
-- TOC entry 649 (class 1255 OID 16837)
-- Dependencies: 5 1404 1404
-- Name: simplify(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION simplify(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_simplify2d';


--
-- TOC entry 655 (class 1255 OID 16843)
-- Dependencies: 1404 1404 5
-- Name: snaptogrid(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION snaptogrid(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT SnapToGrid($1, 0, 0, $2, $2)$_$;


--
-- TOC entry 653 (class 1255 OID 16841)
-- Dependencies: 5 1404 1404
-- Name: snaptogrid(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION snaptogrid(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT SnapToGrid($1, 0, 0, $2, $3)$_$;


--
-- TOC entry 651 (class 1255 OID 16839)
-- Dependencies: 1404 5 1404
-- Name: snaptogrid(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION snaptogrid(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_snaptogrid';


--
-- TOC entry 657 (class 1255 OID 16845)
-- Dependencies: 1404 1404 5 1404
-- Name: snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_snaptogrid_pointoff';


--
-- TOC entry 424 (class 1255 OID 16572)
-- Dependencies: 1416 5
-- Name: srid(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION srid(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getSRID';


--
-- TOC entry 829 (class 1255 OID 17032)
-- Dependencies: 1404 5
-- Name: srid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION srid(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_getSRID';


--
-- TOC entry 671 (class 1255 OID 16859)
-- Dependencies: 5 1404 1404
-- Name: st_addmeasure(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addmeasure(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_AddMeasure';


--
-- TOC entry 547 (class 1255 OID 16695)
-- Dependencies: 5 1404 1404 1404
-- Name: st_addpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addpoint(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addpoint';


--
-- TOC entry 549 (class 1255 OID 16697)
-- Dependencies: 5 1404 1404 1404
-- Name: st_addpoint(geometry, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addpoint(geometry, geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addpoint';


--
-- TOC entry 315 (class 1255 OID 16409)
-- Dependencies: 1404 1404 5
-- Name: st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $2, $3, 0,  $4, $5, 0,  0, 0, 1,  $6, $7, 0)$_$;


--
-- TOC entry 313 (class 1255 OID 16407)
-- Dependencies: 1404 5 1404
-- Name: st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_affine';


--
-- TOC entry 468 (class 1255 OID 16616)
-- Dependencies: 5 1404
-- Name: st_area(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_area(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_area_polygon';


--
-- TOC entry 1055 (class 1255 OID 17294)
-- Dependencies: 5 1431
-- Name: st_area(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_area(geography) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Area($1, true)$_$;


--
-- TOC entry 1056 (class 1255 OID 17295)
-- Dependencies: 5
-- Name: st_area(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_area(text) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Area($1::geometry);  $_$;


--
-- TOC entry 1054 (class 1255 OID 17293)
-- Dependencies: 5 1431
-- Name: st_area(geography, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_area(geography, boolean) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_area';


--
-- TOC entry 466 (class 1255 OID 16614)
-- Dependencies: 5 1404
-- Name: st_area2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_area2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_area_polygon';


--
-- TOC entry 834 (class 1255 OID 17037)
-- Dependencies: 1404 5
-- Name: st_asbinary(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asbinary(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asBinary';


--
-- TOC entry 995 (class 1255 OID 17203)
-- Dependencies: 5 1431
-- Name: st_asbinary(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asbinary(geography) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_binary';


--
-- TOC entry 996 (class 1255 OID 17204)
-- Dependencies: 5
-- Name: st_asbinary(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asbinary(text) RETURNS bytea
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsBinary($1::geometry);  $_$;


--
-- TOC entry 836 (class 1255 OID 17039)
-- Dependencies: 5 1404
-- Name: st_asbinary(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asbinary(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asBinary';


--
-- TOC entry 515 (class 1255 OID 16663)
-- Dependencies: 5 1404
-- Name: st_asewkb(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asewkb(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'WKBFromLWGEOM';


--
-- TOC entry 521 (class 1255 OID 16669)
-- Dependencies: 5 1404
-- Name: st_asewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asewkb(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'WKBFromLWGEOM';


--
-- TOC entry 513 (class 1255 OID 16661)
-- Dependencies: 5 1404
-- Name: st_asewkt(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asewkt(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asEWKT';


--
-- TOC entry 786 (class 1255 OID 16989)
-- Dependencies: 1404 5
-- Name: st_asgeojson(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, 15, 0)$_$;


--
-- TOC entry 1039 (class 1255 OID 17278)
-- Dependencies: 1431 5
-- Name: st_asgeojson(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, 15, 0)$_$;


--
-- TOC entry 1040 (class 1255 OID 17279)
-- Dependencies: 5
-- Name: st_asgeojson(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsGeoJson($1::geometry);  $_$;


--
-- TOC entry 785 (class 1255 OID 16988)
-- Dependencies: 1404 5
-- Name: st_asgeojson(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, $2, 0)$_$;


--
-- TOC entry 787 (class 1255 OID 16990)
-- Dependencies: 1404 5
-- Name: st_asgeojson(integer, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(integer, geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, 15, 0)$_$;


--
-- TOC entry 1038 (class 1255 OID 17277)
-- Dependencies: 5 1431
-- Name: st_asgeojson(geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, $2, 0)$_$;


--
-- TOC entry 1041 (class 1255 OID 17280)
-- Dependencies: 5 1431
-- Name: st_asgeojson(integer, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(integer, geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, 15, 0)$_$;


--
-- TOC entry 788 (class 1255 OID 16991)
-- Dependencies: 5 1404
-- Name: st_asgeojson(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(integer, geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, $3, 0)$_$;


--
-- TOC entry 789 (class 1255 OID 16992)
-- Dependencies: 1404 5
-- Name: st_asgeojson(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(geometry, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, $2, $3)$_$;


--
-- TOC entry 1042 (class 1255 OID 17281)
-- Dependencies: 5 1431
-- Name: st_asgeojson(integer, geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(integer, geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, $3, 0)$_$;


--
-- TOC entry 1043 (class 1255 OID 17282)
-- Dependencies: 1431 5
-- Name: st_asgeojson(geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(geography, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, $2, $3)$_$;


--
-- TOC entry 790 (class 1255 OID 16993)
-- Dependencies: 5 1404
-- Name: st_asgeojson(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(integer, geometry, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, $3, $4)$_$;


--
-- TOC entry 1044 (class 1255 OID 17283)
-- Dependencies: 1431 5
-- Name: st_asgeojson(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(integer, geography, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, $3, $4)$_$;


--
-- TOC entry 771 (class 1255 OID 16974)
-- Dependencies: 1404 5
-- Name: st_asgml(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, 15, 0)$_$;


--
-- TOC entry 1025 (class 1255 OID 17264)
-- Dependencies: 1431 5
-- Name: st_asgml(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, 15, 0)$_$;


--
-- TOC entry 1026 (class 1255 OID 17265)
-- Dependencies: 5
-- Name: st_asgml(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsGML($1::geometry);  $_$;


--
-- TOC entry 769 (class 1255 OID 16972)
-- Dependencies: 5 1404
-- Name: st_asgml(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, 0)$_$;


--
-- TOC entry 772 (class 1255 OID 16975)
-- Dependencies: 5 1404
-- Name: st_asgml(integer, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(integer, geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, 15, 0)$_$;


--
-- TOC entry 1024 (class 1255 OID 17263)
-- Dependencies: 5 1431
-- Name: st_asgml(geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, 0)$_$;


--
-- TOC entry 1027 (class 1255 OID 17266)
-- Dependencies: 5 1431
-- Name: st_asgml(integer, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(integer, geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, 15, 0)$_$;


--
-- TOC entry 773 (class 1255 OID 16976)
-- Dependencies: 5 1404
-- Name: st_asgml(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(integer, geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, $3, 0)$_$;


--
-- TOC entry 774 (class 1255 OID 16977)
-- Dependencies: 1404 5
-- Name: st_asgml(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(geometry, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, $3)$_$;


--
-- TOC entry 1028 (class 1255 OID 17267)
-- Dependencies: 5 1431
-- Name: st_asgml(integer, geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(integer, geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, $3, 0)$_$;


--
-- TOC entry 1029 (class 1255 OID 17268)
-- Dependencies: 5 1431
-- Name: st_asgml(geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(geography, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, $3)$_$;


--
-- TOC entry 775 (class 1255 OID 16978)
-- Dependencies: 5 1404
-- Name: st_asgml(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(integer, geometry, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, $3, $4)$_$;


--
-- TOC entry 1030 (class 1255 OID 17269)
-- Dependencies: 5 1431
-- Name: st_asgml(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(integer, geography, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, $3, $4)$_$;


--
-- TOC entry 517 (class 1255 OID 16665)
-- Dependencies: 1404 5
-- Name: st_ashexewkb(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ashexewkb(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asHEXEWKB';


--
-- TOC entry 519 (class 1255 OID 16667)
-- Dependencies: 5 1404
-- Name: st_ashexewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ashexewkb(geometry, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asHEXEWKB';


--
-- TOC entry 781 (class 1255 OID 16984)
-- Dependencies: 1404 5
-- Name: st_askml(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, ST_Transform($1,4326), 15)$_$;


--
-- TOC entry 1033 (class 1255 OID 17272)
-- Dependencies: 1431 5
-- Name: st_askml(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, $1, 15)$_$;


--
-- TOC entry 1034 (class 1255 OID 17273)
-- Dependencies: 5
-- Name: st_askml(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsKML($1::geometry);  $_$;


--
-- TOC entry 778 (class 1255 OID 16981)
-- Dependencies: 5 1404
-- Name: st_askml(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, ST_Transform($1,4326), $2)$_$;


--
-- TOC entry 782 (class 1255 OID 16985)
-- Dependencies: 1404 5
-- Name: st_askml(integer, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(integer, geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, ST_Transform($2,4326), 15)$_$;


--
-- TOC entry 1032 (class 1255 OID 17271)
-- Dependencies: 5 1431
-- Name: st_askml(geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, $1, $2)$_$;


--
-- TOC entry 1035 (class 1255 OID 17274)
-- Dependencies: 5 1431
-- Name: st_askml(integer, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(integer, geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, $2, 15)$_$;


--
-- TOC entry 783 (class 1255 OID 16986)
-- Dependencies: 1404 5
-- Name: st_askml(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(integer, geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, ST_Transform($2,4326), $3)$_$;


--
-- TOC entry 1036 (class 1255 OID 17275)
-- Dependencies: 5 1431
-- Name: st_askml(integer, geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(integer, geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, $2, $3)$_$;


--
-- TOC entry 766 (class 1255 OID 16969)
-- Dependencies: 5 1404
-- Name: st_assvg(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


--
-- TOC entry 1021 (class 1255 OID 17260)
-- Dependencies: 1431 5
-- Name: st_assvg(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(geography) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_svg';


--
-- TOC entry 1022 (class 1255 OID 17261)
-- Dependencies: 5
-- Name: st_assvg(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsSVG($1::geometry);  $_$;


--
-- TOC entry 764 (class 1255 OID 16967)
-- Dependencies: 5 1404
-- Name: st_assvg(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


--
-- TOC entry 1020 (class 1255 OID 17259)
-- Dependencies: 5 1431
-- Name: st_assvg(geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(geography, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_svg';


--
-- TOC entry 762 (class 1255 OID 16965)
-- Dependencies: 5 1404
-- Name: st_assvg(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


--
-- TOC entry 1019 (class 1255 OID 17258)
-- Dependencies: 1431 5
-- Name: st_assvg(geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(geography, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_svg';


--
-- TOC entry 838 (class 1255 OID 17041)
-- Dependencies: 5 1404
-- Name: st_astext(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astext(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asText';


--
-- TOC entry 991 (class 1255 OID 17199)
-- Dependencies: 1431 5
-- Name: st_astext(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astext(geography) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_text';


--
-- TOC entry 992 (class 1255 OID 17200)
-- Dependencies: 5
-- Name: st_astext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astext(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsText($1::geometry);  $_$;


--
-- TOC entry 478 (class 1255 OID 16626)
-- Dependencies: 1404 5 1404
-- Name: st_azimuth(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_azimuth(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_azimuth';


--
-- TOC entry 957 (class 1255 OID 17158)
-- Dependencies: 5 1404 1734
-- Name: st_bdmpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bdmpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := ST_MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := multi(ST_BuildArea(mline));

	RETURN geom;
END;
$_$;


--
-- TOC entry 955 (class 1255 OID 17156)
-- Dependencies: 1734 5 1404
-- Name: st_bdpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bdpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := ST_MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := ST_BuildArea(mline);

	IF GeometryType(geom) != 'POLYGON'
	THEN
		RAISE EXCEPTION 'Input returns more then a single polygon, try using BdMPolyFromText instead';
	END IF;

	RETURN geom;
END;
$_$;


--
-- TOC entry 692 (class 1255 OID 16880)
-- Dependencies: 5 1404 1404
-- Name: st_boundary(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_boundary(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'boundary';


--
-- TOC entry 627 (class 1255 OID 16793)
-- Dependencies: 1404 5
-- Name: st_box(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box(geometry) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX';


--
-- TOC entry 630 (class 1255 OID 16796)
-- Dependencies: 5 1408
-- Name: st_box(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box(box3d) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX';


--
-- TOC entry 625 (class 1255 OID 16791)
-- Dependencies: 1420 1404 5
-- Name: st_box2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box2d(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX2DFLOAT4';


--
-- TOC entry 628 (class 1255 OID 16794)
-- Dependencies: 1420 5 1408
-- Name: st_box2d(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box2d(box3d) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX2DFLOAT4';


--
-- TOC entry 592 (class 1255 OID 16805)
-- Dependencies: 1412 1420 5
-- Name: st_box2d(box3d_extent); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box2d(box3d_extent) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX2DFLOAT4';


--
-- TOC entry 361 (class 1255 OID 16462)
-- Dependencies: 5 1420
-- Name: st_box2d_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box2d_in(cstring) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_in';


--
-- TOC entry 362 (class 1255 OID 16463)
-- Dependencies: 5 1420
-- Name: st_box2d_out(box2d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box2d_out(box2d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_out';


--
-- TOC entry 626 (class 1255 OID 16792)
-- Dependencies: 5 1408 1404
-- Name: st_box3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box3d(geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX3D';


--
-- TOC entry 629 (class 1255 OID 16795)
-- Dependencies: 1408 5 1420
-- Name: st_box3d(box2d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box3d(box2d) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_to_BOX3D';


--
-- TOC entry 591 (class 1255 OID 16804)
-- Dependencies: 1412 5 1408
-- Name: st_box3d_extent(box3d_extent); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box3d_extent(box3d_extent) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_extent_to_BOX3D';


--
-- TOC entry 337 (class 1255 OID 16431)
-- Dependencies: 5 1408
-- Name: st_box3d_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box3d_in(cstring) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_in';


--
-- TOC entry 338 (class 1255 OID 16432)
-- Dependencies: 5 1408
-- Name: st_box3d_out(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_box3d_out(box3d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_out';


--
-- TOC entry 675 (class 1255 OID 16863)
-- Dependencies: 5 1404 1404
-- Name: st_buffer(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'buffer';


--
-- TOC entry 1070 (class 1255 OID 17309)
-- Dependencies: 1431 1431 5
-- Name: st_buffer(geography, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(geography, double precision) RETURNS geography
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geography(ST_Transform(ST_Buffer(ST_Transform(geometry($1), _ST_BestSRID($1)), $2), 4326))$_$;


--
-- TOC entry 1071 (class 1255 OID 17310)
-- Dependencies: 5 1404
-- Name: st_buffer(text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(text, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Buffer($1::geometry, $2);  $_$;


--
-- TOC entry 677 (class 1255 OID 16865)
-- Dependencies: 1404 5 1404
-- Name: st_buffer(geometry, double precision, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(geometry, double precision, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_Buffer($1, $2,
		CAST('quad_segs='||CAST($3 AS text) as cstring))
	   $_$;


--
-- TOC entry 678 (class 1255 OID 16866)
-- Dependencies: 1404 1404 5
-- Name: st_buffer(geometry, double precision, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(geometry, double precision, text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_Buffer($1, $2,
		CAST( regexp_replace($3, '^[0123456789]+$',
			'quad_segs='||$3) AS cstring)
		)
	   $_$;


--
-- TOC entry 560 (class 1255 OID 16708)
-- Dependencies: 1404 1404 5
-- Name: st_buildarea(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buildarea(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_buildarea';


--
-- TOC entry 637 (class 1255 OID 16803)
-- Dependencies: 5 1404
-- Name: st_bytea(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bytea(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_bytea';


--
-- TOC entry 748 (class 1255 OID 16951)
-- Dependencies: 1404 5 1404
-- Name: st_centroid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_centroid(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'centroid';


--
-- TOC entry 359 (class 1255 OID 16459)
-- Dependencies: 5 1416
-- Name: st_chip_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_chip_in(cstring) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_in';


--
-- TOC entry 360 (class 1255 OID 16460)
-- Dependencies: 5 1416
-- Name: st_chip_out(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_chip_out(chip) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_out';


--
-- TOC entry 948 (class 1255 OID 17149)
-- Dependencies: 1404 1404 1404 5
-- Name: st_closestpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_closestpoint(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_closestpoint';


--
-- TOC entry 701 (class 1255 OID 16891)
-- Dependencies: 5 1404 1406
-- Name: st_collect(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_collect(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_collect_garray';


--
-- TOC entry 700 (class 1255 OID 16888)
-- Dependencies: 5 1404 1404 1404
-- Name: st_collect(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_collect(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'LWGEOM_collect';


--
-- TOC entry 491 (class 1255 OID 16639)
-- Dependencies: 1404 5 1404
-- Name: st_collectionextract(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_collectionextract(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_CollectionExtract';


--
-- TOC entry 573 (class 1255 OID 16724)
-- Dependencies: 5 1420 1420 1404
-- Name: st_combine_bbox(box2d, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_combine_bbox(box2d, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_combine';


--
-- TOC entry 575 (class 1255 OID 16726)
-- Dependencies: 5 1412 1412 1404
-- Name: st_combine_bbox(box3d_extent, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_combine_bbox(box3d_extent, geometry) RETURNS box3d_extent
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX3D_combine';


--
-- TOC entry 577 (class 1255 OID 16730)
-- Dependencies: 5 1404 1408 1408
-- Name: st_combine_bbox(box3d, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_combine_bbox(box3d, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX3D_combine';


--
-- TOC entry 435 (class 1255 OID 16583)
-- Dependencies: 5 1416
-- Name: st_compression(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_compression(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getCompression';


--
-- TOC entry 735 (class 1255 OID 16938)
-- Dependencies: 1404 5 1404
-- Name: st_contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_contains(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Contains($1,$2)$_$;


--
-- TOC entry 741 (class 1255 OID 16944)
-- Dependencies: 5 1404 1404
-- Name: st_containsproperly(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_containsproperly(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_ContainsProperly($1,$2)$_$;


--
-- TOC entry 681 (class 1255 OID 16869)
-- Dependencies: 5 1404 1404
-- Name: st_convexhull(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_convexhull(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'convexhull';


--
-- TOC entry 976 (class 1255 OID 17174)
-- Dependencies: 1404 5
-- Name: st_coorddim(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_coorddim(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_ndims';


--
-- TOC entry 737 (class 1255 OID 16940)
-- Dependencies: 5 1404 1404
-- Name: st_coveredby(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_coveredby(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_CoveredBy($1,$2)$_$;


--
-- TOC entry 1064 (class 1255 OID 17303)
-- Dependencies: 1431 5 1431
-- Name: st_coveredby(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_coveredby(geography, geography) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Covers($2, $1)$_$;


--
-- TOC entry 1065 (class 1255 OID 17304)
-- Dependencies: 5
-- Name: st_coveredby(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_coveredby(text, text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_CoveredBy($1::geometry, $2::geometry);  $_$;


--
-- TOC entry 739 (class 1255 OID 16942)
-- Dependencies: 5 1404 1404
-- Name: st_covers(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_covers(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Covers($1,$2)$_$;


--
-- TOC entry 1062 (class 1255 OID 17301)
-- Dependencies: 5 1431 1431
-- Name: st_covers(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_covers(geography, geography) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT $1 && $2 AND _ST_Covers($1, $2)$_$;


--
-- TOC entry 1063 (class 1255 OID 17302)
-- Dependencies: 5
-- Name: st_covers(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_covers(text, text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_Covers($1::geometry, $2::geometry);  $_$;


--
-- TOC entry 729 (class 1255 OID 16932)
-- Dependencies: 5 1404 1404
-- Name: st_crosses(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_crosses(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Crosses($1,$2)$_$;


--
-- TOC entry 1075 (class 1255 OID 17314)
-- Dependencies: 1404 5 1404
-- Name: st_curvetoline(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_curvetoline(geometry) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_CurveToLine($1, 32)$_$;


--
-- TOC entry 1074 (class 1255 OID 17313)
-- Dependencies: 5 1404 1404
-- Name: st_curvetoline(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_curvetoline(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_curve_segmentize';


--
-- TOC entry 433 (class 1255 OID 16581)
-- Dependencies: 1416 5
-- Name: st_datatype(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_datatype(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getDatatype';


--
-- TOC entry 953 (class 1255 OID 17154)
-- Dependencies: 1404 5 1404
-- Name: st_dfullywithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dfullywithin(geometry, geometry, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && ST_Expand($2,$3) AND $2 && ST_Expand($1,$3) AND _ST_DFullyWithin(ST_ConvexHull($1), ST_ConvexHull($2), $3)$_$;


--
-- TOC entry 690 (class 1255 OID 16878)
-- Dependencies: 1404 5 1404 1404
-- Name: st_difference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_difference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'difference';


--
-- TOC entry 800 (class 1255 OID 17003)
-- Dependencies: 1404 5
-- Name: st_dimension(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dimension(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dimension';


--
-- TOC entry 718 (class 1255 OID 16921)
-- Dependencies: 5 1404 1404
-- Name: st_disjoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_disjoint(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'disjoint';


--
-- TOC entry 474 (class 1255 OID 16622)
-- Dependencies: 1404 5 1404
-- Name: st_distance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_mindistance2d';


--
-- TOC entry 1048 (class 1255 OID 17287)
-- Dependencies: 1431 1431 5
-- Name: st_distance(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance(geography, geography) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_Distance($1, $2, 0.0, true)$_$;


--
-- TOC entry 1049 (class 1255 OID 17288)
-- Dependencies: 5
-- Name: st_distance(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance(text, text) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Distance($1::geometry, $2::geometry);  $_$;


--
-- TOC entry 1047 (class 1255 OID 17286)
-- Dependencies: 1431 5 1431
-- Name: st_distance(geography, geography, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance(geography, geography, boolean) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_Distance($1, $2, 0.0, $3)$_$;


--
-- TOC entry 472 (class 1255 OID 16620)
-- Dependencies: 1404 1404 5
-- Name: st_distance_sphere(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance_sphere(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_distance_sphere';


--
-- TOC entry 470 (class 1255 OID 16618)
-- Dependencies: 5 1404 1404 1400
-- Name: st_distance_spheroid(geometry, geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance_spheroid(geometry, geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_distance_ellipsoid';


--
-- TOC entry 567 (class 1255 OID 16718)
-- Dependencies: 5 1424 1404
-- Name: st_dump(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dump(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dump';


--
-- TOC entry 571 (class 1255 OID 16722)
-- Dependencies: 5 1424 1404
-- Name: st_dumppoints(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dumppoints(geometry) RETURNS SETOF geometry_dump
    LANGUAGE sql STRICT
    AS $_$
  SELECT * FROM _ST_DumpPoints($1, NULL);
$_$;


--
-- TOC entry 569 (class 1255 OID 16720)
-- Dependencies: 5 1424 1404
-- Name: st_dumprings(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dumprings(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dump_rings';


--
-- TOC entry 723 (class 1255 OID 16926)
-- Dependencies: 5 1404 1404
-- Name: st_dwithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dwithin(geometry, geometry, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && ST_Expand($2,$3) AND $2 && ST_Expand($1,$3) AND _ST_DWithin($1, $2, $3)$_$;


--
-- TOC entry 1052 (class 1255 OID 17291)
-- Dependencies: 5 1431 1431
-- Name: st_dwithin(geography, geography, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dwithin(geography, geography, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && _ST_Expand($2,$3) AND $2 && _ST_Expand($1,$3) AND _ST_DWithin($1, $2, $3, true)$_$;


--
-- TOC entry 1053 (class 1255 OID 17292)
-- Dependencies: 5
-- Name: st_dwithin(text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dwithin(text, text, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_DWithin($1::geometry, $2::geometry, $3);  $_$;


--
-- TOC entry 1051 (class 1255 OID 17290)
-- Dependencies: 1431 5 1431
-- Name: st_dwithin(geography, geography, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dwithin(geography, geography, double precision, boolean) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && _ST_Expand($2,$3) AND $2 && _ST_Expand($1,$3) AND _ST_DWithin($1, $2, $3, $4)$_$;


--
-- TOC entry 824 (class 1255 OID 17027)
-- Dependencies: 1404 5 1404
-- Name: st_endpoint(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_endpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_endpoint_linestring';


--
-- TOC entry 501 (class 1255 OID 16649)
-- Dependencies: 5 1404 1404
-- Name: st_envelope(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_envelope(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_envelope';


--
-- TOC entry 757 (class 1255 OID 16960)
-- Dependencies: 5 1404 1404
-- Name: st_equals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_equals(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Equals($1,$2)$_$;


--
-- TOC entry 581 (class 1255 OID 16736)
-- Dependencies: 1420 5
-- Name: st_estimated_extent(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_estimated_extent(text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-1.5', 'LWGEOM_estimated_extent';


--
-- TOC entry 579 (class 1255 OID 16734)
-- Dependencies: 5 1420
-- Name: st_estimated_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_estimated_extent(text, text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-1.5', 'LWGEOM_estimated_extent';


--
-- TOC entry 495 (class 1255 OID 16643)
-- Dependencies: 1408 5 1408
-- Name: st_expand(box3d, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_expand(box3d, double precision) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_expand';


--
-- TOC entry 497 (class 1255 OID 16645)
-- Dependencies: 1420 5 1420
-- Name: st_expand(box2d, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_expand(box2d, double precision) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_expand';


--
-- TOC entry 499 (class 1255 OID 16647)
-- Dependencies: 5 1404 1404
-- Name: st_expand(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_expand(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_expand';


--
-- TOC entry 802 (class 1255 OID 17005)
-- Dependencies: 1404 1404 5
-- Name: st_exteriorring(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_exteriorring(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_exteriorring_polygon';


--
-- TOC entry 429 (class 1255 OID 16577)
-- Dependencies: 1416 5
-- Name: st_factor(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_factor(chip) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getFactor';


--
-- TOC entry 585 (class 1255 OID 16740)
-- Dependencies: 5 1734 1420
-- Name: st_find_extent(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_find_extent(text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	tablename alias for $1;
	columnname alias for $2;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT extent("' || columnname || '") FROM "' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


--
-- TOC entry 583 (class 1255 OID 16738)
-- Dependencies: 1420 1734 5
-- Name: st_find_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_find_extent(text, text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	schemaname alias for $1;
	tablename alias for $2;
	columnname alias for $3;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT extent("' || columnname || '") FROM "' || schemaname || '"."' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


--
-- TOC entry 480 (class 1255 OID 16628)
-- Dependencies: 1404 1404 5
-- Name: st_force_2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_2d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_2d';


--
-- TOC entry 484 (class 1255 OID 16632)
-- Dependencies: 1404 1404 5
-- Name: st_force_3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_3d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dz';


--
-- TOC entry 486 (class 1255 OID 16634)
-- Dependencies: 1404 5 1404
-- Name: st_force_3dm(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_3dm(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dm';


--
-- TOC entry 482 (class 1255 OID 16630)
-- Dependencies: 1404 5 1404
-- Name: st_force_3dz(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_3dz(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dz';


--
-- TOC entry 488 (class 1255 OID 16636)
-- Dependencies: 5 1404 1404
-- Name: st_force_4d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_4d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_4d';


--
-- TOC entry 490 (class 1255 OID 16638)
-- Dependencies: 1404 5 1404
-- Name: st_force_collection(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_collection(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_collection';


--
-- TOC entry 505 (class 1255 OID 16653)
-- Dependencies: 1404 5 1404
-- Name: st_forcerhr(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_forcerhr(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_forceRHR_poly';


--
-- TOC entry 994 (class 1255 OID 17202)
-- Dependencies: 1431 5
-- Name: st_geogfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geogfromtext(text) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_from_text';


--
-- TOC entry 997 (class 1255 OID 17205)
-- Dependencies: 1431 5
-- Name: st_geogfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geogfromwkb(bytea) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_from_binary';


--
-- TOC entry 993 (class 1255 OID 17201)
-- Dependencies: 1431 5
-- Name: st_geographyfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geographyfromtext(text) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_from_text';


--
-- TOC entry 792 (class 1255 OID 16995)
-- Dependencies: 5 1404
-- Name: st_geohash(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geohash(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_GeoHash($1, 0)$_$;


--
-- TOC entry 791 (class 1255 OID 16994)
-- Dependencies: 5 1404
-- Name: st_geohash(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geohash(geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_GeoHash';


--
-- TOC entry 892 (class 1255 OID 17094)
-- Dependencies: 5 1404
-- Name: st_geomcollfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomcollfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromText($1)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 890 (class 1255 OID 17092)
-- Dependencies: 1404 5
-- Name: st_geomcollfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomcollfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromText($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 944 (class 1255 OID 17145)
-- Dependencies: 5 1404
-- Name: st_geomcollfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomcollfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromWKB($1)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 942 (class 1255 OID 17143)
-- Dependencies: 5 1404
-- Name: st_geomcollfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomcollfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromWKB($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 632 (class 1255 OID 16798)
-- Dependencies: 5 1420 1404
-- Name: st_geometry(box2d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry(box2d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_to_LWGEOM';


--
-- TOC entry 633 (class 1255 OID 16799)
-- Dependencies: 1404 5 1408
-- Name: st_geometry(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry(box3d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_LWGEOM';


--
-- TOC entry 634 (class 1255 OID 16800)
-- Dependencies: 1404 5
-- Name: st_geometry(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'parse_WKT_lwgeom';


--
-- TOC entry 635 (class 1255 OID 16801)
-- Dependencies: 1404 5 1416
-- Name: st_geometry(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry(chip) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_to_LWGEOM';


--
-- TOC entry 636 (class 1255 OID 16802)
-- Dependencies: 5 1404
-- Name: st_geometry(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_bytea';


--
-- TOC entry 593 (class 1255 OID 16806)
-- Dependencies: 1404 1412 5
-- Name: st_geometry(box3d_extent); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry(box3d_extent) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_LWGEOM';


--
-- TOC entry 387 (class 1255 OID 16502)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_above(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_above(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_above';


--
-- TOC entry 304 (class 1255 OID 16397)
-- Dependencies: 5
-- Name: st_geometry_analyze(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_analyze(internal) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_analyze';


--
-- TOC entry 388 (class 1255 OID 16503)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_below(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_below(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_below';


--
-- TOC entry 370 (class 1255 OID 16472)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_cmp(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_cmp(geometry, geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_cmp';


--
-- TOC entry 389 (class 1255 OID 16504)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_contain(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_contain(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_contain';


--
-- TOC entry 390 (class 1255 OID 16505)
-- Dependencies: 5 1404 1404
-- Name: st_geometry_contained(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_contained(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_contained';


--
-- TOC entry 369 (class 1255 OID 16471)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_eq(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_eq(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_eq';


--
-- TOC entry 368 (class 1255 OID 16470)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_ge(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_ge(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_ge';


--
-- TOC entry 367 (class 1255 OID 16469)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_gt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_gt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_gt';


--
-- TOC entry 302 (class 1255 OID 16395)
-- Dependencies: 5 1404
-- Name: st_geometry_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_in(cstring) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_in';


--
-- TOC entry 366 (class 1255 OID 16468)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_le(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_le(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_le';


--
-- TOC entry 385 (class 1255 OID 16500)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_left(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_left(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_left';


--
-- TOC entry 365 (class 1255 OID 16467)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_lt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_lt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_lt';


--
-- TOC entry 303 (class 1255 OID 16396)
-- Dependencies: 5 1404
-- Name: st_geometry_out(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_out(geometry) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_out';


--
-- TOC entry 383 (class 1255 OID 16498)
-- Dependencies: 5 1404 1404
-- Name: st_geometry_overabove(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_overabove(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overabove';


--
-- TOC entry 384 (class 1255 OID 16499)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_overbelow(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_overbelow(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overbelow';


--
-- TOC entry 391 (class 1255 OID 16506)
-- Dependencies: 5 1404 1404
-- Name: st_geometry_overlap(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_overlap(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overlap';


--
-- TOC entry 381 (class 1255 OID 16496)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_overleft(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_overleft(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overleft';


--
-- TOC entry 382 (class 1255 OID 16497)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_overright(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_overright(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overright';


--
-- TOC entry 305 (class 1255 OID 16398)
-- Dependencies: 1404 5
-- Name: st_geometry_recv(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_recv(internal) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_recv';


--
-- TOC entry 386 (class 1255 OID 16501)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_right(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_right(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_right';


--
-- TOC entry 392 (class 1255 OID 16507)
-- Dependencies: 1404 5 1404
-- Name: st_geometry_same(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_same(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_samebox';


--
-- TOC entry 306 (class 1255 OID 16399)
-- Dependencies: 1404 5
-- Name: st_geometry_send(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometry_send(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_send';


--
-- TOC entry 840 (class 1255 OID 17043)
-- Dependencies: 1404 5
-- Name: st_geometryfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometryfromtext(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


--
-- TOC entry 842 (class 1255 OID 17045)
-- Dependencies: 5 1404
-- Name: st_geometryfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometryfromtext(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


--
-- TOC entry 798 (class 1255 OID 17001)
-- Dependencies: 5 1404 1404
-- Name: st_geometryn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometryn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_geometryn_collection';


--
-- TOC entry 810 (class 1255 OID 17013)
-- Dependencies: 1404 5
-- Name: st_geometrytype(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometrytype(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geometry_geometrytype';


--
-- TOC entry 523 (class 1255 OID 16671)
-- Dependencies: 5 1404
-- Name: st_geomfromewkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromewkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOMFromWKB';


--
-- TOC entry 525 (class 1255 OID 16673)
-- Dependencies: 5 1404
-- Name: st_geomfromewkt(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromewkt(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'parse_WKT_lwgeom';


--
-- TOC entry 758 (class 1255 OID 16961)
-- Dependencies: 5 1404
-- Name: st_geomfromgml(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromgml(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geom_from_gml';


--
-- TOC entry 760 (class 1255 OID 16963)
-- Dependencies: 5 1404
-- Name: st_geomfromkml(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromkml(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geom_from_kml';


--
-- TOC entry 844 (class 1255 OID 17047)
-- Dependencies: 5 1404
-- Name: st_geomfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromtext(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


--
-- TOC entry 846 (class 1255 OID 17049)
-- Dependencies: 1404 5
-- Name: st_geomfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromtext(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


--
-- TOC entry 894 (class 1255 OID 17096)
-- Dependencies: 5 1404
-- Name: st_geomfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromwkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_WKB';


--
-- TOC entry 896 (class 1255 OID 17098)
-- Dependencies: 1404 5
-- Name: st_geomfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SetSRID(ST_GeomFromWKB($1), $2)$_$;


--
-- TOC entry 759 (class 1255 OID 16962)
-- Dependencies: 5 1404
-- Name: st_gmltosql(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_gmltosql(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geom_from_gml';


--
-- TOC entry 1076 (class 1255 OID 17315)
-- Dependencies: 5 1404
-- Name: st_hasarc(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_hasarc(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_has_arc';


--
-- TOC entry 687 (class 1255 OID 16875)
-- Dependencies: 1404 5 1404
-- Name: st_hausdorffdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_hausdorffdistance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'hausdorffdistance';


--
-- TOC entry 688 (class 1255 OID 16876)
-- Dependencies: 1404 5 1404
-- Name: st_hausdorffdistance(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_hausdorffdistance(geometry, geometry, double precision) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'hausdorffdistancedensify';


--
-- TOC entry 427 (class 1255 OID 16575)
-- Dependencies: 5 1416
-- Name: st_height(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_height(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getHeight';


--
-- TOC entry 808 (class 1255 OID 17011)
-- Dependencies: 5 1404 1404
-- Name: st_interiorringn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_interiorringn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_interiorringn_polygon';


--
-- TOC entry 673 (class 1255 OID 16861)
-- Dependencies: 5 1404 1404 1404
-- Name: st_intersection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'intersection';


--
-- TOC entry 1072 (class 1255 OID 17311)
-- Dependencies: 1431 1431 5 1431
-- Name: st_intersection(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(geography, geography) RETURNS geography
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geography(ST_Transform(ST_Intersection(ST_Transform(geometry($1), _ST_BestSRID($1, $2)), ST_Transform(geometry($2), _ST_BestSRID($1, $2))), 4326))$_$;


--
-- TOC entry 1073 (class 1255 OID 17312)
-- Dependencies: 5 1404
-- Name: st_intersection(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(text, text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Intersection($1::geometry, $2::geometry);  $_$;


--
-- TOC entry 726 (class 1255 OID 16929)
-- Dependencies: 5 1404 1404
-- Name: st_intersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Intersects($1,$2)$_$;


--
-- TOC entry 1066 (class 1255 OID 17305)
-- Dependencies: 1431 1431 5
-- Name: st_intersects(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(geography, geography) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Distance($1, $2, 0.0, false) < 0.00001$_$;


--
-- TOC entry 1067 (class 1255 OID 17306)
-- Dependencies: 5
-- Name: st_intersects(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(text, text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_Intersects($1::geometry, $2::geometry);  $_$;


--
-- TOC entry 826 (class 1255 OID 17029)
-- Dependencies: 5 1404
-- Name: st_isclosed(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isclosed(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_isclosed_linestring';


--
-- TOC entry 828 (class 1255 OID 17031)
-- Dependencies: 5 1404
-- Name: st_isempty(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isempty(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_isempty';


--
-- TOC entry 750 (class 1255 OID 16953)
-- Dependencies: 5 1404
-- Name: st_isring(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isring(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'isring';


--
-- TOC entry 754 (class 1255 OID 16957)
-- Dependencies: 5 1404
-- Name: st_issimple(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_issimple(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'issimple';


--
-- TOC entry 746 (class 1255 OID 16949)
-- Dependencies: 5 1404
-- Name: st_isvalid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isvalid(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'isvalid';


--
-- TOC entry 686 (class 1255 OID 16874)
-- Dependencies: 1404 5
-- Name: st_isvalidreason(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isvalidreason(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'isvalidreason';


--
-- TOC entry 452 (class 1255 OID 16600)
-- Dependencies: 5 1404
-- Name: st_length(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_linestring';


--
-- TOC entry 1058 (class 1255 OID 17297)
-- Dependencies: 5 1431
-- Name: st_length(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length(geography) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT ST_Length($1, true)$_$;


--
-- TOC entry 1059 (class 1255 OID 17298)
-- Dependencies: 5
-- Name: st_length(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length(text) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Length($1::geometry);  $_$;


--
-- TOC entry 1057 (class 1255 OID 17296)
-- Dependencies: 5 1431
-- Name: st_length(geography, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length(geography, boolean) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_length';


--
-- TOC entry 450 (class 1255 OID 16598)
-- Dependencies: 5 1404
-- Name: st_length2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_linestring';


--
-- TOC entry 458 (class 1255 OID 16606)
-- Dependencies: 1404 5 1400
-- Name: st_length2d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length2d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_ellipsoid';


--
-- TOC entry 448 (class 1255 OID 16596)
-- Dependencies: 5 1404
-- Name: st_length3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length_linestring';


--
-- TOC entry 454 (class 1255 OID 16602)
-- Dependencies: 1404 5 1400
-- Name: st_length3d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length3d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length_ellipsoid_linestring';


--
-- TOC entry 456 (class 1255 OID 16604)
-- Dependencies: 1404 5 1400
-- Name: st_length_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length_ellipsoid_linestring';


--
-- TOC entry 662 (class 1255 OID 16850)
-- Dependencies: 5 1404 1404
-- Name: st_line_interpolate_point(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_line_interpolate_point(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_interpolate_point';


--
-- TOC entry 666 (class 1255 OID 16854)
-- Dependencies: 1404 5 1404
-- Name: st_line_locate_point(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_line_locate_point(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_locate_point';


--
-- TOC entry 664 (class 1255 OID 16852)
-- Dependencies: 5 1404 1404
-- Name: st_line_substring(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_line_substring(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_substring';


--
-- TOC entry 683 (class 1255 OID 16871)
-- Dependencies: 5 1404 1404
-- Name: st_linecrossingdirection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linecrossingdirection(geometry, geometry) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT CASE WHEN NOT $1 && $2 THEN 0 ELSE _ST_LineCrossingDirection($1,$2) END $_$;


--
-- TOC entry 543 (class 1255 OID 16691)
-- Dependencies: 1404 5 1404
-- Name: st_linefrommultipoint(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefrommultipoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_from_mpoint';


--
-- TOC entry 853 (class 1255 OID 17055)
-- Dependencies: 1404 5
-- Name: st_linefromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'LINESTRING'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 855 (class 1255 OID 17057)
-- Dependencies: 1404 5
-- Name: st_linefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'LINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 904 (class 1255 OID 17106)
-- Dependencies: 1404 5
-- Name: st_linefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 902 (class 1255 OID 17104)
-- Dependencies: 1404 5
-- Name: st_linefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 565 (class 1255 OID 16713)
-- Dependencies: 1404 5 1404
-- Name: st_linemerge(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linemerge(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'linemerge';


--
-- TOC entry 908 (class 1255 OID 17110)
-- Dependencies: 5 1404
-- Name: st_linestringfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linestringfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'LINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 906 (class 1255 OID 17108)
-- Dependencies: 5 1404
-- Name: st_linestringfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linestringfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 1077 (class 1255 OID 17316)
-- Dependencies: 1404 5 1404
-- Name: st_linetocurve(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linetocurve(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_desegmentize';


--
-- TOC entry 670 (class 1255 OID 16858)
-- Dependencies: 5 1404 1404
-- Name: st_locate_along_measure(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_locate_along_measure(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT locate_between_measures($1, $2, $2) $_$;


--
-- TOC entry 668 (class 1255 OID 16856)
-- Dependencies: 1404 5 1404
-- Name: st_locate_between_measures(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_locate_between_measures(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_locate_between_m';


--
-- TOC entry 684 (class 1255 OID 16872)
-- Dependencies: 1404 5 1404
-- Name: st_locatebetweenelevations(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_locatebetweenelevations(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_LocateBetweenElevations';


--
-- TOC entry 951 (class 1255 OID 17152)
-- Dependencies: 1404 1404 5 1404
-- Name: st_longestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_longestline(geometry, geometry) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_LongestLine(ST_ConvexHull($1), ST_ConvexHull($2))$_$;


--
-- TOC entry 820 (class 1255 OID 17023)
-- Dependencies: 1404 5
-- Name: st_m(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_m(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_m_point';


--
-- TOC entry 536 (class 1255 OID 16684)
-- Dependencies: 1404 5 1420 1404
-- Name: st_makebox2d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makebox2d(geometry, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_construct';


--
-- TOC entry 538 (class 1255 OID 16686)
-- Dependencies: 5 1408 1404 1404
-- Name: st_makebox3d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makebox3d(geometry, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_construct';


--
-- TOC entry 554 (class 1255 OID 16702)
-- Dependencies: 1404 5
-- Name: st_makeenvelope(double precision, double precision, double precision, double precision, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_MakeEnvelope';


--
-- TOC entry 541 (class 1255 OID 16689)
-- Dependencies: 1406 5 1404
-- Name: st_makeline(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeline(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline_garray';


--
-- TOC entry 545 (class 1255 OID 16693)
-- Dependencies: 5 1404 1404 1404
-- Name: st_makeline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeline(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline';


--
-- TOC entry 540 (class 1255 OID 16688)
-- Dependencies: 1406 1404 5
-- Name: st_makeline_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeline_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline_garray';


--
-- TOC entry 528 (class 1255 OID 16676)
-- Dependencies: 5 1404
-- Name: st_makepoint(double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepoint(double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


--
-- TOC entry 530 (class 1255 OID 16678)
-- Dependencies: 5 1404
-- Name: st_makepoint(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepoint(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


--
-- TOC entry 532 (class 1255 OID 16680)
-- Dependencies: 1404 5
-- Name: st_makepoint(double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepoint(double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


--
-- TOC entry 534 (class 1255 OID 16682)
-- Dependencies: 1404 5
-- Name: st_makepointm(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepointm(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint3dm';


--
-- TOC entry 558 (class 1255 OID 16706)
-- Dependencies: 5 1404 1404
-- Name: st_makepolygon(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepolygon(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoly';


--
-- TOC entry 556 (class 1255 OID 16704)
-- Dependencies: 1404 5 1406 1404
-- Name: st_makepolygon(geometry, geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepolygon(geometry, geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoly';


--
-- TOC entry 947 (class 1255 OID 17148)
-- Dependencies: 1404 1404 5
-- Name: st_maxdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_maxdistance(geometry, geometry) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_MaxDistance(ST_ConvexHull($1), ST_ConvexHull($2))$_$;


--
-- TOC entry 440 (class 1255 OID 16588)
-- Dependencies: 5 1404
-- Name: st_mem_size(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mem_size(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_mem_size';


--
-- TOC entry 1079 (class 1255 OID 17319)
-- Dependencies: 1404 5 1404
-- Name: st_minimumboundingcircle(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_minimumboundingcircle(geometry) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MinimumBoundingCircle($1, 48)$_$;


--
-- TOC entry 1078 (class 1255 OID 17317)
-- Dependencies: 1404 1734 5 1404
-- Name: st_minimumboundingcircle(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_minimumboundingcircle(inputgeom geometry, segs_per_quarter integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
	DECLARE
	hull GEOMETRY;
	ring GEOMETRY;
	center GEOMETRY;
	radius DOUBLE PRECISION;
	dist DOUBLE PRECISION;
	d DOUBLE PRECISION;
	idx1 integer;
	idx2 integer;
	l1 GEOMETRY;
	l2 GEOMETRY;
	p1 GEOMETRY;
	p2 GEOMETRY;
	a1 DOUBLE PRECISION;
	a2 DOUBLE PRECISION;


	BEGIN

	-- First compute the ConvexHull of the geometry
	hull = ST_ConvexHull(inputgeom);
	--A point really has no MBC
	IF ST_GeometryType(hull) = 'ST_Point' THEN
		RETURN hull;
	END IF;
	-- convert the hull perimeter to a linestring so we can manipulate individual points
	--If its already a linestring force it to a closed linestring
	ring = CASE WHEN ST_GeometryType(hull) = 'ST_LineString' THEN ST_AddPoint(hull, ST_StartPoint(hull)) ELSE ST_ExteriorRing(hull) END;

	dist = 0;
	-- Brute Force - check every pair
	FOR i in 1 .. (ST_NumPoints(ring)-2)
		LOOP
			FOR j in i .. (ST_NumPoints(ring)-1)
				LOOP
				d = ST_Distance(ST_PointN(ring,i),ST_PointN(ring,j));
				-- Check the distance and update if larger
				IF (d > dist) THEN
					dist = d;
					idx1 = i;
					idx2 = j;
				END IF;
			END LOOP;
		END LOOP;

	-- We now have the diameter of the convex hull.  The following line returns it if desired.
	-- RETURN MakeLine(PointN(ring,idx1),PointN(ring,idx2));

	-- Now for the Minimum Bounding Circle.  Since we know the two points furthest from each
	-- other, the MBC must go through those two points. Start with those points as a diameter of a circle.

	-- The radius is half the distance between them and the center is midway between them
	radius = ST_Distance(ST_PointN(ring,idx1),ST_PointN(ring,idx2)) / 2.0;
	center = ST_Line_interpolate_point(ST_MakeLine(ST_PointN(ring,idx1),ST_PointN(ring,idx2)),0.5);

	-- Loop through each vertex and check if the distance from the center to the point
	-- is greater than the current radius.
	FOR k in 1 .. (ST_NumPoints(ring)-1)
		LOOP
		IF(k <> idx1 and k <> idx2) THEN
			dist = ST_Distance(center,ST_PointN(ring,k));
			IF (dist > radius) THEN
				-- We have to expand the circle.  The new circle must pass trhough
				-- three points - the two original diameters and this point.

				-- Draw a line from the first diameter to this point
				l1 = ST_Makeline(ST_PointN(ring,idx1),ST_PointN(ring,k));
				-- Compute the midpoint
				p1 = ST_line_interpolate_point(l1,0.5);
				-- Rotate the line 90 degrees around the midpoint (perpendicular bisector)
				l1 = ST_Translate(ST_Rotate(ST_Translate(l1,-X(p1),-Y(p1)),pi()/2),X(p1),Y(p1));
				--  Compute the azimuth of the bisector
				a1 = ST_Azimuth(ST_PointN(l1,1),ST_PointN(l1,2));
				--  Extend the line in each direction the new computed distance to insure they will intersect
				l1 = ST_AddPoint(l1,ST_Makepoint(X(ST_PointN(l1,2))+sin(a1)*dist,Y(ST_PointN(l1,2))+cos(a1)*dist),-1);
				l1 = ST_AddPoint(l1,ST_Makepoint(X(ST_PointN(l1,1))-sin(a1)*dist,Y(ST_PointN(l1,1))-cos(a1)*dist),0);

				-- Repeat for the line from the point to the other diameter point
				l2 = ST_Makeline(ST_PointN(ring,idx2),ST_PointN(ring,k));
				p2 = ST_Line_interpolate_point(l2,0.5);
				l2 = ST_Translate(ST_Rotate(ST_Translate(l2,-X(p2),-Y(p2)),pi()/2),X(p2),Y(p2));
				a2 = ST_Azimuth(ST_PointN(l2,1),ST_PointN(l2,2));
				l2 = ST_AddPoint(l2,ST_Makepoint(X(ST_PointN(l2,2))+sin(a2)*dist,Y(ST_PointN(l2,2))+cos(a2)*dist),-1);
				l2 = ST_AddPoint(l2,ST_Makepoint(X(ST_PointN(l2,1))-sin(a2)*dist,Y(ST_PointN(l2,1))-cos(a2)*dist),0);

				-- The new center is the intersection of the two bisectors
				center = ST_Intersection(l1,l2);
				-- The new radius is the distance to any of the three points
				radius = ST_Distance(center,ST_PointN(ring,idx1));
			END IF;
		END IF;
		END LOOP;
	--DONE!!  Return the MBC via the buffer command
	RETURN ST_Buffer(center,radius,segs_per_quarter);

	END;
$$;


--
-- TOC entry 869 (class 1255 OID 17071)
-- Dependencies: 1404 5
-- Name: st_mlinefromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mlinefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'MULTILINESTRING'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 867 (class 1255 OID 17069)
-- Dependencies: 5 1404
-- Name: st_mlinefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mlinefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 932 (class 1255 OID 17133)
-- Dependencies: 5 1404
-- Name: st_mlinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mlinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 930 (class 1255 OID 17131)
-- Dependencies: 1404 5
-- Name: st_mlinefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mlinefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTILINESTRING'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 877 (class 1255 OID 17079)
-- Dependencies: 5 1404
-- Name: st_mpointfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'MULTIPOINT'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 875 (class 1255 OID 17077)
-- Dependencies: 5 1404
-- Name: st_mpointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'MULTIPOINT'
	THEN GeomFromText($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 921 (class 1255 OID 17122)
-- Dependencies: 5 1404
-- Name: st_mpointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 919 (class 1255 OID 17120)
-- Dependencies: 5 1404
-- Name: st_mpointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTIPOINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 884 (class 1255 OID 17086)
-- Dependencies: 5 1404
-- Name: st_mpolyfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpolyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'MULTIPOLYGON'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 882 (class 1255 OID 17084)
-- Dependencies: 5 1404
-- Name: st_mpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'MULTIPOLYGON'
	THEN ST_GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- TOC entry 936 (class 1255 OID 17137)
-- Dependencies: 1404 5
-- Name: st_mpolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 934 (class 1255 OID 17135)
-- Dependencies: 1404 5
-- Name: st_mpolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 493 (class 1255 OID 16641)
-- Dependencies: 1404 5 1404
-- Name: st_multi(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multi(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_multi';


--
-- TOC entry 928 (class 1255 OID 17129)
-- Dependencies: 1404 5
-- Name: st_multilinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multilinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 871 (class 1255 OID 17073)
-- Dependencies: 5 1404
-- Name: st_multilinestringfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multilinestringfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MLineFromText($1)$_$;


--
-- TOC entry 873 (class 1255 OID 17075)
-- Dependencies: 1404 5
-- Name: st_multilinestringfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multilinestringfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MLineFromText($1, $2)$_$;


--
-- TOC entry 880 (class 1255 OID 17082)
-- Dependencies: 5 1404
-- Name: st_multipointfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPointFromText($1)$_$;


--
-- TOC entry 925 (class 1255 OID 17126)
-- Dependencies: 1404 5
-- Name: st_multipointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 923 (class 1255 OID 17124)
-- Dependencies: 5 1404
-- Name: st_multipointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1,$2)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 940 (class 1255 OID 17141)
-- Dependencies: 1404 5
-- Name: st_multipolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 938 (class 1255 OID 17139)
-- Dependencies: 5 1404
-- Name: st_multipolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 888 (class 1255 OID 17090)
-- Dependencies: 5 1404
-- Name: st_multipolygonfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipolygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1)$_$;


--
-- TOC entry 886 (class 1255 OID 17088)
-- Dependencies: 5 1404
-- Name: st_multipolygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipolygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1, $2)$_$;


--
-- TOC entry 511 (class 1255 OID 16659)
-- Dependencies: 5 1404
-- Name: st_ndims(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ndims(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_ndims';


--
-- TOC entry 444 (class 1255 OID 16592)
-- Dependencies: 5 1404
-- Name: st_npoints(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_npoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_npoints';


--
-- TOC entry 446 (class 1255 OID 16594)
-- Dependencies: 5 1404
-- Name: st_nrings(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_nrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_nrings';


--
-- TOC entry 796 (class 1255 OID 16999)
-- Dependencies: 1404 5
-- Name: st_numgeometries(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numgeometries(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numgeometries_collection';


--
-- TOC entry 806 (class 1255 OID 17009)
-- Dependencies: 1404 5
-- Name: st_numinteriorring(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numinteriorring(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numinteriorrings_polygon';


--
-- TOC entry 804 (class 1255 OID 17007)
-- Dependencies: 5 1404
-- Name: st_numinteriorrings(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numinteriorrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numinteriorrings_polygon';


--
-- TOC entry 794 (class 1255 OID 16997)
-- Dependencies: 5 1404
-- Name: st_numpoints(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numpoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numpoints_linestring';


--
-- TOC entry 978 (class 1255 OID 17176)
-- Dependencies: 5 1404 1404
-- Name: st_orderingequals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_orderingequals(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ 
	SELECT $1 ~= $2 AND _ST_OrderingEquals($1, $2)
	$_$;


--
-- TOC entry 744 (class 1255 OID 16947)
-- Dependencies: 1404 1404 5
-- Name: st_overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_overlaps(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Overlaps($1,$2)$_$;


--
-- TOC entry 464 (class 1255 OID 16612)
-- Dependencies: 5 1404
-- Name: st_perimeter(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_perimeter(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter2d_poly';


--
-- TOC entry 462 (class 1255 OID 16610)
-- Dependencies: 5 1404
-- Name: st_perimeter2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_perimeter2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter2d_poly';


--
-- TOC entry 460 (class 1255 OID 16608)
-- Dependencies: 1404 5
-- Name: st_perimeter3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_perimeter3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter_poly';


--
-- TOC entry 981 (class 1255 OID 17179)
-- Dependencies: 1404 5
-- Name: st_point(double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_point(double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


--
-- TOC entry 476 (class 1255 OID 16624)
-- Dependencies: 5 1404
-- Name: st_point_inside_circle(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_point_inside_circle(geometry, double precision, double precision, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_inside_circle_point';


--
-- TOC entry 848 (class 1255 OID 17051)
-- Dependencies: 5 1404
-- Name: st_pointfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'POINT'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 850 (class 1255 OID 17053)
-- Dependencies: 5 1404
-- Name: st_pointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'POINT'
	THEN ST_GeomFromText($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 900 (class 1255 OID 17102)
-- Dependencies: 5 1404
-- Name: st_pointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'POINT'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 898 (class 1255 OID 17100)
-- Dependencies: 5 1404
-- Name: st_pointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'POINT'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 812 (class 1255 OID 17015)
-- Dependencies: 1404 5 1404
-- Name: st_pointn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_pointn_linestring';


--
-- TOC entry 752 (class 1255 OID 16955)
-- Dependencies: 1404 1404 5
-- Name: st_pointonsurface(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointonsurface(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'pointonsurface';


--
-- TOC entry 859 (class 1255 OID 17061)
-- Dependencies: 1404 5
-- Name: st_polyfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'POLYGON'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 861 (class 1255 OID 17063)
-- Dependencies: 1404 5
-- Name: st_polyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'POLYGON'
	THEN ST_GeomFromText($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 912 (class 1255 OID 17114)
-- Dependencies: 5 1404
-- Name: st_polyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'POLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 910 (class 1255 OID 17112)
-- Dependencies: 1404 5
-- Name: st_polyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'POLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 984 (class 1255 OID 17182)
-- Dependencies: 1404 5 1404
-- Name: st_polygon(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygon(geometry, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ 
	SELECT setSRID(makepolygon($1), $2)
	$_$;


--
-- TOC entry 865 (class 1255 OID 17067)
-- Dependencies: 1404 5
-- Name: st_polygonfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_PolyFromText($1)$_$;


--
-- TOC entry 863 (class 1255 OID 17065)
-- Dependencies: 5 1404
-- Name: st_polygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT PolyFromText($1, $2)$_$;


--
-- TOC entry 917 (class 1255 OID 17118)
-- Dependencies: 5 1404
-- Name: st_polygonfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- TOC entry 915 (class 1255 OID 17116)
-- Dependencies: 5 1404
-- Name: st_polygonfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1,$2)) = 'POLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- TOC entry 563 (class 1255 OID 16711)
-- Dependencies: 5 1404 1406
-- Name: st_polygonize(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonize(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'polygonize_garray';


--
-- TOC entry 562 (class 1255 OID 16710)
-- Dependencies: 1406 1404 5
-- Name: st_polygonize_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonize_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'polygonize_garray';


--
-- TOC entry 380 (class 1255 OID 16495)
-- Dependencies: 5
-- Name: st_postgis_gist_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_postgis_gist_joinsel(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_joinsel';


--
-- TOC entry 379 (class 1255 OID 16494)
-- Dependencies: 5
-- Name: st_postgis_gist_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_postgis_gist_sel(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_sel';


--
-- TOC entry 714 (class 1255 OID 16917)
-- Dependencies: 5 1404 1404
-- Name: st_relate(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_relate(geometry, geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'relate_full';


--
-- TOC entry 716 (class 1255 OID 16919)
-- Dependencies: 5 1404 1404
-- Name: st_relate(geometry, geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_relate(geometry, geometry, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'relate_pattern';


--
-- TOC entry 551 (class 1255 OID 16699)
-- Dependencies: 1404 1404 5
-- Name: st_removepoint(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_removepoint(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_removepoint';


--
-- TOC entry 503 (class 1255 OID 16651)
-- Dependencies: 5 1404 1404
-- Name: st_reverse(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_reverse(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_reverse';


--
-- TOC entry 320 (class 1255 OID 16413)
-- Dependencies: 1404 5 1404
-- Name: st_rotate(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotate(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT rotateZ($1, $2)$_$;


--
-- TOC entry 322 (class 1255 OID 16415)
-- Dependencies: 1404 1404 5
-- Name: st_rotatex(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotatex(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1, 1, 0, 0, 0, cos($2), -sin($2), 0, sin($2), cos($2), 0, 0, 0)$_$;


--
-- TOC entry 324 (class 1255 OID 16417)
-- Dependencies: 1404 5 1404
-- Name: st_rotatey(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotatey(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  cos($2), 0, sin($2),  0, 1, 0,  -sin($2), 0, cos($2), 0,  0, 0)$_$;


--
-- TOC entry 318 (class 1255 OID 16411)
-- Dependencies: 5 1404 1404
-- Name: st_rotatez(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotatez(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  cos($2), -sin($2), 0,  sin($2), cos($2), 0,  0, 0, 1,  0, 0, 0)$_$;


--
-- TOC entry 332 (class 1255 OID 16425)
-- Dependencies: 1404 1404 5
-- Name: st_scale(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_scale(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT scale($1, $2, $3, 1)$_$;


--
-- TOC entry 330 (class 1255 OID 16423)
-- Dependencies: 5 1404 1404
-- Name: st_scale(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_scale(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $2, 0, 0,  0, $3, 0,  0, 0, $4,  0, 0, 0)$_$;


--
-- TOC entry 660 (class 1255 OID 16848)
-- Dependencies: 1404 1404 5
-- Name: st_segmentize(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_segmentize(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_segmentize2d';


--
-- TOC entry 438 (class 1255 OID 16586)
-- Dependencies: 5 1416 1416
-- Name: st_setfactor(chip, real); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setfactor(chip, real) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_setFactor';


--
-- TOC entry 553 (class 1255 OID 16701)
-- Dependencies: 5 1404 1404 1404
-- Name: st_setpoint(geometry, integer, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setpoint(geometry, integer, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_setpoint_linestring';


--
-- TOC entry 832 (class 1255 OID 17035)
-- Dependencies: 5 1404 1404
-- Name: st_setsrid(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setsrid(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_setSRID';


--
-- TOC entry 336 (class 1255 OID 16429)
-- Dependencies: 1404 5 1404
-- Name: st_shift_longitude(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_shift_longitude(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_longitude_shift';


--
-- TOC entry 949 (class 1255 OID 17150)
-- Dependencies: 1404 5 1404 1404
-- Name: st_shortestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_shortestline(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_shortestline2d';


--
-- TOC entry 650 (class 1255 OID 16838)
-- Dependencies: 5 1404 1404
-- Name: st_simplify(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_simplify(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_simplify2d';


--
-- TOC entry 685 (class 1255 OID 16873)
-- Dependencies: 1404 1404 5
-- Name: st_simplifypreservetopology(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_simplifypreservetopology(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'topologypreservesimplify';


--
-- TOC entry 656 (class 1255 OID 16844)
-- Dependencies: 1404 1404 5
-- Name: st_snaptogrid(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SnapToGrid($1, 0, 0, $2, $2)$_$;


--
-- TOC entry 654 (class 1255 OID 16842)
-- Dependencies: 1404 5 1404
-- Name: st_snaptogrid(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SnapToGrid($1, 0, 0, $2, $3)$_$;


--
-- TOC entry 652 (class 1255 OID 16840)
-- Dependencies: 5 1404 1404
-- Name: st_snaptogrid(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_snaptogrid';


--
-- TOC entry 658 (class 1255 OID 16846)
-- Dependencies: 1404 1404 5 1404
-- Name: st_snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_snaptogrid_pointoff';


--
-- TOC entry 287 (class 1255 OID 16389)
-- Dependencies: 5 1400
-- Name: st_spheroid_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_spheroid_in(cstring) RETURNS spheroid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ellipsoid_in';


--
-- TOC entry 291 (class 1255 OID 16390)
-- Dependencies: 5 1400
-- Name: st_spheroid_out(spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_spheroid_out(spheroid) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ellipsoid_out';


--
-- TOC entry 425 (class 1255 OID 16573)
-- Dependencies: 5 1416
-- Name: st_srid(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_srid(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getSRID';


--
-- TOC entry 830 (class 1255 OID 17033)
-- Dependencies: 1404 5
-- Name: st_srid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_srid(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_getSRID';


--
-- TOC entry 822 (class 1255 OID 17025)
-- Dependencies: 5 1404 1404
-- Name: st_startpoint(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_startpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_startpoint_linestring';


--
-- TOC entry 442 (class 1255 OID 16590)
-- Dependencies: 5 1404
-- Name: st_summary(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_summary(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_summary';


--
-- TOC entry 694 (class 1255 OID 16882)
-- Dependencies: 5 1404 1404 1404
-- Name: st_symdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_symdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'symdifference';


--
-- TOC entry 696 (class 1255 OID 16884)
-- Dependencies: 5 1404 1404 1404
-- Name: st_symmetricdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_symmetricdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'symdifference';


--
-- TOC entry 631 (class 1255 OID 16797)
-- Dependencies: 5 1404
-- Name: st_text(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_text(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_text';


--
-- TOC entry 721 (class 1255 OID 16924)
-- Dependencies: 5 1404 1404
-- Name: st_touches(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_touches(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Touches($1,$2)$_$;


--
-- TOC entry 613 (class 1255 OID 16779)
-- Dependencies: 5 1404 1404
-- Name: st_transform(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_transform(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'transform';


--
-- TOC entry 328 (class 1255 OID 16421)
-- Dependencies: 1404 1404 5
-- Name: st_translate(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_translate(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT translate($1, $2, $3, 0)$_$;


--
-- TOC entry 326 (class 1255 OID 16419)
-- Dependencies: 1404 5 1404
-- Name: st_translate(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_translate(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1, 1, 0, 0, 0, 1, 0, 0, 0, 1, $2, $3, $4)$_$;


--
-- TOC entry 334 (class 1255 OID 16427)
-- Dependencies: 1404 5 1404
-- Name: st_transscale(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_transscale(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $4, 0, 0,  0, $5, 0,
		0, 0, 1,  $2 * $4, $3 * $5, 0)$_$;


--
-- TOC entry 712 (class 1255 OID 16908)
-- Dependencies: 5 1404 1406
-- Name: st_union(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_union(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_union_geometry_array';


--
-- TOC entry 698 (class 1255 OID 16886)
-- Dependencies: 5 1404 1404 1404
-- Name: st_union(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_union(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geomunion';


--
-- TOC entry 711 (class 1255 OID 16907)
-- Dependencies: 5 1404 1406
-- Name: st_unite_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_unite_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_union_geometry_array';


--
-- TOC entry 431 (class 1255 OID 16579)
-- Dependencies: 1416 5
-- Name: st_width(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_width(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getWidth';


--
-- TOC entry 732 (class 1255 OID 16935)
-- Dependencies: 5 1404 1404
-- Name: st_within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_within(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Within($1,$2)$_$;


--
-- TOC entry 975 (class 1255 OID 17173)
-- Dependencies: 1404 5
-- Name: st_wkbtosql(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_wkbtosql(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_WKB';


--
-- TOC entry 974 (class 1255 OID 17172)
-- Dependencies: 5 1404
-- Name: st_wkttosql(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_wkttosql(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


--
-- TOC entry 814 (class 1255 OID 17017)
-- Dependencies: 5 1404
-- Name: st_x(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_x(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_x_point';


--
-- TOC entry 353 (class 1255 OID 16451)
-- Dependencies: 5 1408
-- Name: st_xmax(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_xmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_xmax';


--
-- TOC entry 347 (class 1255 OID 16445)
-- Dependencies: 1408 5
-- Name: st_xmin(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_xmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_xmin';


--
-- TOC entry 816 (class 1255 OID 17019)
-- Dependencies: 1404 5
-- Name: st_y(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_y(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_y_point';


--
-- TOC entry 317 (class 1255 OID 16453)
-- Dependencies: 5 1408
-- Name: st_ymax(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ymax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_ymax';


--
-- TOC entry 349 (class 1255 OID 16447)
-- Dependencies: 5 1408
-- Name: st_ymin(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ymin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_ymin';


--
-- TOC entry 818 (class 1255 OID 17021)
-- Dependencies: 5 1404
-- Name: st_z(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_z(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_z_point';


--
-- TOC entry 356 (class 1255 OID 16455)
-- Dependencies: 5 1408
-- Name: st_zmax(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_zmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_zmax';


--
-- TOC entry 509 (class 1255 OID 16657)
-- Dependencies: 5 1404
-- Name: st_zmflag(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_zmflag(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_zmflag';


--
-- TOC entry 351 (class 1255 OID 16449)
-- Dependencies: 5 1408
-- Name: st_zmin(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_zmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_zmin';


--
-- TOC entry 821 (class 1255 OID 17024)
-- Dependencies: 1404 5 1404
-- Name: startpoint(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION startpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_startpoint_linestring';


--
-- TOC entry 441 (class 1255 OID 16589)
-- Dependencies: 1404 5
-- Name: summary(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION summary(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_summary';


--
-- TOC entry 693 (class 1255 OID 16881)
-- Dependencies: 5 1404 1404 1404
-- Name: symdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION symdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'symdifference';


--
-- TOC entry 695 (class 1255 OID 16883)
-- Dependencies: 5 1404 1404 1404
-- Name: symmetricdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION symmetricdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'symdifference';


--
-- TOC entry 641 (class 1255 OID 16813)
-- Dependencies: 1404 5
-- Name: text(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION text(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_text';


--
-- TOC entry 719 (class 1255 OID 16922)
-- Dependencies: 5 1404 1404
-- Name: touches(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION touches(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'touches';


--
-- TOC entry 612 (class 1255 OID 16778)
-- Dependencies: 1404 1404 5
-- Name: transform(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION transform(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'transform';


--
-- TOC entry 327 (class 1255 OID 16420)
-- Dependencies: 5 1404 1404
-- Name: translate(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION translate(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT translate($1, $2, $3, 0)$_$;


--
-- TOC entry 325 (class 1255 OID 16418)
-- Dependencies: 5 1404 1404
-- Name: translate(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION translate(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1, 1, 0, 0, 0, 1, 0, 0, 0, 1, $2, $3, $4)$_$;


--
-- TOC entry 333 (class 1255 OID 16426)
-- Dependencies: 5 1404 1404
-- Name: transscale(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION transscale(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $4, 0, 0,  0, $5, 0,
		0, 0, 1,  $2 * $4, $3 * $5, 0)$_$;


--
-- TOC entry 710 (class 1255 OID 16906)
-- Dependencies: 5 1404 1406
-- Name: unite_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION unite_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_union_geometry_array';


--
-- TOC entry 958 (class 1255 OID 17159)
-- Dependencies: 1734 5
-- Name: unlockrows(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION unlockrows(text) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$ 
DECLARE
	ret int;
BEGIN

	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	EXECUTE 'DELETE FROM authorization_table where authid = ' ||
		quote_literal($1);

	GET DIAGNOSTICS ret = ROW_COUNT;

	RETURN ret;
END;
$_$;


--
-- TOC entry 1088 (class 1255 OID 21634)
-- Dependencies: 5
-- Name: update_geometry_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION update_geometry_stats() RETURNS text
    LANGUAGE sql
    AS $$ SELECT 'update_geometry_stats() has been obsoleted. Statistics are automatically built running the ANALYZE command'::text$$;


--
-- TOC entry 1089 (class 1255 OID 21635)
-- Dependencies: 5
-- Name: update_geometry_stats(character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION update_geometry_stats(character varying, character varying) RETURNS text
    LANGUAGE sql
    AS $$SELECT update_geometry_stats();$$;


--
-- TOC entry 606 (class 1255 OID 16774)
-- Dependencies: 1734 5
-- Name: updategeometrysrid(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION updategeometrysrid(character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT UpdateGeometrySRID('','',$1,$2,$3) into ret;
	RETURN ret;
END;
$_$;


--
-- TOC entry 605 (class 1255 OID 16773)
-- Dependencies: 1734 5
-- Name: updategeometrysrid(character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION updategeometrysrid(character varying, character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT UpdateGeometrySRID('',$1,$2,$3,$4) into ret;
	RETURN ret;
END;
$_$;


--
-- TOC entry 604 (class 1255 OID 16772)
-- Dependencies: 1734 5
-- Name: updategeometrysrid(character varying, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION updategeometrysrid(character varying, character varying, character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1;
	schema_name alias for $2;
	table_name alias for $3;
	column_name alias for $4;
	new_srid alias for $5;
	myrec RECORD;
	okay boolean;
	cname varchar;
	real_schema name;

BEGIN


	-- Find, check or fix schema_name
	IF ( schema_name != '' ) THEN
		okay = 'f';

		FOR myrec IN SELECT nspname FROM pg_namespace WHERE text(nspname) = schema_name LOOP
			okay := 't';
		END LOOP;

		IF ( okay <> 't' ) THEN
			RAISE EXCEPTION 'Invalid schema name';
		ELSE
			real_schema = schema_name;
		END IF;
	ELSE
		SELECT INTO real_schema current_schema()::text;
	END IF;

	-- Find out if the column is in the geometry_columns table
	okay = 'f';
	FOR myrec IN SELECT * from geometry_columns where f_table_schema = text(real_schema) and f_table_name = table_name and f_geometry_column = column_name LOOP
		okay := 't';
	END LOOP;
	IF (okay <> 't') THEN
		RAISE EXCEPTION 'column not found in geometry_columns table';
		RETURN 'f';
	END IF;

	-- Update ref from geometry_columns table
	EXECUTE 'UPDATE geometry_columns SET SRID = ' || new_srid::text ||
		' where f_table_schema = ' ||
		quote_literal(real_schema) || ' and f_table_name = ' ||
		quote_literal(table_name)  || ' and f_geometry_column = ' ||
		quote_literal(column_name);

	-- Make up constraint name
	cname = 'enforce_srid_'  || column_name;

	-- Drop enforce_srid constraint
	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) ||
		'.' || quote_ident(table_name) ||
		' DROP constraint ' || quote_ident(cname);

	-- Update geometries SRID
	EXECUTE 'UPDATE ' || quote_ident(real_schema) ||
		'.' || quote_ident(table_name) ||
		' SET ' || quote_ident(column_name) ||
		' = setSRID(' || quote_ident(column_name) ||
		', ' || new_srid::text || ')';

	-- Reset enforce_srid constraint
	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) ||
		'.' || quote_ident(table_name) ||
		' ADD constraint ' || quote_ident(cname) ||
		' CHECK (srid(' || quote_ident(column_name) ||
		') = ' || new_srid::text || ')';

	RETURN real_schema || '.' || table_name || '.' || column_name ||' SRID changed to ' || new_srid::text;

END;
$_$;


--
-- TOC entry 430 (class 1255 OID 16578)
-- Dependencies: 1416 5
-- Name: width(chip); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION width(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getWidth';


--
-- TOC entry 730 (class 1255 OID 16933)
-- Dependencies: 5 1404 1404
-- Name: within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION within(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'within';


--
-- TOC entry 813 (class 1255 OID 17016)
-- Dependencies: 5 1404
-- Name: x(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION x(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_x_point';


--
-- TOC entry 352 (class 1255 OID 16450)
-- Dependencies: 5 1408
-- Name: xmax(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION xmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_xmax';


--
-- TOC entry 346 (class 1255 OID 16444)
-- Dependencies: 5 1408
-- Name: xmin(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION xmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_xmin';


--
-- TOC entry 815 (class 1255 OID 17018)
-- Dependencies: 5 1404
-- Name: y(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION y(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_y_point';


--
-- TOC entry 354 (class 1255 OID 16452)
-- Dependencies: 5 1408
-- Name: ymax(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ymax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_ymax';


--
-- TOC entry 348 (class 1255 OID 16446)
-- Dependencies: 5 1408
-- Name: ymin(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ymin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_ymin';


--
-- TOC entry 817 (class 1255 OID 17020)
-- Dependencies: 1404 5
-- Name: z(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION z(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_z_point';


--
-- TOC entry 355 (class 1255 OID 16454)
-- Dependencies: 5 1408
-- Name: zmax(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION zmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_zmax';


--
-- TOC entry 508 (class 1255 OID 16656)
-- Dependencies: 5 1404
-- Name: zmflag(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION zmflag(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_zmflag';


--
-- TOC entry 350 (class 1255 OID 16448)
-- Dependencies: 1408 5
-- Name: zmin(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION zmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_zmin';


--
-- TOC entry 1743 (class 1255 OID 16904)
-- Dependencies: 5 1406 1404 704 705
-- Name: accum(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE accum(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_accum_finalfn
);


--
-- TOC entry 1746 (class 1255 OID 16910)
-- Dependencies: 5 1404 1404 704 707
-- Name: collect(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE collect(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_collect_finalfn
);


--
-- TOC entry 1735 (class 1255 OID 16727)
-- Dependencies: 5 1412 1404 575
-- Name: extent(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE extent(geometry) (
    SFUNC = public.st_combine_bbox,
    STYPE = box3d_extent
);


--
-- TOC entry 1737 (class 1255 OID 16731)
-- Dependencies: 5 576 1404 1408
-- Name: extent3d(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE extent3d(geometry) (
    SFUNC = public.combine_bbox,
    STYPE = box3d
);


--
-- TOC entry 1750 (class 1255 OID 16914)
-- Dependencies: 5 1404 1404 704 709
-- Name: makeline(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE makeline(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_makeline_finalfn
);


--
-- TOC entry 1739 (class 1255 OID 16889)
-- Dependencies: 5 1404 1404 700
-- Name: memcollect(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE memcollect(geometry) (
    SFUNC = public.st_collect,
    STYPE = geometry
);


--
-- TOC entry 1741 (class 1255 OID 16892)
-- Dependencies: 5 1404 1404 697
-- Name: memgeomunion(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE memgeomunion(geometry) (
    SFUNC = geomunion,
    STYPE = geometry
);


--
-- TOC entry 1748 (class 1255 OID 16912)
-- Dependencies: 5 1404 1404 704 708
-- Name: polygonize(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE polygonize(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_polygonize_finalfn
);


--
-- TOC entry 1744 (class 1255 OID 16905)
-- Dependencies: 5 1406 1404 704 705
-- Name: st_accum(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_accum(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_accum_finalfn
);


--
-- TOC entry 1747 (class 1255 OID 16911)
-- Dependencies: 5 1404 1404 704 707
-- Name: st_collect(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_collect(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_collect_finalfn
);


--
-- TOC entry 1736 (class 1255 OID 16728)
-- Dependencies: 5 1412 575 1404
-- Name: st_extent(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_extent(geometry) (
    SFUNC = public.st_combine_bbox,
    STYPE = box3d_extent
);


--
-- TOC entry 1738 (class 1255 OID 16732)
-- Dependencies: 1404 1408 5 577
-- Name: st_extent3d(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_extent3d(geometry) (
    SFUNC = public.st_combine_bbox,
    STYPE = box3d
);


--
-- TOC entry 1751 (class 1255 OID 16915)
-- Dependencies: 5 1404 1404 704 709
-- Name: st_makeline(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_makeline(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_makeline_finalfn
);


--
-- TOC entry 1740 (class 1255 OID 16890)
-- Dependencies: 5 1404 1404 700
-- Name: st_memcollect(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_memcollect(geometry) (
    SFUNC = public.st_collect,
    STYPE = geometry
);


--
-- TOC entry 1742 (class 1255 OID 16893)
-- Dependencies: 5 1404 1404 698
-- Name: st_memunion(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_memunion(geometry) (
    SFUNC = public.st_union,
    STYPE = geometry
);


--
-- TOC entry 1749 (class 1255 OID 16913)
-- Dependencies: 5 1404 1404 704 708
-- Name: st_polygonize(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_polygonize(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_polygonize_finalfn
);


--
-- TOC entry 1745 (class 1255 OID 16909)
-- Dependencies: 5 1404 1404 704 706
-- Name: st_union(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_union(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_union_finalfn
);


--
-- TOC entry 2467 (class 2617 OID 16531)
-- Dependencies: 1404 5 1404 406 394 395
-- Name: &&; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR && (
    PROCEDURE = geometry_overlap,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &&,
    RESTRICT = geometry_gist_sel,
    JOIN = geometry_gist_joinsel
);


--
-- TOC entry 2475 (class 2617 OID 17228)
-- Dependencies: 1010 1431 1012 5 1011 1431
-- Name: &&; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR && (
    PROCEDURE = geography_overlaps,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = &&,
    RESTRICT = geography_gist_selectivity,
    JOIN = geography_gist_join_selectivity
);


--
-- TOC entry 2464 (class 2617 OID 16526)
-- Dependencies: 1404 5 396 1404
-- Name: &<; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &< (
    PROCEDURE = geometry_overleft,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- TOC entry 2466 (class 2617 OID 16530)
-- Dependencies: 1404 5 1404 399
-- Name: &<|; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &<| (
    PROCEDURE = geometry_overbelow,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = |&>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- TOC entry 2468 (class 2617 OID 16525)
-- Dependencies: 1404 397 1404 5
-- Name: &>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &> (
    PROCEDURE = geometry_overright,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- TOC entry 2458 (class 2617 OID 16481)
-- Dependencies: 1404 1404 5 371
-- Name: <; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR < (
    PROCEDURE = geometry_lt,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2476 (class 2617 OID 17247)
-- Dependencies: 1431 5 1431 1013
-- Name: <; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR < (
    PROCEDURE = geography_lt,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2463 (class 2617 OID 16524)
-- Dependencies: 400 1404 5 1404
-- Name: <<; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR << (
    PROCEDURE = geometry_left,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = >>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- TOC entry 2465 (class 2617 OID 16528)
-- Dependencies: 403 1404 1404 5
-- Name: <<|; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <<| (
    PROCEDURE = geometry_below,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = |>>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- TOC entry 2459 (class 2617 OID 16482)
-- Dependencies: 1404 5 372 1404
-- Name: <=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <= (
    PROCEDURE = geometry_le,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2477 (class 2617 OID 17248)
-- Dependencies: 1431 1431 5 1014
-- Name: <=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <= (
    PROCEDURE = geography_le,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2460 (class 2617 OID 16483)
-- Dependencies: 1404 5 375 1404
-- Name: =; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR = (
    PROCEDURE = geometry_eq,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = =,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2478 (class 2617 OID 17249)
-- Dependencies: 5 1431 1431 1017
-- Name: =; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR = (
    PROCEDURE = geography_eq,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = =,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2462 (class 2617 OID 16479)
-- Dependencies: 373 5 1404 1404
-- Name: >; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR > (
    PROCEDURE = geometry_gt,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2480 (class 2617 OID 17245)
-- Dependencies: 1431 1015 5 1431
-- Name: >; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR > (
    PROCEDURE = geography_gt,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2461 (class 2617 OID 16480)
-- Dependencies: 5 374 1404 1404
-- Name: >=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR >= (
    PROCEDURE = geometry_ge,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2479 (class 2617 OID 17246)
-- Dependencies: 5 1431 1431 1016
-- Name: >=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR >= (
    PROCEDURE = geography_ge,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2469 (class 2617 OID 16523)
-- Dependencies: 401 1404 5 1404
-- Name: >>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR >> (
    PROCEDURE = geometry_right,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- TOC entry 2473 (class 2617 OID 16534)
-- Dependencies: 1404 5 1404 405
-- Name: @; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR @ (
    PROCEDURE = geometry_contained,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2470 (class 2617 OID 16529)
-- Dependencies: 5 1404 398 1404
-- Name: |&>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR |&> (
    PROCEDURE = geometry_overabove,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &<|,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- TOC entry 2471 (class 2617 OID 16527)
-- Dependencies: 1404 5 1404 402
-- Name: |>>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR |>> (
    PROCEDURE = geometry_above,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <<|,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- TOC entry 2474 (class 2617 OID 16533)
-- Dependencies: 1404 5 1404 404
-- Name: ~; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ~ (
    PROCEDURE = geometry_contain,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- TOC entry 2472 (class 2617 OID 16532)
-- Dependencies: 407 5 1404 1404
-- Name: ~=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ~= (
    PROCEDURE = geometry_samebox,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = ~=,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


--
-- TOC entry 2597 (class 2616 OID 17251)
-- Dependencies: 5 1431 2671
-- Name: btree_geography_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS btree_geography_ops
    DEFAULT FOR TYPE geography USING btree AS
    OPERATOR 1 <(geography,geography) ,
    OPERATOR 2 <=(geography,geography) ,
    OPERATOR 3 =(geography,geography) ,
    OPERATOR 4 >=(geography,geography) ,
    OPERATOR 5 >(geography,geography) ,
    FUNCTION 1 geography_cmp(geography,geography);


--
-- TOC entry 2594 (class 2616 OID 16485)
-- Dependencies: 1404 5 2668
-- Name: btree_geometry_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS btree_geometry_ops
    DEFAULT FOR TYPE geometry USING btree AS
    OPERATOR 1 <(geometry,geometry) ,
    OPERATOR 2 <=(geometry,geometry) ,
    OPERATOR 3 =(geometry,geometry) ,
    OPERATOR 4 >=(geometry,geometry) ,
    OPERATOR 5 >(geometry,geometry) ,
    FUNCTION 1 geometry_cmp(geometry,geometry);


--
-- TOC entry 2596 (class 2616 OID 17230)
-- Dependencies: 2670 1431 1435 5
-- Name: gist_geography_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS gist_geography_ops
    DEFAULT FOR TYPE geography USING gist AS
    STORAGE gidx ,
    OPERATOR 3 &&(geography,geography) ,
    FUNCTION 1 geography_gist_consistent(internal,geometry,integer) ,
    FUNCTION 2 geography_gist_union(bytea,internal) ,
    FUNCTION 3 geography_gist_compress(internal) ,
    FUNCTION 4 geography_gist_decompress(internal) ,
    FUNCTION 5 geography_gist_penalty(internal,internal,internal) ,
    FUNCTION 6 geography_gist_picksplit(internal,internal) ,
    FUNCTION 7 geography_gist_same(box2d,box2d,internal);


--
-- TOC entry 2595 (class 2616 OID 16543)
-- Dependencies: 1420 1404 5 2669
-- Name: gist_geometry_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS gist_geometry_ops
    DEFAULT FOR TYPE geometry USING gist AS
    STORAGE box2d ,
    OPERATOR 1 <<(geometry,geometry) ,
    OPERATOR 2 &<(geometry,geometry) ,
    OPERATOR 3 &&(geometry,geometry) ,
    OPERATOR 4 &>(geometry,geometry) ,
    OPERATOR 5 >>(geometry,geometry) ,
    OPERATOR 6 ~=(geometry,geometry) ,
    OPERATOR 7 ~(geometry,geometry) ,
    OPERATOR 8 @(geometry,geometry) ,
    OPERATOR 9 &<|(geometry,geometry) ,
    OPERATOR 10 <<|(geometry,geometry) ,
    OPERATOR 11 |>>(geometry,geometry) ,
    OPERATOR 12 |&>(geometry,geometry) ,
    FUNCTION 1 lwgeom_gist_consistent(internal,geometry,integer) ,
    FUNCTION 2 lwgeom_gist_union(bytea,internal) ,
    FUNCTION 3 lwgeom_gist_compress(internal) ,
    FUNCTION 4 lwgeom_gist_decompress(internal) ,
    FUNCTION 5 lwgeom_gist_penalty(internal,internal,internal) ,
    FUNCTION 6 lwgeom_gist_picksplit(internal,internal) ,
    FUNCTION 7 lwgeom_gist_same(box2d,box2d,internal);


SET search_path = pg_catalog;

--
-- TOC entry 3060 (class 2605 OID 16825)
-- Dependencies: 639 1420 1408 639
-- Name: CAST (public.box2d AS public.box3d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box2d AS public.box3d) WITH FUNCTION public.box3d(public.box2d) AS IMPLICIT;


--
-- TOC entry 3059 (class 2605 OID 16826)
-- Dependencies: 643 1420 1404 643
-- Name: CAST (public.box2d AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box2d AS public.geometry) WITH FUNCTION public.geometry(public.box2d) AS IMPLICIT;


--
-- TOC entry 3053 (class 2605 OID 16827)
-- Dependencies: 640 1408 640
-- Name: CAST (public.box3d AS box); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box3d AS box) WITH FUNCTION public.box(public.box3d) AS IMPLICIT;


--
-- TOC entry 3055 (class 2605 OID 16824)
-- Dependencies: 638 1420 638 1408
-- Name: CAST (public.box3d AS public.box2d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box3d AS public.box2d) WITH FUNCTION public.box2d(public.box3d) AS IMPLICIT;


--
-- TOC entry 3054 (class 2605 OID 16828)
-- Dependencies: 644 1408 1404 644
-- Name: CAST (public.box3d AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box3d AS public.geometry) WITH FUNCTION public.geometry(public.box3d) AS IMPLICIT;


--
-- TOC entry 3058 (class 2605 OID 16835)
-- Dependencies: 344 1412 1420 344
-- Name: CAST (public.box3d_extent AS public.box2d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box3d_extent AS public.box2d) WITH FUNCTION public.box2d(public.box3d_extent) AS IMPLICIT;


--
-- TOC entry 3057 (class 2605 OID 16834)
-- Dependencies: 343 1412 1408 343
-- Name: CAST (public.box3d_extent AS public.box3d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box3d_extent AS public.box3d) WITH FUNCTION public.box3d_extent(public.box3d_extent) AS IMPLICIT;


--
-- TOC entry 3056 (class 2605 OID 16836)
-- Dependencies: 345 1412 1404 345
-- Name: CAST (public.box3d_extent AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box3d_extent AS public.geometry) WITH FUNCTION public.geometry(public.box3d_extent) AS IMPLICIT;


--
-- TOC entry 2853 (class 2605 OID 16832)
-- Dependencies: 647 1404 647
-- Name: CAST (bytea AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (bytea AS public.geometry) WITH FUNCTION public.geometry(bytea) AS IMPLICIT;


--
-- TOC entry 3061 (class 2605 OID 16831)
-- Dependencies: 646 1416 1404 646
-- Name: CAST (public.chip AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.chip AS public.geometry) WITH FUNCTION public.geometry(public.chip) AS IMPLICIT;


--
-- TOC entry 3063 (class 2605 OID 17198)
-- Dependencies: 990 1431 990 1431
-- Name: CAST (public.geography AS public.geography); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geography AS public.geography) WITH FUNCTION public.geography(public.geography, integer, boolean) AS IMPLICIT;


--
-- TOC entry 3062 (class 2605 OID 17217)
-- Dependencies: 1002 1404 1002 1431
-- Name: CAST (public.geography AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geography AS public.geometry) WITH FUNCTION public.geometry(public.geography);


--
-- TOC entry 3049 (class 2605 OID 16823)
-- Dependencies: 608 1404 608
-- Name: CAST (public.geometry AS box); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS box) WITH FUNCTION public.box(public.geometry) AS IMPLICIT;


--
-- TOC entry 3051 (class 2605 OID 16821)
-- Dependencies: 594 1404 1420 594
-- Name: CAST (public.geometry AS public.box2d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS public.box2d) WITH FUNCTION public.box2d(public.geometry) AS IMPLICIT;


--
-- TOC entry 3050 (class 2605 OID 16822)
-- Dependencies: 607 1404 1408 607
-- Name: CAST (public.geometry AS public.box3d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS public.box3d) WITH FUNCTION public.box3d(public.geometry) AS IMPLICIT;


--
-- TOC entry 3047 (class 2605 OID 16833)
-- Dependencies: 648 648 1404
-- Name: CAST (public.geometry AS bytea); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS bytea) WITH FUNCTION public.bytea(public.geometry) AS IMPLICIT;


--
-- TOC entry 3052 (class 2605 OID 17215)
-- Dependencies: 1001 1404 1001 1431
-- Name: CAST (public.geometry AS public.geography); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS public.geography) WITH FUNCTION public.geography(public.geometry) AS IMPLICIT;


--
-- TOC entry 3048 (class 2605 OID 16830)
-- Dependencies: 641 1404 641
-- Name: CAST (public.geometry AS text); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS text) WITH FUNCTION public.text(public.geometry) AS IMPLICIT;


--
-- TOC entry 2921 (class 2605 OID 16829)
-- Dependencies: 645 1404 645
-- Name: CAST (text AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (text AS public.geometry) WITH FUNCTION public.geometry(text) AS IMPLICIT;


SET search_path = public, pg_catalog;

--
-- TOC entry 163 (class 1259 OID 21636)
-- Dependencies: 5
-- Name: admin_user_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 164 (class 1259 OID 21638)
-- Dependencies: 5
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admin_users (
    admin_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- TOC entry 165 (class 1259 OID 21641)
-- Dependencies: 5
-- Name: analysis_elements_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE analysis_elements_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 166 (class 1259 OID 21643)
-- Dependencies: 5
-- Name: analysis_oxides_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE analysis_oxides_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 282 (class 1259 OID 26925)
-- Dependencies: 5
-- Name: denorm_sample_minerals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE denorm_sample_minerals (
    sample_id integer NOT NULL,
    mineral_info text
);


--
-- TOC entry 232 (class 1259 OID 21862)
-- Dependencies: 5
-- Name: rock_type; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rock_type (
    rock_type_id smallint NOT NULL,
    rock_type character varying(100) NOT NULL
);


--
-- TOC entry 266 (class 1259 OID 21958)
-- Dependencies: 3192 3193 3194 3195 5 1404
-- Name: samples; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE samples (
    sample_id bigint NOT NULL,
    version integer NOT NULL,
    sesar_number character(9),
    public_data character(1) NOT NULL,
    collection_date timestamp without time zone,
    date_precision smallint,
    number character varying(35) NOT NULL,
    rock_type_id smallint NOT NULL,
    user_id integer NOT NULL,
    location_error real,
    country character varying(100),
    description text,
    collector character varying(50),
    collector_id integer,
    location_text character varying(50),
    location geometry NOT NULL,
    CONSTRAINT enforce_dims_location CHECK ((ndims(location) = 2)),
    CONSTRAINT enforce_geotype_location CHECK (((geometrytype(location) = 'POINT'::text) OR (location IS NULL))),
    CONSTRAINT enforce_srid_location CHECK ((srid(location) = 4326)),
    CONSTRAINT samples_public_data_check CHECK (((public_data = 'Y'::bpchar) OR (public_data = 'N'::bpchar)))
);


--
-- TOC entry 277 (class 1259 OID 22005)
-- Dependencies: 5
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    user_id integer NOT NULL,
    version integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password bytea NOT NULL,
    address character varying(200),
    city character varying(50),
    province character varying(100),
    country character varying(100),
    postal_code character varying(15),
    institution character varying(300),
    reference_email character varying(255),
    confirmation_code character(32),
    enabled character(1) NOT NULL,
    role_id smallint,
    contributor_code character(32),
    contributor_enabled character(1),
    professional_url character varying(255),
    research_interests character varying(1024),
    request_contributor character(1)
);


--
-- TOC entry 283 (class 1259 OID 26949)
-- Dependencies: 3166 5
-- Name: basic_sample_results; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW basic_sample_results AS
    SELECT s.sample_id, s.number AS sample_number, s.public_data, rt.rock_type_id, rt.rock_type AS rock_type_name, s.user_id AS owner_id, u.name AS owner_name, s.country, st_y(s.location) AS latitude, st_x(s.location) AS longitude, dsm.mineral_info FROM samples s, rock_type rt, users u, denorm_sample_minerals dsm WHERE (((s.rock_type_id = rt.rock_type_id) AND (s.user_id = u.user_id)) AND (s.sample_id = dsm.sample_id));


--
-- TOC entry 167 (class 1259 OID 21645)
-- Dependencies: 3169 3170 3171 5
-- Name: chemical_analyses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chemical_analyses (
    chemical_analysis_id bigint NOT NULL,
    version integer NOT NULL,
    subsample_id bigint NOT NULL,
    public_data character(1) NOT NULL,
    reference_x double precision,
    reference_y double precision,
    stage_x double precision,
    stage_y double precision,
    image_id bigint,
    analysis_method character varying(50),
    where_done character varying(50),
    analyst character varying(50),
    analysis_date timestamp without time zone,
    date_precision smallint DEFAULT 0,
    reference_id bigint,
    description character varying(1024),
    mineral_id smallint,
    user_id integer NOT NULL,
    large_rock character(1) NOT NULL,
    total double precision,
    spot_id bigint NOT NULL,
    CONSTRAINT chemical_analyses_large_rock_check CHECK (((large_rock = 'Y'::bpchar) OR (large_rock = 'N'::bpchar))),
    CONSTRAINT chemical_analyses_public_data_check CHECK (((public_data = 'Y'::bpchar) OR (public_data = 'N'::bpchar)))
);


--
-- TOC entry 168 (class 1259 OID 21654)
-- Dependencies: 3172 5
-- Name: chemical_analyses_archive; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chemical_analyses_archive (
    chemical_analysis_id bigint NOT NULL,
    version integer NOT NULL,
    spot_id character varying(50) NOT NULL,
    subsample_id bigint NOT NULL,
    subsample_version bigint NOT NULL,
    point_x smallint,
    point_y smallint,
    image_id bigint,
    analysis_method character varying(50),
    where_done character varying(50),
    analyst character varying(50),
    analysis_date timestamp without time zone,
    date_precision smallint,
    reference_id bigint,
    description character varying(1024),
    mineral_id smallint,
    large_rock character(1) NOT NULL,
    total real,
    CONSTRAINT chemical_analyses_archive_large_rock_check CHECK (((large_rock = 'Y'::bpchar) OR (large_rock = 'N'::bpchar)))
);


--
-- TOC entry 169 (class 1259 OID 21661)
-- Dependencies: 5
-- Name: chemical_analyses_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chemical_analyses_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 170 (class 1259 OID 21663)
-- Dependencies: 3173 5
-- Name: chemical_analysis_elements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chemical_analysis_elements (
    chemical_analysis_id bigint NOT NULL,
    element_id smallint NOT NULL,
    amount double precision NOT NULL,
    "precision" double precision,
    precision_type character varying(3),
    measurement_unit character varying(4),
    min_amount double precision,
    max_amount double precision,
    CONSTRAINT analysis_elements_ck CHECK ((((precision_type)::text = 'ABS'::text) OR ((precision_type)::text = 'REL'::text)))
);


--
-- TOC entry 171 (class 1259 OID 21667)
-- Dependencies: 3174 5
-- Name: chemical_analysis_elements_archive; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chemical_analysis_elements_archive (
    chemical_analysis_id bigint NOT NULL,
    chemical_analysis_version integer NOT NULL,
    element_id smallint NOT NULL,
    amount real NOT NULL,
    "precision" real,
    precision_type character varying(3),
    measurement_unit character varying(4),
    min_amount real,
    max_amount real,
    CONSTRAINT analysis_elements_ck_archive CHECK ((((precision_type)::text = 'ABS'::text) OR ((precision_type)::text = 'REL'::text)))
);


--
-- TOC entry 172 (class 1259 OID 21671)
-- Dependencies: 5
-- Name: chemical_analysis_elements_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chemical_analysis_elements_dup (
    chemical_analysis_id bigint,
    element_id smallint,
    amount double precision,
    "precision" double precision,
    precision_type character varying(3),
    measurement_unit character varying(4),
    min_amount double precision,
    max_amount double precision,
    id integer NOT NULL
);


--
-- TOC entry 173 (class 1259 OID 21674)
-- Dependencies: 5
-- Name: chemical_analysis_elements_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chemical_analysis_elements_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 174 (class 1259 OID 21676)
-- Dependencies: 5
-- Name: chemical_analysis_elements_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chemical_analysis_elements_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 175 (class 1259 OID 21678)
-- Dependencies: 3175 5
-- Name: chemical_analysis_oxides; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chemical_analysis_oxides (
    chemical_analysis_id bigint NOT NULL,
    oxide_id smallint NOT NULL,
    amount double precision NOT NULL,
    "precision" double precision,
    precision_type character varying(3),
    measurement_unit character varying(4),
    min_amount double precision,
    max_amount double precision,
    CONSTRAINT analysis_oxides_ck CHECK ((((precision_type)::text = 'ABS'::text) OR ((precision_type)::text = 'REL'::text)))
);


--
-- TOC entry 176 (class 1259 OID 21682)
-- Dependencies: 3176 5
-- Name: chemical_analysis_oxides_archive; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chemical_analysis_oxides_archive (
    chemical_analysis_id bigint NOT NULL,
    chemical_analysis_version integer NOT NULL,
    oxide_id smallint NOT NULL,
    amount real NOT NULL,
    "precision" real,
    precision_type character varying(3),
    measurement_unit character varying(4),
    min_amount real,
    max_amount real,
    CONSTRAINT analysis_oxides_ck_archive CHECK ((((precision_type)::text = 'ABS'::text) OR ((precision_type)::text = 'REL'::text)))
);


--
-- TOC entry 177 (class 1259 OID 21686)
-- Dependencies: 5
-- Name: chemical_analysis_oxides_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chemical_analysis_oxides_dup (
    chemical_analysis_id bigint,
    oxide_id smallint,
    amount double precision,
    "precision" double precision,
    precision_type character varying(3),
    measurement_unit character varying(4),
    min_amount double precision,
    max_amount double precision,
    id integer NOT NULL
);


--
-- TOC entry 178 (class 1259 OID 21689)
-- Dependencies: 5
-- Name: chemical_analysis_oxides_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chemical_analysis_oxides_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 179 (class 1259 OID 21691)
-- Dependencies: 5
-- Name: chemical_analysis_oxides_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chemical_analysis_oxides_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 180 (class 1259 OID 21693)
-- Dependencies: 5
-- Name: element_mineral_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE element_mineral_types (
    element_id smallint NOT NULL,
    mineral_type_id smallint NOT NULL
);


--
-- TOC entry 181 (class 1259 OID 21696)
-- Dependencies: 5
-- Name: element_mineral_types_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE element_mineral_types_dup (
    element_id smallint,
    mineral_type_id smallint,
    id integer NOT NULL
);


--
-- TOC entry 182 (class 1259 OID 21699)
-- Dependencies: 5
-- Name: element_mineral_types_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE element_mineral_types_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 183 (class 1259 OID 21701)
-- Dependencies: 5
-- Name: element_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE element_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 184 (class 1259 OID 21703)
-- Dependencies: 5
-- Name: elements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE elements (
    element_id smallint NOT NULL,
    name character varying(100) NOT NULL,
    alternate_name character varying(100),
    symbol character varying(4) NOT NULL,
    atomic_number integer NOT NULL,
    weight real,
    order_id integer
);


--
-- TOC entry 186 (class 1259 OID 21712)
-- Dependencies: 5
-- Name: georeference; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE georeference (
    georef_id bigint NOT NULL,
    title text NOT NULL,
    first_author text NOT NULL,
    second_authors text,
    journal_name text NOT NULL,
    full_text text NOT NULL,
    reference_number text,
    reference_id bigint,
    doi text,
    journal_name_2 text,
    publication_year text
);


--
-- TOC entry 204 (class 1259 OID 21777)
-- Dependencies: 5
-- Name: metamorphic_grades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE metamorphic_grades (
    metamorphic_grade_id smallint NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 21780)
-- Dependencies: 3185 3186 3187 3188 3189 3190 1404 1404 5
-- Name: metamorphic_regions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE metamorphic_regions (
    metamorphic_region_id bigint NOT NULL,
    name character varying(50) NOT NULL,
    shape geometry,
    description text,
    label_location geometry,
    CONSTRAINT enforce_dims_label_location CHECK ((ndims(label_location) = 2)),
    CONSTRAINT enforce_dims_shape CHECK ((ndims(shape) = 2)),
    CONSTRAINT enforce_geotype_label_location CHECK (((geometrytype(label_location) = 'POINT'::text) OR (label_location IS NULL))),
    CONSTRAINT enforce_geotype_shape CHECK (((geometrytype(shape) = 'POLYGON'::text) OR (shape IS NULL))),
    CONSTRAINT enforce_srid_label_location CHECK ((srid(label_location) = 4326)),
    CONSTRAINT enforce_srid_shape CHECK ((srid(shape) = 4326))
);


--
-- TOC entry 215 (class 1259 OID 21817)
-- Dependencies: 5
-- Name: minerals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE minerals (
    mineral_id smallint NOT NULL,
    real_mineral_id smallint NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 21849)
-- Dependencies: 5
-- Name: reference; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reference (
    reference_id bigint NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 21859)
-- Dependencies: 5
-- Name: regions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE regions (
    region_id smallint NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 21896)
-- Dependencies: 5
-- Name: sample_metamorphic_grades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_metamorphic_grades (
    sample_id bigint NOT NULL,
    metamorphic_grade_id smallint NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 21907)
-- Dependencies: 5
-- Name: sample_metamorphic_regions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_metamorphic_regions (
    sample_id bigint NOT NULL,
    metamorphic_region_id smallint NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 21920)
-- Dependencies: 5
-- Name: sample_minerals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_minerals (
    mineral_id smallint NOT NULL,
    sample_id bigint NOT NULL,
    amount character varying(30)
);


--
-- TOC entry 256 (class 1259 OID 21931)
-- Dependencies: 5
-- Name: sample_reference; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_reference (
    sample_id bigint NOT NULL,
    reference_id bigint NOT NULL
);


--
-- TOC entry 284 (class 1259 OID 26953)
-- Dependencies: 3167 5
-- Name: sample_reference_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW sample_reference_view AS
    SELECT sr.sample_id, CASE WHEN (g.georef_id IS NULL) THEN ((-1))::bigint ELSE g.georef_id END AS publication_id, r.name AS georeference, CASE WHEN (g.journal_name_2 IS NULL) THEN ''::text ELSE g.journal_name_2 END AS journal, CASE WHEN (g.publication_year IS NULL) THEN ''::text ELSE g.publication_year END AS publication_year, CASE WHEN (g.first_author IS NULL) THEN ''::text ELSE g.first_author END AS author FROM ((sample_reference sr JOIN reference r ON ((sr.reference_id = r.reference_id))) LEFT JOIN georeference g ON ((g.reference_number = (r.name)::text)));


--
-- TOC entry 261 (class 1259 OID 21945)
-- Dependencies: 5
-- Name: sample_regions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_regions (
    sample_id bigint NOT NULL,
    region_id smallint NOT NULL
);


--
-- TOC entry 285 (class 1259 OID 26958)
-- Dependencies: 3168 5
-- Name: full_sample_results; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW full_sample_results AS
    SELECT bsr.sample_id, bsr.sample_number, bsr.public_data, bsr.rock_type_id, bsr.rock_type_name, bsr.owner_id, bsr.owner_name, bsr.country, bsr.latitude, bsr.longitude, bsr.mineral_info, CASE WHEN (sm.mineral_id IS NULL) THEN (-1) ELSE (sm.mineral_id)::integer END AS sample_mineral_id, CASE WHEN (m.name IS NULL) THEN ''::character varying ELSE m.name END AS sample_mineral_name, CASE WHEN (sr.region_id IS NULL) THEN (-1) ELSE (sr.region_id)::integer END AS sample_region_id, CASE WHEN (r.name IS NULL) THEN ''::character varying ELSE r.name END AS sample_region_name, CASE WHEN (mg.metamorphic_grade_id IS NULL) THEN (-1) ELSE (mg.metamorphic_grade_id)::integer END AS sample_metamorphic_grade_id, CASE WHEN (mg.name IS NULL) THEN ''::character varying ELSE mg.name END AS sample_metamorphic_grade, CASE WHEN (mr.metamorphic_region_id IS NULL) THEN ((-1))::bigint ELSE mr.metamorphic_region_id END AS sample_metamorphic_region_id, CASE WHEN (mr.name IS NULL) THEN ''::character varying ELSE mr.name END AS sample_metamorphic_region, srv.publication_id, srv.georeference, srv.journal, srv.publication_year, srv.author FROM (((((((((basic_sample_results bsr LEFT JOIN sample_minerals sm ON ((bsr.sample_id = sm.sample_id))) LEFT JOIN minerals m ON ((sm.mineral_id = m.mineral_id))) LEFT JOIN sample_regions sr ON ((bsr.sample_id = sr.sample_id))) LEFT JOIN regions r ON ((r.region_id = sr.region_id))) LEFT JOIN sample_metamorphic_grades smg ON ((bsr.sample_id = smg.sample_id))) LEFT JOIN metamorphic_grades mg ON ((smg.metamorphic_grade_id = mg.metamorphic_grade_id))) LEFT JOIN sample_metamorphic_regions smr ON ((bsr.sample_id = smr.sample_id))) LEFT JOIN metamorphic_regions mr ON ((smr.metamorphic_region_id = mr.metamorphic_region_id))) LEFT JOIN sample_reference_view srv ON ((srv.sample_id = bsr.sample_id)));


--
-- TOC entry 162 (class 1259 OID 17209)
-- Dependencies: 3165 5
-- Name: geography_columns; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW geography_columns AS
    SELECT current_database() AS f_table_catalog, n.nspname AS f_table_schema, c.relname AS f_table_name, a.attname AS f_geography_column, geography_typmod_dims(a.atttypmod) AS coord_dimension, geography_typmod_srid(a.atttypmod) AS srid, geography_typmod_type(a.atttypmod) AS type FROM pg_class c, pg_attribute a, pg_type t, pg_namespace n WHERE ((((((t.typname = 'geography'::name) AND (a.attisdropped = false)) AND (a.atttypid = t.oid)) AND (a.attrelid = c.oid)) AND (c.relnamespace = n.oid)) AND (NOT pg_is_other_temp_schema(c.relnamespace)));


SET default_with_oids = true;

--
-- TOC entry 185 (class 1259 OID 21706)
-- Dependencies: 5
-- Name: geometry_columns; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE geometry_columns (
    f_table_catalog character varying(256) NOT NULL,
    f_table_schema character varying(256) NOT NULL,
    f_table_name character varying(256) NOT NULL,
    f_geometry_column character varying(256) NOT NULL,
    coord_dimension integer NOT NULL,
    srid integer NOT NULL,
    type character varying(30) NOT NULL
);


SET default_with_oids = false;

--
-- TOC entry 187 (class 1259 OID 21718)
-- Dependencies: 5
-- Name: georeference_bkup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE georeference_bkup (
    georef_id bigint,
    title text,
    first_author text,
    second_authors text,
    journal_name text,
    full_text text,
    reference_number text,
    reference_id bigint
);


--
-- TOC entry 280 (class 1259 OID 22929)
-- Dependencies: 5
-- Name: georeference_bkup_2; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE georeference_bkup_2 (
    georef_id bigint,
    title text,
    first_author text,
    second_authors text,
    journal_name text,
    full_text text,
    reference_number text,
    reference_id bigint,
    journal_name_2 text,
    doi text
);


--
-- TOC entry 188 (class 1259 OID 21724)
-- Dependencies: 5
-- Name: georeference_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE georeference_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 189 (class 1259 OID 21726)
-- Dependencies: 5
-- Name: grid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE grid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 190 (class 1259 OID 21728)
-- Dependencies: 3177 5
-- Name: grids; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE grids (
    grid_id bigint NOT NULL,
    version integer NOT NULL,
    subsample_id bigint NOT NULL,
    width smallint NOT NULL,
    height smallint NOT NULL,
    public_data character(1) NOT NULL,
    CONSTRAINT grids_public_data_check CHECK (((public_data = 'Y'::bpchar) OR (public_data = 'N'::bpchar)))
);


--
-- TOC entry 191 (class 1259 OID 21732)
-- Dependencies: 5
-- Name: image_comment_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE image_comment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 192 (class 1259 OID 21734)
-- Dependencies: 5
-- Name: image_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE image_comments (
    comment_id bigint NOT NULL,
    image_id bigint NOT NULL,
    comment_text text NOT NULL,
    version integer NOT NULL
);


--
-- TOC entry 193 (class 1259 OID 21740)
-- Dependencies: 5
-- Name: image_format; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE image_format (
    image_format_id smallint NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 194 (class 1259 OID 21743)
-- Dependencies: 5
-- Name: image_format_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE image_format_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 195 (class 1259 OID 21745)
-- Dependencies: 3178 3179 3180 3181 3182 5
-- Name: image_on_grid; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE image_on_grid (
    image_on_grid_id bigint NOT NULL,
    grid_id bigint NOT NULL,
    image_id bigint NOT NULL,
    top_left_x double precision NOT NULL,
    top_left_y double precision NOT NULL,
    z_order smallint NOT NULL,
    opacity smallint DEFAULT 100 NOT NULL,
    resize_ratio real DEFAULT 100 NOT NULL,
    width smallint NOT NULL,
    height smallint NOT NULL,
    checksum character(50) NOT NULL,
    checksum_64x64 character(50) NOT NULL,
    checksum_half character(50) NOT NULL,
    locked character(1) NOT NULL,
    angle double precision DEFAULT 0,
    CONSTRAINT image_on_grid_ck_opacity CHECK (((opacity >= 0) AND (opacity <= 100))),
    CONSTRAINT image_on_grid_locked_check CHECK (((locked = 'Y'::bpchar) OR (locked = 'N'::bpchar)))
);


--
-- TOC entry 196 (class 1259 OID 21753)
-- Dependencies: 5
-- Name: image_on_grid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE image_on_grid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 197 (class 1259 OID 21755)
-- Dependencies: 5
-- Name: image_reference; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE image_reference (
    image_id bigint NOT NULL,
    reference_id bigint NOT NULL
);


--
-- TOC entry 198 (class 1259 OID 21758)
-- Dependencies: 5
-- Name: image_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE image_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 199 (class 1259 OID 21760)
-- Dependencies: 5
-- Name: image_type; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE image_type (
    image_type_id smallint NOT NULL,
    image_type character varying(100) NOT NULL,
    abbreviation character varying(10),
    comments character varying(250)
);


--
-- TOC entry 200 (class 1259 OID 21763)
-- Dependencies: 5
-- Name: image_type_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE image_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 201 (class 1259 OID 21765)
-- Dependencies: 3183 3184 5
-- Name: images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE images (
    image_id bigint NOT NULL,
    checksum character(50) NOT NULL,
    version integer NOT NULL,
    sample_id bigint,
    subsample_id bigint,
    image_format_id smallint,
    image_type_id smallint NOT NULL,
    width smallint NOT NULL,
    height smallint NOT NULL,
    collector character varying(50),
    description character varying(1024),
    scale smallint,
    user_id integer NOT NULL,
    public_data character(1) NOT NULL,
    checksum_64x64 character(50) NOT NULL,
    checksum_half character(50) NOT NULL,
    filename character varying(256) NOT NULL,
    checksum_mobile character(50),
    CONSTRAINT images_ck_nonzero CHECK (((width > 0) AND (height > 0))),
    CONSTRAINT images_public_data_check CHECK (((public_data = 'Y'::bpchar) OR (public_data = 'N'::bpchar)))
);


--
-- TOC entry 202 (class 1259 OID 21773)
-- Dependencies: 5
-- Name: invite_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invite_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 203 (class 1259 OID 21775)
-- Dependencies: 5
-- Name: metamorphic_grade_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE metamorphic_grade_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 206 (class 1259 OID 21792)
-- Dependencies: 1404 1404 5
-- Name: metamorphic_regions_bkup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE metamorphic_regions_bkup (
    metamorphic_region_id bigint,
    name character varying(50),
    shape geometry,
    description text,
    label_location geometry
);


--
-- TOC entry 207 (class 1259 OID 21798)
-- Dependencies: 5
-- Name: metamorphic_regions_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE metamorphic_regions_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 208 (class 1259 OID 21800)
-- Dependencies: 5
-- Name: mineral_analyses_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mineral_analyses_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 209 (class 1259 OID 21802)
-- Dependencies: 5
-- Name: mineral_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mineral_relationships (
    parent_mineral_id smallint NOT NULL,
    child_mineral_id smallint NOT NULL
);


--
-- TOC entry 210 (class 1259 OID 21805)
-- Dependencies: 5
-- Name: mineral_relationships_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mineral_relationships_dup (
    parent_mineral_id smallint,
    child_mineral_id smallint,
    id integer NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 21808)
-- Dependencies: 5
-- Name: mineral_relationships_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mineral_relationships_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 212 (class 1259 OID 21810)
-- Dependencies: 5
-- Name: mineral_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mineral_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 213 (class 1259 OID 21812)
-- Dependencies: 5
-- Name: mineral_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mineral_types (
    mineral_type_id smallint NOT NULL,
    name character varying(50) NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 21815)
-- Dependencies: 5
-- Name: mineral_types_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mineral_types_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 216 (class 1259 OID 21820)
-- Dependencies: 5
-- Name: oxide_mineral_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oxide_mineral_types (
    oxide_id smallint NOT NULL,
    mineral_type_id smallint NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 21823)
-- Dependencies: 5
-- Name: oxide_mineral_types_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oxide_mineral_types_dup (
    oxide_id smallint,
    mineral_type_id smallint,
    id integer NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 21826)
-- Dependencies: 5
-- Name: oxide_mineral_types_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oxide_mineral_types_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 219 (class 1259 OID 21828)
-- Dependencies: 5
-- Name: oxide_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oxide_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 220 (class 1259 OID 21830)
-- Dependencies: 5
-- Name: oxides; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oxides (
    oxide_id smallint NOT NULL,
    element_id smallint NOT NULL,
    oxidation_state smallint,
    species character varying(20),
    weight double precision,
    cations_per_oxide smallint,
    conversion_factor double precision NOT NULL,
    order_id integer
);


--
-- TOC entry 221 (class 1259 OID 21833)
-- Dependencies: 5
-- Name: pending_roles_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pending_roles_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 222 (class 1259 OID 21835)
-- Dependencies: 5
-- Name: project_invites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_invites (
    invite_id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    action_timestamp timestamp without time zone NOT NULL,
    status character varying(32)
);


--
-- TOC entry 223 (class 1259 OID 21838)
-- Dependencies: 5
-- Name: project_members; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_members (
    project_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 21841)
-- Dependencies: 5
-- Name: project_samples; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_samples (
    project_id integer NOT NULL,
    sample_id bigint NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 21844)
-- Dependencies: 5
-- Name: project_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 226 (class 1259 OID 21846)
-- Dependencies: 5
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    project_id integer NOT NULL,
    version integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(300),
    isactive character(1)
);


--
-- TOC entry 228 (class 1259 OID 21852)
-- Dependencies: 5
-- Name: reference_bkup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reference_bkup (
    reference_id bigint,
    name character varying(100)
);


--
-- TOC entry 281 (class 1259 OID 22935)
-- Dependencies: 5
-- Name: reference_bkup_2; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reference_bkup_2 (
    reference_id bigint,
    name character varying(100)
);


--
-- TOC entry 229 (class 1259 OID 21855)
-- Dependencies: 5
-- Name: reference_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE reference_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 230 (class 1259 OID 21857)
-- Dependencies: 5
-- Name: region_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE region_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 233 (class 1259 OID 21865)
-- Dependencies: 5
-- Name: rock_type_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rock_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 234 (class 1259 OID 21867)
-- Dependencies: 3191 5
-- Name: role_changes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role_changes (
    role_changes_id bigint NOT NULL,
    user_id bigint NOT NULL,
    sponsor_id bigint NOT NULL,
    request_date timestamp without time zone NOT NULL,
    finalize_date timestamp without time zone,
    role_id smallint NOT NULL,
    granted character(1),
    grant_reason text,
    request_reason text,
    CONSTRAINT role_changes_granted_check CHECK (((granted = 'Y'::bpchar) OR (granted = 'N'::bpchar)))
);


--
-- TOC entry 235 (class 1259 OID 21874)
-- Dependencies: 5
-- Name: role_changes_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_changes_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 236 (class 1259 OID 21876)
-- Dependencies: 5
-- Name: role_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 237 (class 1259 OID 21878)
-- Dependencies: 5
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    role_id smallint NOT NULL,
    role_name character varying(50) NOT NULL,
    rank smallint
);


--
-- TOC entry 238 (class 1259 OID 21881)
-- Dependencies: 5
-- Name: roles_changed_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_changed_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 239 (class 1259 OID 21883)
-- Dependencies: 5
-- Name: sample_aliases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_aliases (
    sample_alias_id bigint NOT NULL,
    sample_id bigint,
    alias character varying(35) NOT NULL
);


--
-- TOC entry 240 (class 1259 OID 21886)
-- Dependencies: 5
-- Name: sample_aliases_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_aliases_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 241 (class 1259 OID 21888)
-- Dependencies: 5
-- Name: sample_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_comments (
    comment_id bigint NOT NULL,
    sample_id bigint NOT NULL,
    user_id bigint NOT NULL,
    comment_text text NOT NULL,
    date_added timestamp without time zone
);


--
-- TOC entry 242 (class 1259 OID 21894)
-- Dependencies: 5
-- Name: sample_comments_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_comments_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 244 (class 1259 OID 21899)
-- Dependencies: 5
-- Name: sample_metamorphic_grades_archive; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_metamorphic_grades_archive (
    sample_id bigint NOT NULL,
    metamorphic_grade_id smallint NOT NULL,
    sample_version integer NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 21902)
-- Dependencies: 5
-- Name: sample_metamorphic_grades_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_metamorphic_grades_dup (
    sample_id bigint,
    metamorphic_grade_id smallint,
    id integer NOT NULL
);


--
-- TOC entry 246 (class 1259 OID 21905)
-- Dependencies: 5
-- Name: sample_metamorphic_grades_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_metamorphic_grades_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 248 (class 1259 OID 21910)
-- Dependencies: 5
-- Name: sample_metamorphic_regions_bkup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_metamorphic_regions_bkup (
    sample_id bigint,
    metamorphic_region_id smallint
);


--
-- TOC entry 249 (class 1259 OID 21913)
-- Dependencies: 5
-- Name: sample_metamorphic_regions_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_metamorphic_regions_dup (
    sample_id bigint,
    metamorphic_region_id smallint,
    id integer NOT NULL
);


--
-- TOC entry 250 (class 1259 OID 21916)
-- Dependencies: 5
-- Name: sample_metamorphic_regions_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_metamorphic_regions_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 251 (class 1259 OID 21918)
-- Dependencies: 5
-- Name: sample_metamorphic_regions_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_metamorphic_regions_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 253 (class 1259 OID 21923)
-- Dependencies: 5
-- Name: sample_minerals_archive; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_minerals_archive (
    mineral_id smallint NOT NULL,
    sample_id bigint NOT NULL,
    sample_version integer NOT NULL,
    amount real
);


--
-- TOC entry 254 (class 1259 OID 21926)
-- Dependencies: 5
-- Name: sample_minerals_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_minerals_dup (
    mineral_id smallint,
    sample_id bigint,
    amount character varying(30),
    id integer NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 21929)
-- Dependencies: 5
-- Name: sample_minerals_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_minerals_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 257 (class 1259 OID 21934)
-- Dependencies: 5
-- Name: sample_reference_archive; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_reference_archive (
    sample_id bigint NOT NULL,
    reference_id bigint NOT NULL,
    sample_version integer NOT NULL
);


--
-- TOC entry 258 (class 1259 OID 21937)
-- Dependencies: 5
-- Name: sample_reference_bkup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_reference_bkup (
    sample_id bigint,
    reference_id bigint
);


--
-- TOC entry 259 (class 1259 OID 21940)
-- Dependencies: 5
-- Name: sample_reference_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_reference_dup (
    sample_id bigint,
    reference_id bigint,
    id integer NOT NULL
);


--
-- TOC entry 260 (class 1259 OID 21943)
-- Dependencies: 5
-- Name: sample_reference_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_reference_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 262 (class 1259 OID 21948)
-- Dependencies: 5
-- Name: sample_regions_archive; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_regions_archive (
    sample_id bigint NOT NULL,
    region_id smallint NOT NULL,
    sample_version integer NOT NULL
);


--
-- TOC entry 263 (class 1259 OID 21951)
-- Dependencies: 5
-- Name: sample_regions_dup; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_regions_dup (
    sample_id bigint,
    region_id smallint,
    id integer NOT NULL
);


--
-- TOC entry 264 (class 1259 OID 21954)
-- Dependencies: 5
-- Name: sample_regions_dup_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_regions_dup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 265 (class 1259 OID 21956)
-- Dependencies: 5
-- Name: sample_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 267 (class 1259 OID 21968)
-- Dependencies: 3196 3197 3198 3199 1404 5
-- Name: samples_archive; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE samples_archive (
    sample_id bigint NOT NULL,
    version integer NOT NULL,
    sesar_number character(9),
    public_data character(1) NOT NULL,
    collection_date timestamp without time zone,
    date_precision smallint,
    alias character varying(20) NOT NULL,
    rock_type_id smallint NOT NULL,
    user_id integer NOT NULL,
    longitude_error real,
    latitude_error real,
    country character varying(100),
    description character varying(100),
    collector character varying(50),
    collector_id integer,
    location_text character varying(50),
    location geometry,
    CONSTRAINT enforce_dims_location CHECK ((ndims(location) = 2)),
    CONSTRAINT enforce_geotype_location CHECK (((geometrytype(location) = 'POINT'::text) OR (location IS NULL))),
    CONSTRAINT enforce_srid_location CHECK ((srid(location) = 4326)),
    CONSTRAINT samples_archive_public_data_check CHECK (((public_data = 'Y'::bpchar) OR (public_data = 'N'::bpchar)))
);


--
-- TOC entry 268 (class 1259 OID 21978)
-- Dependencies: 5
-- Name: spatial_ref_sys; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spatial_ref_sys (
    srid integer NOT NULL,
    auth_name character varying(256),
    auth_srid integer,
    srtext character varying(2048),
    proj4text character varying(2048)
);


--
-- TOC entry 269 (class 1259 OID 21984)
-- Dependencies: 5
-- Name: subsample_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE subsample_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 270 (class 1259 OID 21986)
-- Dependencies: 5
-- Name: subsample_type; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE subsample_type (
    subsample_type_id smallint NOT NULL,
    subsample_type character varying(100) NOT NULL
);


--
-- TOC entry 271 (class 1259 OID 21989)
-- Dependencies: 5
-- Name: subsample_type_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE subsample_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 272 (class 1259 OID 21991)
-- Dependencies: 3200 5
-- Name: subsamples; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE subsamples (
    subsample_id bigint NOT NULL,
    version integer NOT NULL,
    public_data character(1) NOT NULL,
    sample_id bigint NOT NULL,
    user_id integer NOT NULL,
    grid_id bigint,
    name character varying(100) NOT NULL,
    subsample_type_id smallint NOT NULL,
    CONSTRAINT subsamples_public_data_check CHECK (((public_data = 'Y'::bpchar) OR (public_data = 'N'::bpchar)))
);


--
-- TOC entry 273 (class 1259 OID 21995)
-- Dependencies: 5
-- Name: subsamples_archive; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE subsamples_archive (
    subsample_id bigint NOT NULL,
    version integer NOT NULL,
    sample_id bigint NOT NULL,
    sample_version bigint NOT NULL,
    grid_id bigint,
    name character varying(100) NOT NULL,
    subsample_type_id smallint NOT NULL
);


--
-- TOC entry 274 (class 1259 OID 21998)
-- Dependencies: 5
-- Name: uploaded_files; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE uploaded_files (
    uploaded_file_id bigint NOT NULL,
    hash character(50) NOT NULL,
    filename character varying(255) NOT NULL,
    "time" timestamp without time zone NOT NULL,
    user_id integer
);


--
-- TOC entry 275 (class 1259 OID 22001)
-- Dependencies: 5
-- Name: uploaded_files_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uploaded_files_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 276 (class 1259 OID 22003)
-- Dependencies: 5
-- Name: user_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 278 (class 1259 OID 22011)
-- Dependencies: 5
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer NOT NULL,
    role_id smallint NOT NULL
);


--
-- TOC entry 279 (class 1259 OID 22014)
-- Dependencies: 5
-- Name: xray_image; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE xray_image (
    image_id bigint NOT NULL,
    element character varying(256),
    dwelltime smallint,
    current smallint,
    voltage smallint
);


--
-- TOC entry 3202 (class 2606 OID 22263)
-- Dependencies: 164 164 3479
-- Name: admin_users_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_sk PRIMARY KEY (admin_id);


--
-- TOC entry 3211 (class 2606 OID 22265)
-- Dependencies: 171 171 171 171 3479
-- Name: analysis_elements_archive_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chemical_analysis_elements_archive
    ADD CONSTRAINT analysis_elements_archive_sk PRIMARY KEY (chemical_analysis_id, element_id, chemical_analysis_version);


--
-- TOC entry 3209 (class 2606 OID 22267)
-- Dependencies: 170 170 170 3479
-- Name: analysis_elements_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chemical_analysis_elements
    ADD CONSTRAINT analysis_elements_sk PRIMARY KEY (chemical_analysis_id, element_id);


--
-- TOC entry 3217 (class 2606 OID 22269)
-- Dependencies: 176 176 176 176 3479
-- Name: analysis_oxides_archive_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chemical_analysis_oxides_archive
    ADD CONSTRAINT analysis_oxides_archive_sk PRIMARY KEY (chemical_analysis_id, oxide_id, chemical_analysis_version);


--
-- TOC entry 3215 (class 2606 OID 22271)
-- Dependencies: 175 175 175 3479
-- Name: analysis_oxides_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chemical_analysis_oxides
    ADD CONSTRAINT analysis_oxides_sk PRIMARY KEY (chemical_analysis_id, oxide_id);


--
-- TOC entry 3207 (class 2606 OID 22273)
-- Dependencies: 168 168 168 3479
-- Name: chemical_analyses_archive_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chemical_analyses_archive
    ADD CONSTRAINT chemical_analyses_archive_sk PRIMARY KEY (chemical_analysis_id, version);


--
-- TOC entry 3205 (class 2606 OID 22275)
-- Dependencies: 167 167 3479
-- Name: chemical_analyses_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chemical_analyses
    ADD CONSTRAINT chemical_analyses_sk PRIMARY KEY (chemical_analysis_id);


--
-- TOC entry 3213 (class 2606 OID 22277)
-- Dependencies: 172 172 3479
-- Name: chemical_analysis_elements_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chemical_analysis_elements_dup
    ADD CONSTRAINT chemical_analysis_elements_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3219 (class 2606 OID 22279)
-- Dependencies: 177 177 3479
-- Name: chemical_analysis_oxides_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chemical_analysis_oxides_dup
    ADD CONSTRAINT chemical_analysis_oxides_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3375 (class 2606 OID 26932)
-- Dependencies: 282 282 3479
-- Name: denorm_sample_minerals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY denorm_sample_minerals
    ADD CONSTRAINT denorm_sample_minerals_pkey PRIMARY KEY (sample_id);


--
-- TOC entry 3223 (class 2606 OID 22281)
-- Dependencies: 181 181 3479
-- Name: element_mineral_types_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY element_mineral_types_dup
    ADD CONSTRAINT element_mineral_types_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3221 (class 2606 OID 22283)
-- Dependencies: 180 180 180 3479
-- Name: element_mineral_types_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY element_mineral_types
    ADD CONSTRAINT element_mineral_types_sk PRIMARY KEY (element_id, mineral_type_id);


--
-- TOC entry 3225 (class 2606 OID 22285)
-- Dependencies: 181 181 181 3479
-- Name: element_mineral_types_unq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY element_mineral_types_dup
    ADD CONSTRAINT element_mineral_types_unq UNIQUE (element_id, mineral_type_id);


--
-- TOC entry 3227 (class 2606 OID 22287)
-- Dependencies: 184 184 3479
-- Name: elements_nk1; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY elements
    ADD CONSTRAINT elements_nk1 UNIQUE (name);


--
-- TOC entry 3229 (class 2606 OID 22289)
-- Dependencies: 184 184 3479
-- Name: elements_nk2; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY elements
    ADD CONSTRAINT elements_nk2 UNIQUE (symbol);


--
-- TOC entry 3231 (class 2606 OID 22291)
-- Dependencies: 184 184 3479
-- Name: elements_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY elements
    ADD CONSTRAINT elements_sk PRIMARY KEY (element_id);


--
-- TOC entry 3233 (class 2606 OID 22293)
-- Dependencies: 185 185 185 185 185 3479
-- Name: geometry_columns_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY geometry_columns
    ADD CONSTRAINT geometry_columns_pk PRIMARY KEY (f_table_catalog, f_table_schema, f_table_name, f_geometry_column);


--
-- TOC entry 3235 (class 2606 OID 22295)
-- Dependencies: 186 186 3479
-- Name: georeference_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY georeference
    ADD CONSTRAINT georeference_sk PRIMARY KEY (georef_id);


--
-- TOC entry 3237 (class 2606 OID 22297)
-- Dependencies: 190 190 3479
-- Name: grids_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY grids
    ADD CONSTRAINT grids_sk PRIMARY KEY (grid_id);


--
-- TOC entry 3239 (class 2606 OID 22299)
-- Dependencies: 192 192 3479
-- Name: image_comments_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_comments
    ADD CONSTRAINT image_comments_sk PRIMARY KEY (comment_id);


--
-- TOC entry 3241 (class 2606 OID 22301)
-- Dependencies: 193 193 3479
-- Name: image_format_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_format
    ADD CONSTRAINT image_format_name_key UNIQUE (name);


--
-- TOC entry 3243 (class 2606 OID 22303)
-- Dependencies: 193 193 3479
-- Name: image_format_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_format
    ADD CONSTRAINT image_format_sk PRIMARY KEY (image_format_id);


--
-- TOC entry 3245 (class 2606 OID 22305)
-- Dependencies: 195 195 3479
-- Name: image_on_grid_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_on_grid
    ADD CONSTRAINT image_on_grid_sk PRIMARY KEY (image_on_grid_id);


--
-- TOC entry 3247 (class 2606 OID 22307)
-- Dependencies: 197 197 197 3479
-- Name: image_reference_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_reference
    ADD CONSTRAINT image_reference_pk PRIMARY KEY (image_id, reference_id);


--
-- TOC entry 3249 (class 2606 OID 22309)
-- Dependencies: 199 199 3479
-- Name: image_types_abbreviation_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_type
    ADD CONSTRAINT image_types_abbreviation_key UNIQUE (abbreviation);


--
-- TOC entry 3251 (class 2606 OID 22311)
-- Dependencies: 199 199 3479
-- Name: image_types_image_type_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_type
    ADD CONSTRAINT image_types_image_type_key UNIQUE (image_type);


--
-- TOC entry 3253 (class 2606 OID 22313)
-- Dependencies: 199 199 3479
-- Name: image_types_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_type
    ADD CONSTRAINT image_types_sk PRIMARY KEY (image_type_id);


--
-- TOC entry 3257 (class 2606 OID 22315)
-- Dependencies: 201 201 3479
-- Name: images_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_sk PRIMARY KEY (image_id);


--
-- TOC entry 3259 (class 2606 OID 22317)
-- Dependencies: 204 204 3479
-- Name: metamorphic_grades_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY metamorphic_grades
    ADD CONSTRAINT metamorphic_grades_name_key UNIQUE (name);


--
-- TOC entry 3261 (class 2606 OID 22319)
-- Dependencies: 204 204 3479
-- Name: metamorphic_grades_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY metamorphic_grades
    ADD CONSTRAINT metamorphic_grades_sk PRIMARY KEY (metamorphic_grade_id);


--
-- TOC entry 3263 (class 2606 OID 22321)
-- Dependencies: 205 205 3479
-- Name: metamorphic_regions_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY metamorphic_regions
    ADD CONSTRAINT metamorphic_regions_name_key UNIQUE (name);


--
-- TOC entry 3265 (class 2606 OID 22323)
-- Dependencies: 205 205 3479
-- Name: metamorphic_regions_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY metamorphic_regions
    ADD CONSTRAINT metamorphic_regions_sk PRIMARY KEY (metamorphic_region_id);


--
-- TOC entry 3269 (class 2606 OID 22325)
-- Dependencies: 210 210 3479
-- Name: mineral_relationships_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mineral_relationships_dup
    ADD CONSTRAINT mineral_relationships_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3267 (class 2606 OID 22327)
-- Dependencies: 209 209 209 3479
-- Name: mineral_relationships_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mineral_relationships
    ADD CONSTRAINT mineral_relationships_sk PRIMARY KEY (parent_mineral_id, child_mineral_id);


--
-- TOC entry 3271 (class 2606 OID 22329)
-- Dependencies: 210 210 210 3479
-- Name: mineral_relationships_unq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mineral_relationships_dup
    ADD CONSTRAINT mineral_relationships_unq UNIQUE (parent_mineral_id, child_mineral_id);


--
-- TOC entry 3273 (class 2606 OID 22331)
-- Dependencies: 213 213 3479
-- Name: mineral_types_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mineral_types
    ADD CONSTRAINT mineral_types_sk PRIMARY KEY (mineral_type_id);


--
-- TOC entry 3275 (class 2606 OID 22333)
-- Dependencies: 215 215 3479
-- Name: minerals_nk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY minerals
    ADD CONSTRAINT minerals_nk UNIQUE (name);


--
-- TOC entry 3277 (class 2606 OID 22335)
-- Dependencies: 215 215 3479
-- Name: minerals_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY minerals
    ADD CONSTRAINT minerals_sk PRIMARY KEY (mineral_id);


--
-- TOC entry 3281 (class 2606 OID 22337)
-- Dependencies: 217 217 3479
-- Name: oxide_mineral_types_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oxide_mineral_types_dup
    ADD CONSTRAINT oxide_mineral_types_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3279 (class 2606 OID 22339)
-- Dependencies: 216 216 216 3479
-- Name: oxide_mineral_types_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oxide_mineral_types
    ADD CONSTRAINT oxide_mineral_types_sk PRIMARY KEY (oxide_id, mineral_type_id);


--
-- TOC entry 3283 (class 2606 OID 22341)
-- Dependencies: 217 217 217 3479
-- Name: oxide_mineral_types_unq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oxide_mineral_types_dup
    ADD CONSTRAINT oxide_mineral_types_unq UNIQUE (oxide_id, mineral_type_id);


--
-- TOC entry 3285 (class 2606 OID 22343)
-- Dependencies: 220 220 3479
-- Name: oxides_nk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oxides
    ADD CONSTRAINT oxides_nk UNIQUE (species);


--
-- TOC entry 3287 (class 2606 OID 22345)
-- Dependencies: 220 220 3479
-- Name: oxides_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oxides
    ADD CONSTRAINT oxides_sk PRIMARY KEY (oxide_id);


--
-- TOC entry 3289 (class 2606 OID 22347)
-- Dependencies: 222 222 3479
-- Name: project_invites_nk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_invites
    ADD CONSTRAINT project_invites_nk PRIMARY KEY (invite_id);


--
-- TOC entry 3291 (class 2606 OID 22349)
-- Dependencies: 223 223 223 3479
-- Name: project_members_nk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_members
    ADD CONSTRAINT project_members_nk PRIMARY KEY (project_id, user_id);


--
-- TOC entry 3295 (class 2606 OID 22351)
-- Dependencies: 226 226 226 3479
-- Name: projects_nk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_nk UNIQUE (user_id, name);


--
-- TOC entry 3297 (class 2606 OID 22353)
-- Dependencies: 226 226 3479
-- Name: projects_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_sk PRIMARY KEY (project_id);


--
-- TOC entry 3299 (class 2606 OID 22355)
-- Dependencies: 227 227 3479
-- Name: references_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT references_name_key UNIQUE (name);


--
-- TOC entry 3301 (class 2606 OID 22357)
-- Dependencies: 227 227 3479
-- Name: references_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT references_sk PRIMARY KEY (reference_id);


--
-- TOC entry 3303 (class 2606 OID 22359)
-- Dependencies: 231 231 3479
-- Name: regions_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_name_key UNIQUE (name);


--
-- TOC entry 3305 (class 2606 OID 22361)
-- Dependencies: 231 231 3479
-- Name: regions_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_sk PRIMARY KEY (region_id);


--
-- TOC entry 3307 (class 2606 OID 22363)
-- Dependencies: 232 232 3479
-- Name: rock_types_rock_type_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rock_type
    ADD CONSTRAINT rock_types_rock_type_key UNIQUE (rock_type);


--
-- TOC entry 3309 (class 2606 OID 22365)
-- Dependencies: 232 232 3479
-- Name: rock_types_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rock_type
    ADD CONSTRAINT rock_types_sk PRIMARY KEY (rock_type_id);


--
-- TOC entry 3311 (class 2606 OID 22367)
-- Dependencies: 234 234 234 234 3479
-- Name: role_changes_nk_pending; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role_changes
    ADD CONSTRAINT role_changes_nk_pending UNIQUE (user_id, granted, role_id);


--
-- TOC entry 3313 (class 2606 OID 22369)
-- Dependencies: 234 234 3479
-- Name: role_changes_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role_changes
    ADD CONSTRAINT role_changes_sk PRIMARY KEY (role_changes_id);


--
-- TOC entry 3315 (class 2606 OID 22371)
-- Dependencies: 237 237 3479
-- Name: roles_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_sk PRIMARY KEY (role_id);


--
-- TOC entry 3317 (class 2606 OID 22373)
-- Dependencies: 239 239 239 3479
-- Name: sample_aliases_nk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_aliases
    ADD CONSTRAINT sample_aliases_nk UNIQUE (sample_id, alias);


--
-- TOC entry 3319 (class 2606 OID 22375)
-- Dependencies: 239 239 3479
-- Name: sample_aliases_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_aliases
    ADD CONSTRAINT sample_aliases_sk PRIMARY KEY (sample_alias_id);


--
-- TOC entry 3321 (class 2606 OID 22377)
-- Dependencies: 241 241 3479
-- Name: sample_comments_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_comments
    ADD CONSTRAINT sample_comments_sk PRIMARY KEY (comment_id);


--
-- TOC entry 3327 (class 2606 OID 22379)
-- Dependencies: 245 245 3479
-- Name: sample_metamorphic_grades_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_metamorphic_grades_dup
    ADD CONSTRAINT sample_metamorphic_grades_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 22381)
-- Dependencies: 249 249 3479
-- Name: sample_metamorphic_regions_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_metamorphic_regions_dup
    ADD CONSTRAINT sample_metamorphic_regions_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3335 (class 2606 OID 22383)
-- Dependencies: 254 254 3479
-- Name: sample_minerals_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_minerals_dup
    ADD CONSTRAINT sample_minerals_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 22385)
-- Dependencies: 252 252 252 3479
-- Name: sample_minerals_nk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_minerals
    ADD CONSTRAINT sample_minerals_nk PRIMARY KEY (mineral_id, sample_id);


--
-- TOC entry 3339 (class 2606 OID 22387)
-- Dependencies: 257 257 257 257 3479
-- Name: sample_reference_archive_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_reference_archive
    ADD CONSTRAINT sample_reference_archive_pk PRIMARY KEY (sample_id, reference_id, sample_version);


--
-- TOC entry 3341 (class 2606 OID 22389)
-- Dependencies: 259 259 3479
-- Name: sample_reference_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_reference_dup
    ADD CONSTRAINT sample_reference_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3337 (class 2606 OID 22391)
-- Dependencies: 256 256 256 3479
-- Name: sample_reference_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_reference
    ADD CONSTRAINT sample_reference_pk PRIMARY KEY (sample_id, reference_id);


--
-- TOC entry 3343 (class 2606 OID 22393)
-- Dependencies: 261 261 261 3479
-- Name: sample_region_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_regions
    ADD CONSTRAINT sample_region_pk PRIMARY KEY (sample_id, region_id);


--
-- TOC entry 3345 (class 2606 OID 22395)
-- Dependencies: 262 262 262 262 3479
-- Name: sample_regions_archive_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_regions_archive
    ADD CONSTRAINT sample_regions_archive_pk PRIMARY KEY (sample_id, region_id, sample_version);


--
-- TOC entry 3347 (class 2606 OID 22397)
-- Dependencies: 263 263 3479
-- Name: sample_regions_dup_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_regions_dup
    ADD CONSTRAINT sample_regions_dup_pkey PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 22399)
-- Dependencies: 267 267 267 3479
-- Name: samples_archive_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY samples_archive
    ADD CONSTRAINT samples_archive_sk PRIMARY KEY (sample_id, version);


--
-- TOC entry 3325 (class 2606 OID 22401)
-- Dependencies: 244 244 244 244 3479
-- Name: samples_metgrade_archive_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_metamorphic_grades_archive
    ADD CONSTRAINT samples_metgrade_archive_pk PRIMARY KEY (sample_id, metamorphic_grade_id, sample_version);


--
-- TOC entry 3323 (class 2606 OID 22403)
-- Dependencies: 243 243 243 3479
-- Name: samples_metgrade_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_metamorphic_grades
    ADD CONSTRAINT samples_metgrade_pk PRIMARY KEY (sample_id, metamorphic_grade_id);


--
-- TOC entry 3329 (class 2606 OID 22405)
-- Dependencies: 247 247 247 3479
-- Name: samples_metregion_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_metamorphic_regions
    ADD CONSTRAINT samples_metregion_pk PRIMARY KEY (sample_id, metamorphic_region_id);


--
-- TOC entry 3352 (class 2606 OID 22407)
-- Dependencies: 266 266 3479
-- Name: samples_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT samples_sk PRIMARY KEY (sample_id);


--
-- TOC entry 3356 (class 2606 OID 22409)
-- Dependencies: 268 268 3479
-- Name: spatial_ref_sys_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spatial_ref_sys
    ADD CONSTRAINT spatial_ref_sys_pkey PRIMARY KEY (srid);


--
-- TOC entry 3358 (class 2606 OID 22411)
-- Dependencies: 270 270 3479
-- Name: subsample_types_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY subsample_type
    ADD CONSTRAINT subsample_types_sk PRIMARY KEY (subsample_type_id);


--
-- TOC entry 3360 (class 2606 OID 22413)
-- Dependencies: 270 270 3479
-- Name: subsample_types_subsample_type_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY subsample_type
    ADD CONSTRAINT subsample_types_subsample_type_key UNIQUE (subsample_type);


--
-- TOC entry 3365 (class 2606 OID 22415)
-- Dependencies: 273 273 273 3479
-- Name: subsamples_archive_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY subsamples_archive
    ADD CONSTRAINT subsamples_archive_sk PRIMARY KEY (subsample_id, version);


--
-- TOC entry 3363 (class 2606 OID 22417)
-- Dependencies: 272 272 3479
-- Name: subsamples_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY subsamples
    ADD CONSTRAINT subsamples_sk PRIMARY KEY (subsample_id);


--
-- TOC entry 3367 (class 2606 OID 22419)
-- Dependencies: 274 274 3479
-- Name: uploaded_files_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY uploaded_files
    ADD CONSTRAINT uploaded_files_pk PRIMARY KEY (uploaded_file_id);


--
-- TOC entry 3369 (class 2606 OID 22421)
-- Dependencies: 277 277 3479
-- Name: users_nk_username; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_nk_username UNIQUE (email);


--
-- TOC entry 3371 (class 2606 OID 22423)
-- Dependencies: 277 277 3479
-- Name: users_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_sk PRIMARY KEY (user_id);


--
-- TOC entry 3373 (class 2606 OID 22425)
-- Dependencies: 279 279 3479
-- Name: xray_image_sk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY xray_image
    ADD CONSTRAINT xray_image_sk PRIMARY KEY (image_id);


--
-- TOC entry 3203 (class 1259 OID 22426)
-- Dependencies: 167 3479
-- Name: chemical_analyses_nk_spot_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX chemical_analyses_nk_spot_id ON chemical_analyses USING btree (spot_id);


--
-- TOC entry 3254 (class 1259 OID 22427)
-- Dependencies: 201 201 3479
-- Name: images_nk_filename_sample; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX images_nk_filename_sample ON images USING btree (sample_id, lower((filename)::text));


--
-- TOC entry 3255 (class 1259 OID 22428)
-- Dependencies: 201 201 3479
-- Name: images_nk_filename_subsample; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX images_nk_filename_subsample ON images USING btree (subsample_id, lower((filename)::text));


--
-- TOC entry 3292 (class 1259 OID 22429)
-- Dependencies: 223 3479
-- Name: projectmembers_userid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX projectmembers_userid ON project_members USING hash (user_id);


--
-- TOC entry 3293 (class 1259 OID 22430)
-- Dependencies: 224 3479
-- Name: projectsamples_projectid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX projectsamples_projectid ON project_samples USING hash (project_id);


--
-- TOC entry 3348 (class 1259 OID 22431)
-- Dependencies: 266 2595 3479
-- Name: samples_archive_ix_loc; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX samples_archive_ix_loc ON samples USING gist (location);


--
-- TOC entry 3349 (class 1259 OID 22432)
-- Dependencies: 2595 266 3479
-- Name: samples_ix_loc; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX samples_ix_loc ON samples USING gist (location);


--
-- TOC entry 3350 (class 1259 OID 22433)
-- Dependencies: 266 266 3479
-- Name: samples_nk_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX samples_nk_number ON samples USING btree (user_id, lower((number)::text));


--
-- TOC entry 3361 (class 1259 OID 22434)
-- Dependencies: 272 272 3479
-- Name: subsamples_nk_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX subsamples_nk_name ON subsamples USING btree (sample_id, lower((name)::text));


--
-- TOC entry 3470 (class 2620 OID 22435)
-- Dependencies: 1080 170 3479
-- Name: chemical_analysis_elements_sync_trg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER chemical_analysis_elements_sync_trg AFTER INSERT OR UPDATE ON chemical_analysis_elements FOR EACH ROW EXECUTE PROCEDURE chemical_analysis_elements_sync();


--
-- TOC entry 3471 (class 2620 OID 22436)
-- Dependencies: 1081 175 3479
-- Name: chemical_analysis_oxides_sync_trg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER chemical_analysis_oxides_sync_trg AFTER INSERT OR UPDATE ON chemical_analysis_oxides FOR EACH ROW EXECUTE PROCEDURE chemical_analysis_oxides_sync();


--
-- TOC entry 3472 (class 2620 OID 22437)
-- Dependencies: 180 1082 3479
-- Name: element_mineral_types_sync_trg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER element_mineral_types_sync_trg AFTER INSERT OR UPDATE ON element_mineral_types FOR EACH ROW EXECUTE PROCEDURE element_mineral_types_sync();


--
-- TOC entry 3473 (class 2620 OID 22438)
-- Dependencies: 1083 243 3479
-- Name: sample_metamorphic_grades_sync_trg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER sample_metamorphic_grades_sync_trg AFTER INSERT OR UPDATE ON sample_metamorphic_grades FOR EACH ROW EXECUTE PROCEDURE sample_metamorphic_grades_sync();


--
-- TOC entry 3474 (class 2620 OID 22439)
-- Dependencies: 247 1084 3479
-- Name: sample_metamorphic_regions_sync_trg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER sample_metamorphic_regions_sync_trg AFTER INSERT OR UPDATE ON sample_metamorphic_regions FOR EACH ROW EXECUTE PROCEDURE sample_metamorphic_regions_sync();


--
-- TOC entry 3475 (class 2620 OID 22440)
-- Dependencies: 252 1085 3479
-- Name: sample_minerals_sync_trg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER sample_minerals_sync_trg AFTER INSERT OR UPDATE ON sample_minerals FOR EACH ROW EXECUTE PROCEDURE sample_minerals_sync();


--
-- TOC entry 3476 (class 2620 OID 22441)
-- Dependencies: 256 1086 3479
-- Name: sample_reference_sync_trg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER sample_reference_sync_trg AFTER INSERT OR UPDATE ON sample_reference FOR EACH ROW EXECUTE PROCEDURE sample_reference_sync();


--
-- TOC entry 3477 (class 2620 OID 22442)
-- Dependencies: 1087 261 3479
-- Name: sample_regions_sync_trg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER sample_regions_sync_trg AFTER INSERT OR UPDATE ON sample_regions FOR EACH ROW EXECUTE PROCEDURE sample_regions_sync();


--
-- TOC entry 3376 (class 2606 OID 22443)
-- Dependencies: 164 3370 277 3479
-- Name: admin_users_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3386 (class 2606 OID 22448)
-- Dependencies: 170 167 3204 3479
-- Name: analysis_elements_fk_chemical_analyses; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_elements
    ADD CONSTRAINT analysis_elements_fk_chemical_analyses FOREIGN KEY (chemical_analysis_id) REFERENCES chemical_analyses(chemical_analysis_id);


--
-- TOC entry 3388 (class 2606 OID 22453)
-- Dependencies: 171 3206 171 168 168 3479
-- Name: analysis_elements_fk_chemical_analyses_archive; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_elements_archive
    ADD CONSTRAINT analysis_elements_fk_chemical_analyses_archive FOREIGN KEY (chemical_analysis_id, chemical_analysis_version) REFERENCES chemical_analyses_archive(chemical_analysis_id, version);


--
-- TOC entry 3387 (class 2606 OID 22458)
-- Dependencies: 170 184 3230 3479
-- Name: analysis_elements_fk_elements; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_elements
    ADD CONSTRAINT analysis_elements_fk_elements FOREIGN KEY (element_id) REFERENCES elements(element_id);


--
-- TOC entry 3389 (class 2606 OID 22463)
-- Dependencies: 171 184 3230 3479
-- Name: analysis_elements_fk_elements_archive; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_elements_archive
    ADD CONSTRAINT analysis_elements_fk_elements_archive FOREIGN KEY (element_id) REFERENCES elements(element_id);


--
-- TOC entry 3392 (class 2606 OID 22468)
-- Dependencies: 175 167 3204 3479
-- Name: analysis_oxides_fk_chemical_analyses; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_oxides
    ADD CONSTRAINT analysis_oxides_fk_chemical_analyses FOREIGN KEY (chemical_analysis_id) REFERENCES chemical_analyses(chemical_analysis_id);


--
-- TOC entry 3394 (class 2606 OID 22473)
-- Dependencies: 176 176 168 3206 168 3479
-- Name: analysis_oxides_fk_chemical_analyses_archive; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_oxides_archive
    ADD CONSTRAINT analysis_oxides_fk_chemical_analyses_archive FOREIGN KEY (chemical_analysis_id, chemical_analysis_version) REFERENCES chemical_analyses_archive(chemical_analysis_id, version);


--
-- TOC entry 3393 (class 2606 OID 22478)
-- Dependencies: 3286 220 175 3479
-- Name: analysis_oxides_fk_oxides; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_oxides
    ADD CONSTRAINT analysis_oxides_fk_oxides FOREIGN KEY (oxide_id) REFERENCES oxides(oxide_id);


--
-- TOC entry 3395 (class 2606 OID 22483)
-- Dependencies: 3286 220 176 3479
-- Name: analysis_oxides_fk_oxides_archive; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_oxides_archive
    ADD CONSTRAINT analysis_oxides_fk_oxides_archive FOREIGN KEY (oxide_id) REFERENCES oxides(oxide_id);


--
-- TOC entry 3382 (class 2606 OID 22488)
-- Dependencies: 168 201 3256 3479
-- Name: chemical_analyses_archive_fk_images; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analyses_archive
    ADD CONSTRAINT chemical_analyses_archive_fk_images FOREIGN KEY (image_id) REFERENCES images(image_id) ON DELETE SET NULL;


--
-- TOC entry 3383 (class 2606 OID 22493)
-- Dependencies: 3276 168 215 3479
-- Name: chemical_analyses_archive_fk_mineral; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analyses_archive
    ADD CONSTRAINT chemical_analyses_archive_fk_mineral FOREIGN KEY (mineral_id) REFERENCES minerals(mineral_id) ON DELETE SET NULL;


--
-- TOC entry 3384 (class 2606 OID 22498)
-- Dependencies: 168 227 3300 3479
-- Name: chemical_analyses_archive_fk_reference; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analyses_archive
    ADD CONSTRAINT chemical_analyses_archive_fk_reference FOREIGN KEY (reference_id) REFERENCES reference(reference_id) ON DELETE SET NULL;


--
-- TOC entry 3385 (class 2606 OID 22503)
-- Dependencies: 273 168 3364 273 168 3479
-- Name: chemical_analyses_archive_fk_subsamples; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analyses_archive
    ADD CONSTRAINT chemical_analyses_archive_fk_subsamples FOREIGN KEY (subsample_id, subsample_version) REFERENCES subsamples_archive(subsample_id, version);


--
-- TOC entry 3377 (class 2606 OID 22508)
-- Dependencies: 167 3256 201 3479
-- Name: chemical_analyses_fk_images; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analyses
    ADD CONSTRAINT chemical_analyses_fk_images FOREIGN KEY (image_id) REFERENCES images(image_id) ON DELETE SET NULL;


--
-- TOC entry 3378 (class 2606 OID 22513)
-- Dependencies: 3276 167 215 3479
-- Name: chemical_analyses_fk_mineral; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analyses
    ADD CONSTRAINT chemical_analyses_fk_mineral FOREIGN KEY (mineral_id) REFERENCES minerals(mineral_id);


--
-- TOC entry 3379 (class 2606 OID 22518)
-- Dependencies: 3300 227 167 3479
-- Name: chemical_analyses_fk_reference; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analyses
    ADD CONSTRAINT chemical_analyses_fk_reference FOREIGN KEY (reference_id) REFERENCES reference(reference_id);


--
-- TOC entry 3380 (class 2606 OID 22523)
-- Dependencies: 272 167 3362 3479
-- Name: chemical_analyses_fk_subsamples; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analyses
    ADD CONSTRAINT chemical_analyses_fk_subsamples FOREIGN KEY (subsample_id) REFERENCES subsamples(subsample_id);


--
-- TOC entry 3381 (class 2606 OID 22528)
-- Dependencies: 3370 167 277 3479
-- Name: chemical_analyses_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analyses
    ADD CONSTRAINT chemical_analyses_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3390 (class 2606 OID 22533)
-- Dependencies: 172 167 3204 3479
-- Name: chemical_analysis_elements_dup_chemical_analysis_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_elements_dup
    ADD CONSTRAINT chemical_analysis_elements_dup_chemical_analysis_id_fkey FOREIGN KEY (chemical_analysis_id) REFERENCES chemical_analyses(chemical_analysis_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3391 (class 2606 OID 22538)
-- Dependencies: 172 184 3230 3479
-- Name: chemical_analysis_elements_dup_element_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_elements_dup
    ADD CONSTRAINT chemical_analysis_elements_dup_element_id_fkey FOREIGN KEY (element_id) REFERENCES elements(element_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3396 (class 2606 OID 22543)
-- Dependencies: 167 177 3204 3479
-- Name: chemical_analysis_oxides_dup_chemical_analysis_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_oxides_dup
    ADD CONSTRAINT chemical_analysis_oxides_dup_chemical_analysis_id_fkey FOREIGN KEY (chemical_analysis_id) REFERENCES chemical_analyses(chemical_analysis_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3397 (class 2606 OID 22548)
-- Dependencies: 220 177 3286 3479
-- Name: chemical_analysis_oxides_dup_oxide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chemical_analysis_oxides_dup
    ADD CONSTRAINT chemical_analysis_oxides_dup_oxide_id_fkey FOREIGN KEY (oxide_id) REFERENCES oxides(oxide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3398 (class 2606 OID 22553)
-- Dependencies: 180 184 3230 3479
-- Name: element_mineral_types_fk_element; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY element_mineral_types
    ADD CONSTRAINT element_mineral_types_fk_element FOREIGN KEY (element_id) REFERENCES elements(element_id);


--
-- TOC entry 3399 (class 2606 OID 22558)
-- Dependencies: 180 213 3272 3479
-- Name: element_mineral_types_fk_mineral_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY element_mineral_types
    ADD CONSTRAINT element_mineral_types_fk_mineral_type FOREIGN KEY (mineral_type_id) REFERENCES mineral_types(mineral_type_id);


--
-- TOC entry 3400 (class 2606 OID 22563)
-- Dependencies: 190 272 3362 3479
-- Name: grids_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY grids
    ADD CONSTRAINT grids_fk FOREIGN KEY (subsample_id) REFERENCES subsamples(subsample_id);


--
-- TOC entry 3401 (class 2606 OID 22568)
-- Dependencies: 192 201 3256 3479
-- Name: image_comments_fk_image; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_comments
    ADD CONSTRAINT image_comments_fk_image FOREIGN KEY (image_id) REFERENCES images(image_id);


--
-- TOC entry 3402 (class 2606 OID 22573)
-- Dependencies: 195 190 3236 3479
-- Name: image_on_grid_fk_grids; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_on_grid
    ADD CONSTRAINT image_on_grid_fk_grids FOREIGN KEY (grid_id) REFERENCES grids(grid_id) ON DELETE CASCADE;


--
-- TOC entry 3403 (class 2606 OID 22578)
-- Dependencies: 195 201 3256 3479
-- Name: image_on_grid_fk_images; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_on_grid
    ADD CONSTRAINT image_on_grid_fk_images FOREIGN KEY (image_id) REFERENCES images(image_id) ON DELETE CASCADE;


--
-- TOC entry 3404 (class 2606 OID 22583)
-- Dependencies: 197 201 3256 3479
-- Name: image_reference_fk_image; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_reference
    ADD CONSTRAINT image_reference_fk_image FOREIGN KEY (image_id) REFERENCES images(image_id);


--
-- TOC entry 3405 (class 2606 OID 22588)
-- Dependencies: 3300 227 197 3479
-- Name: image_reference_fk_reference; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_reference
    ADD CONSTRAINT image_reference_fk_reference FOREIGN KEY (reference_id) REFERENCES reference(reference_id);


--
-- TOC entry 3406 (class 2606 OID 22593)
-- Dependencies: 3242 201 193 3479
-- Name: images_fk_image_format; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_fk_image_format FOREIGN KEY (image_format_id) REFERENCES image_format(image_format_id);


--
-- TOC entry 3407 (class 2606 OID 22598)
-- Dependencies: 3252 201 199 3479
-- Name: images_fk_image_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_fk_image_type FOREIGN KEY (image_type_id) REFERENCES image_type(image_type_id);


--
-- TOC entry 3408 (class 2606 OID 22603)
-- Dependencies: 201 266 3351 3479
-- Name: images_fk_sample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_fk_sample FOREIGN KEY (sample_id) REFERENCES samples(sample_id) ON DELETE CASCADE;


--
-- TOC entry 3409 (class 2606 OID 22608)
-- Dependencies: 3362 201 272 3479
-- Name: images_fk_subsample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_fk_subsample FOREIGN KEY (subsample_id) REFERENCES subsamples(subsample_id) ON DELETE CASCADE;


--
-- TOC entry 3410 (class 2606 OID 22613)
-- Dependencies: 3370 277 201 3479
-- Name: images_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3411 (class 2606 OID 22618)
-- Dependencies: 209 215 3276 3479
-- Name: mineral_relationships_child_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mineral_relationships
    ADD CONSTRAINT mineral_relationships_child_fk FOREIGN KEY (child_mineral_id) REFERENCES minerals(mineral_id);


--
-- TOC entry 3412 (class 2606 OID 22623)
-- Dependencies: 3276 215 209 3479
-- Name: mineral_relationships_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mineral_relationships
    ADD CONSTRAINT mineral_relationships_parent_fk FOREIGN KEY (parent_mineral_id) REFERENCES minerals(mineral_id);


--
-- TOC entry 3441 (class 2606 OID 22628)
-- Dependencies: 3276 215 253 3479
-- Name: mineral_samples_archive_fk_min; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_minerals_archive
    ADD CONSTRAINT mineral_samples_archive_fk_min FOREIGN KEY (mineral_id) REFERENCES minerals(mineral_id) ON DELETE CASCADE;


--
-- TOC entry 3442 (class 2606 OID 22633)
-- Dependencies: 253 267 267 253 3353 3479
-- Name: mineral_samples_archive_fk_samp; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_minerals_archive
    ADD CONSTRAINT mineral_samples_archive_fk_samp FOREIGN KEY (sample_id, sample_version) REFERENCES samples_archive(sample_id, version);


--
-- TOC entry 3439 (class 2606 OID 22638)
-- Dependencies: 215 252 3276 3479
-- Name: mineral_samples_fk_min; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_minerals
    ADD CONSTRAINT mineral_samples_fk_min FOREIGN KEY (mineral_id) REFERENCES minerals(mineral_id) ON DELETE CASCADE;


--
-- TOC entry 3440 (class 2606 OID 22643)
-- Dependencies: 3351 266 252 3479
-- Name: mineral_samples_fk_samp; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_minerals
    ADD CONSTRAINT mineral_samples_fk_samp FOREIGN KEY (sample_id) REFERENCES samples(sample_id);


--
-- TOC entry 3413 (class 2606 OID 22648)
-- Dependencies: 3276 215 215 3479
-- Name: minerals_fk_real_mineral_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY minerals
    ADD CONSTRAINT minerals_fk_real_mineral_id FOREIGN KEY (real_mineral_id) REFERENCES minerals(mineral_id);


--
-- TOC entry 3414 (class 2606 OID 22653)
-- Dependencies: 213 3272 216 3479
-- Name: oxide_mineral_types_fk_mineral_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oxide_mineral_types
    ADD CONSTRAINT oxide_mineral_types_fk_mineral_type FOREIGN KEY (mineral_type_id) REFERENCES mineral_types(mineral_type_id);


--
-- TOC entry 3415 (class 2606 OID 22658)
-- Dependencies: 220 3286 216 3479
-- Name: oxide_mineral_types_fk_oxide; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oxide_mineral_types
    ADD CONSTRAINT oxide_mineral_types_fk_oxide FOREIGN KEY (oxide_id) REFERENCES oxides(oxide_id);


--
-- TOC entry 3416 (class 2606 OID 22663)
-- Dependencies: 220 184 3230 3479
-- Name: oxides_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY oxides
    ADD CONSTRAINT oxides_fk FOREIGN KEY (element_id) REFERENCES elements(element_id);


--
-- TOC entry 3417 (class 2606 OID 22668)
-- Dependencies: 3296 222 226 3479
-- Name: project_invites_fk_proj; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_invites
    ADD CONSTRAINT project_invites_fk_proj FOREIGN KEY (project_id) REFERENCES projects(project_id);


--
-- TOC entry 3418 (class 2606 OID 22673)
-- Dependencies: 222 277 3370 3479
-- Name: project_invites_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_invites
    ADD CONSTRAINT project_invites_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3419 (class 2606 OID 22678)
-- Dependencies: 223 226 3296 3479
-- Name: project_members_fk_proj; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_members
    ADD CONSTRAINT project_members_fk_proj FOREIGN KEY (project_id) REFERENCES projects(project_id);


--
-- TOC entry 3420 (class 2606 OID 22683)
-- Dependencies: 277 3370 223 3479
-- Name: project_members_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_members
    ADD CONSTRAINT project_members_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3421 (class 2606 OID 22688)
-- Dependencies: 224 226 3296 3479
-- Name: project_samples_fk_proj; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_samples
    ADD CONSTRAINT project_samples_fk_proj FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE;


--
-- TOC entry 3422 (class 2606 OID 22693)
-- Dependencies: 224 266 3351 3479
-- Name: project_samples_fk_samp; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_samples
    ADD CONSTRAINT project_samples_fk_samp FOREIGN KEY (sample_id) REFERENCES samples(sample_id);


--
-- TOC entry 3423 (class 2606 OID 22698)
-- Dependencies: 226 277 3370 3479
-- Name: projects_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3424 (class 2606 OID 22703)
-- Dependencies: 234 237 3314 3479
-- Name: role_changes_fk_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_changes
    ADD CONSTRAINT role_changes_fk_role FOREIGN KEY (role_id) REFERENCES roles(role_id);


--
-- TOC entry 3425 (class 2606 OID 22708)
-- Dependencies: 234 277 3370 3479
-- Name: role_changes_fk_sponsor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_changes
    ADD CONSTRAINT role_changes_fk_sponsor FOREIGN KEY (sponsor_id) REFERENCES users(user_id);


--
-- TOC entry 3426 (class 2606 OID 22713)
-- Dependencies: 277 234 3370 3479
-- Name: role_changes_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_changes
    ADD CONSTRAINT role_changes_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3428 (class 2606 OID 22718)
-- Dependencies: 241 266 3351 3479
-- Name: sample_comments_fk_sample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_comments
    ADD CONSTRAINT sample_comments_fk_sample FOREIGN KEY (sample_id) REFERENCES samples(sample_id);


--
-- TOC entry 3429 (class 2606 OID 22723)
-- Dependencies: 241 277 3370 3479
-- Name: sample_comments_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_comments
    ADD CONSTRAINT sample_comments_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3427 (class 2606 OID 22728)
-- Dependencies: 239 266 3351 3479
-- Name: sample_id_fk_sample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_aliases
    ADD CONSTRAINT sample_id_fk_sample FOREIGN KEY (sample_id) REFERENCES samples(sample_id);


--
-- TOC entry 3433 (class 2606 OID 22733)
-- Dependencies: 245 204 3260 3479
-- Name: sample_metamorphic_grades_dup_metamorphic_grade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metamorphic_grades_dup
    ADD CONSTRAINT sample_metamorphic_grades_dup_metamorphic_grade_id_fkey FOREIGN KEY (metamorphic_grade_id) REFERENCES metamorphic_grades(metamorphic_grade_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3434 (class 2606 OID 22738)
-- Dependencies: 245 266 3351 3479
-- Name: sample_metamorphic_grades_dup_sample_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metamorphic_grades_dup
    ADD CONSTRAINT sample_metamorphic_grades_dup_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES samples(sample_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3437 (class 2606 OID 22743)
-- Dependencies: 249 205 3264 3479
-- Name: sample_metamorphic_regions_dup_metamorphic_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metamorphic_regions_dup
    ADD CONSTRAINT sample_metamorphic_regions_dup_metamorphic_region_id_fkey FOREIGN KEY (metamorphic_region_id) REFERENCES metamorphic_regions(metamorphic_region_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3438 (class 2606 OID 22748)
-- Dependencies: 249 266 3351 3479
-- Name: sample_metamorphic_regions_dup_sample_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metamorphic_regions_dup
    ADD CONSTRAINT sample_metamorphic_regions_dup_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES samples(sample_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3443 (class 2606 OID 22753)
-- Dependencies: 254 215 3276 3479
-- Name: sample_minerals_dup_mineral_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_minerals_dup
    ADD CONSTRAINT sample_minerals_dup_mineral_id_fkey FOREIGN KEY (mineral_id) REFERENCES minerals(mineral_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3444 (class 2606 OID 22758)
-- Dependencies: 254 266 3351 3479
-- Name: sample_minerals_dup_sample_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_minerals_dup
    ADD CONSTRAINT sample_minerals_dup_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES samples(sample_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3447 (class 2606 OID 22763)
-- Dependencies: 257 227 3300 3479
-- Name: sample_reference_archive_fk_reference; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_reference_archive
    ADD CONSTRAINT sample_reference_archive_fk_reference FOREIGN KEY (reference_id) REFERENCES reference(reference_id) ON DELETE CASCADE;


--
-- TOC entry 3448 (class 2606 OID 22768)
-- Dependencies: 257 257 267 267 3353 3479
-- Name: sample_reference_archive_fk_sample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_reference_archive
    ADD CONSTRAINT sample_reference_archive_fk_sample FOREIGN KEY (sample_id, sample_version) REFERENCES samples_archive(sample_id, version);


--
-- TOC entry 3449 (class 2606 OID 22773)
-- Dependencies: 259 3300 227 3479
-- Name: sample_reference_dup_reference_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_reference_dup
    ADD CONSTRAINT sample_reference_dup_reference_id_fkey FOREIGN KEY (reference_id) REFERENCES reference(reference_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3450 (class 2606 OID 22778)
-- Dependencies: 266 3351 259 3479
-- Name: sample_reference_dup_sample_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_reference_dup
    ADD CONSTRAINT sample_reference_dup_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES samples(sample_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3445 (class 2606 OID 22783)
-- Dependencies: 227 3300 256 3479
-- Name: sample_reference_fk_reference; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_reference
    ADD CONSTRAINT sample_reference_fk_reference FOREIGN KEY (reference_id) REFERENCES reference(reference_id);


--
-- TOC entry 3446 (class 2606 OID 22788)
-- Dependencies: 3351 256 266 3479
-- Name: sample_reference_fk_sample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_reference
    ADD CONSTRAINT sample_reference_fk_sample FOREIGN KEY (sample_id) REFERENCES samples(sample_id);


--
-- TOC entry 3453 (class 2606 OID 22793)
-- Dependencies: 231 3304 262 3479
-- Name: sample_region_archive_fk_region; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_regions_archive
    ADD CONSTRAINT sample_region_archive_fk_region FOREIGN KEY (region_id) REFERENCES regions(region_id) ON DELETE CASCADE;


--
-- TOC entry 3451 (class 2606 OID 22798)
-- Dependencies: 3304 261 231 3479
-- Name: sample_region_fk_region; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_regions
    ADD CONSTRAINT sample_region_fk_region FOREIGN KEY (region_id) REFERENCES regions(region_id);


--
-- TOC entry 3454 (class 2606 OID 22803)
-- Dependencies: 267 3353 267 262 262 3479
-- Name: sample_regions_archive_fk_sample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_regions_archive
    ADD CONSTRAINT sample_regions_archive_fk_sample FOREIGN KEY (sample_id, sample_version) REFERENCES samples_archive(sample_id, version);


--
-- TOC entry 3455 (class 2606 OID 22808)
-- Dependencies: 3304 263 231 3479
-- Name: sample_regions_dup_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_regions_dup
    ADD CONSTRAINT sample_regions_dup_region_id_fkey FOREIGN KEY (region_id) REFERENCES regions(region_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3456 (class 2606 OID 22813)
-- Dependencies: 3351 266 263 3479
-- Name: sample_regions_dup_sample_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_regions_dup
    ADD CONSTRAINT sample_regions_dup_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES samples(sample_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3452 (class 2606 OID 22818)
-- Dependencies: 3351 266 261 3479
-- Name: sample_regions_fk_sample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_regions
    ADD CONSTRAINT sample_regions_fk_sample FOREIGN KEY (sample_id) REFERENCES samples(sample_id);


--
-- TOC entry 3460 (class 2606 OID 22823)
-- Dependencies: 277 267 3370 3479
-- Name: samples_archive_fk_collector; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples_archive
    ADD CONSTRAINT samples_archive_fk_collector FOREIGN KEY (collector_id) REFERENCES users(user_id);


--
-- TOC entry 3461 (class 2606 OID 22828)
-- Dependencies: 267 3370 277 3479
-- Name: samples_archive_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples_archive
    ADD CONSTRAINT samples_archive_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3457 (class 2606 OID 22833)
-- Dependencies: 266 3370 277 3479
-- Name: samples_fk_collector; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT samples_fk_collector FOREIGN KEY (collector_id) REFERENCES users(user_id);


--
-- TOC entry 3458 (class 2606 OID 22838)
-- Dependencies: 266 232 3308 3479
-- Name: samples_fk_rock_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT samples_fk_rock_type FOREIGN KEY (rock_type_id) REFERENCES rock_type(rock_type_id);


--
-- TOC entry 3462 (class 2606 OID 22843)
-- Dependencies: 232 3308 267 3479
-- Name: samples_fk_rock_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples_archive
    ADD CONSTRAINT samples_fk_rock_type FOREIGN KEY (rock_type_id) REFERENCES rock_type(rock_type_id);


--
-- TOC entry 3459 (class 2606 OID 22848)
-- Dependencies: 277 3370 266 3479
-- Name: samples_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT samples_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3432 (class 2606 OID 22853)
-- Dependencies: 3353 267 267 244 244 3479
-- Name: samples_metgrade_archive_fk_samples; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metamorphic_grades_archive
    ADD CONSTRAINT samples_metgrade_archive_fk_samples FOREIGN KEY (sample_id, sample_version) REFERENCES samples_archive(sample_id, version);


--
-- TOC entry 3430 (class 2606 OID 22858)
-- Dependencies: 243 3260 204 3479
-- Name: samples_metgrade_fk_metgrade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metamorphic_grades
    ADD CONSTRAINT samples_metgrade_fk_metgrade FOREIGN KEY (metamorphic_grade_id) REFERENCES metamorphic_grades(metamorphic_grade_id);


--
-- TOC entry 3431 (class 2606 OID 22863)
-- Dependencies: 243 3351 266 3479
-- Name: samples_metgrade_fk_samples; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metamorphic_grades
    ADD CONSTRAINT samples_metgrade_fk_samples FOREIGN KEY (sample_id) REFERENCES samples(sample_id);


--
-- TOC entry 3435 (class 2606 OID 22868)
-- Dependencies: 3264 205 247 3479
-- Name: samples_metregion_fk_metregion; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metamorphic_regions
    ADD CONSTRAINT samples_metregion_fk_metregion FOREIGN KEY (metamorphic_region_id) REFERENCES metamorphic_regions(metamorphic_region_id);


--
-- TOC entry 3436 (class 2606 OID 22873)
-- Dependencies: 266 3351 247 3479
-- Name: samples_metregion_fk_samples; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metamorphic_regions
    ADD CONSTRAINT samples_metregion_fk_samples FOREIGN KEY (sample_id) REFERENCES samples(sample_id);


--
-- TOC entry 3466 (class 2606 OID 22878)
-- Dependencies: 3353 273 273 267 267 3479
-- Name: subsamples_archive_fk_sample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subsamples_archive
    ADD CONSTRAINT subsamples_archive_fk_sample FOREIGN KEY (sample_id, sample_version) REFERENCES samples_archive(sample_id, version);


--
-- TOC entry 3467 (class 2606 OID 22883)
-- Dependencies: 273 3357 270 3479
-- Name: subsamples_archive_fk_subsample_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subsamples_archive
    ADD CONSTRAINT subsamples_archive_fk_subsample_type FOREIGN KEY (subsample_type_id) REFERENCES subsample_type(subsample_type_id) ON DELETE CASCADE;


--
-- TOC entry 3463 (class 2606 OID 22888)
-- Dependencies: 3351 272 266 3479
-- Name: subsamples_fk_sample; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subsamples
    ADD CONSTRAINT subsamples_fk_sample FOREIGN KEY (sample_id) REFERENCES samples(sample_id);


--
-- TOC entry 3464 (class 2606 OID 22893)
-- Dependencies: 3357 270 272 3479
-- Name: subsamples_fk_subsample_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subsamples
    ADD CONSTRAINT subsamples_fk_subsample_type FOREIGN KEY (subsample_type_id) REFERENCES subsample_type(subsample_type_id);


--
-- TOC entry 3465 (class 2606 OID 22899)
-- Dependencies: 3370 272 277 3479
-- Name: subsamples_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subsamples
    ADD CONSTRAINT subsamples_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3468 (class 2606 OID 22904)
-- Dependencies: 274 277 3370 3479
-- Name: uploaded_files_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY uploaded_files
    ADD CONSTRAINT uploaded_files_fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 3469 (class 2606 OID 22909)
-- Dependencies: 201 3256 279 3479
-- Name: xray_image_fk_image; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY xray_image
    ADD CONSTRAINT xray_image_fk_image FOREIGN KEY (image_id) REFERENCES images(image_id);


-- Completed on 2013-02-26 12:06:55 EST

--
-- PostgreSQL database dump complete
--

