function [ vec_index ] = IndexMat2Vec( n, m, nrows )
%INDEXMAT2VEC  Translate matrix index to vector index.
%   INDEXMAT2VEC(n,m,nrows) Calculates the vector index to access
%   the same element is (n,m) index was used in a matrix.
%
%   Arguments:
%       n - Vector of row numbers
%       m - Vector of column number
%       nrows - The number of rows in the matrix
%   Output:
%       vec_index - Indecies of the (n,m) elements in an vector
%           representation
%
%   Written by Atriom Lapshin 2016

vec_index = (m-1)*nrows + n;

end

