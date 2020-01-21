#include <RcppArmadillo.h>
#include <Rcpp.h>
using namespace Rcpp;
//[[Rcpp::depends(RcppArmadillo)]]
//[[Rcpp::export]]

arma::mat NA_data(NumericMatrix x, NumericMatrix y, NumericMatrix tmp) {
	arma::mat a = as<arma::mat>(x);
	arma::mat b = as<arma::mat>(y);
	arma::mat r_Means = as<arma::mat>(tmp);

	int nrow = a.n_rows;
	int ncol = a.n_cols;

	for (int i = 0; i < nrow; i++)
	{
		for (int j = 0; j < ncol; j++)
		{	
			if (a(i, j) == 0)
			{
				b(i, j) = r_Means(i);
			}
			else
			{
				b(i, j) = a(i, j);
			} 
		}
	}
	return b;
}