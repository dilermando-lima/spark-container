package com.example.sparktest;

import java.util.Arrays;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;


public class App 
{
    public static void main( String[] args ){
   

        SparkConf conf = new SparkConf();
        //.setMaster("spark://sparkmaster:7077")
        // .set("spark.executor.memory", "512m")
        // .set("spark.driver.memory", "512m")
        //.setAppName("App23");

        JavaSparkContext sc = new JavaSparkContext(conf);

        JavaRDD<String> input = sc.parallelize( Arrays.asList("5.56", "6.28", "8.94"));

        JavaRDD<Double> numbers = input.map(numberString -> Double.valueOf(numberString));
        double finalSum = numbers.reduce((x,y) -> x+y);

        System.out.println("Final sum is: " + finalSum);

        sc.close();
        

    }
}
