DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL,
    g GEOMETRY AS (ST_GeometryFromText(CONCAT('POINT(', latitude, ' ', longitude, ')'))) STORED NOT NULL,
    SPATIAL INDEX (g)
);
CREATE INDEX estate_rent ON isuumo.estate (rent);
CREATE INDEX estate_door_height_rent on isuumo.estate (door_height, rent);
CREATE INDEX estate_door_width_rent on isuumo.estate (door_width, rent);
CREATE INDEX estate_door_height_width_rent on isuumo.estate (door_height, door_width, rent);
CREATE INDEX estate_popularity_id on isuumo.estate (popularity, id);
CREATE INDEX estate_laitiude_longitude on isuumo.estate (latitude, longitude);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL
);
CREATE INDEX chair_price_id ON isuumo.chair (price, id);
CREATE INDEX chair_price_stock ON isuumo.chair (price, stock);
CREATE INDEX chair_popularity_id_price ON isuumo.chair (popularity, id, price);
CREATE INDEX chair_height ON isuumo.chair (height);
CREATE INDEX chair_width ON isuumo.chair (width);
CREATE INDEX chair_kind_stock ON isuumo.chair (kind, stock);
CREATE INDEX chair_color_stock ON isuumo.chair (color, stock);
CREATE INDEX chair_height_stock ON isuumo.chair (height, stock);
