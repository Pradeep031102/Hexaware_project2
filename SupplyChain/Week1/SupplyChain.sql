create database SupplyChain

CREATE TABLE Orders (
    OrderID BIGINT PRIMARY KEY,
    OrderDate DATE,
    OriginPort VARCHAR(10),
    Carrier VARCHAR(10),
    TPT INT,
    ServiceLevel VARCHAR(10),
    ShipAheadDayCount INT,
    ShipLateDayCount INT,
    Customer VARCHAR(50),
    ProductID INT,
    PlantCode VARCHAR(10),
    DestinationPort VARCHAR(10),
    UnitQuantity INT,
    Weight FLOAT
);

CREATE TABLE CarrierRates (
    Carrier VARCHAR(10),
    OriginPort VARCHAR(10),
    DestinationPort VARCHAR(10),
    MinWeightQuantity FLOAT,
    MaxWeightQuantity FLOAT,
    ServiceCode VARCHAR(10),
    MinimumCost FLOAT,
    Rate FLOAT,
    ModeDescription VARCHAR(10),
    TransportDayCount INT,
    CarrierType VARCHAR(20),
    PRIMARY KEY (Carrier, OriginPort, DestinationPort, MinWeightQuantity, MaxWeightQuantity)
);

CREATE TABLE PlantPorts (
    PlantCode VARCHAR(10),
    Port VARCHAR(10),
    PRIMARY KEY (PlantCode, Port)
);
CREATE TABLE PlantProducts (
    PlantCode VARCHAR(10),
    ProductID INT,
    PRIMARY KEY (PlantCode, ProductID)
);

CREATE TABLE PlantCustomers (
    PlantCode VARCHAR(10),
    Customer VARCHAR(50),
    PRIMARY KEY (PlantCode, Customer)
);

CREATE TABLE PlantCapacities (
    PlantCode VARCHAR(10),
    DailyCapacity INT,
    PRIMARY KEY (PlantCode)
);
CREATE TABLE PlantCosts (
    PlantCode VARCHAR(10),
    CostPerUnit FLOAT,
    PRIMARY KEY (PlantCode)
);

select * from CarrierRates