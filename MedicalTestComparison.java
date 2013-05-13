import java.util.*;
/**
 * 
 * @author John Costantino
 * Date Edited: 2/24/2013
 * Program will take a list of data and compare the results returning a probability of
 * possibly outputs from the data.
 */

public class MedicalTestComparison 
{
  private double oneP,oneN,twoP,twoN,dOneP, dTwoP, hOneN,hTwoN;

	/**
	 * Constructor that instanciates the instance variables.
	 */
	public MedicalTestComparison()
	{
		oneP=0;
		oneN=0;
		twoP=0;
		twoN=0;
		dOneP=0;
		hOneN=0;
		dTwoP=0;
		hTwoN=0;
	}

	/**
	 * Method performs the computations and returns an output
	 * of the tests determining which if any is better.
	 * @param arr
	 */
	public void MedTest(ArrayList<String> arr)
	{
		compare(arr);
		double probDPosOne = ((dOneP)/oneP);
		double probDPosTwo = ((dTwoP)/twoP);
		double probHNegOne = ((hOneN)/oneN);
		double probHNegTwo = ((hTwoN)/twoN);

		System.out.println("P(D | Pos1) = " + probDPosOne);
		System.out.println("P(D | Pos2) = " + probDPosTwo);
		System.out.println("P(H | Neg1) = " + probHNegOne);
		System.out.println("P(H | Neg2) = " + probHNegTwo);

		if((probDPosOne > probDPosTwo) && (probHNegOne > probHNegTwo))
		{
			System.out.println("Test 1 is better");
		}
		else if((probDPosOne < probDPosTwo) && (probHNegOne < probHNegTwo))
		{
			System.out.println("Test 2 is better");
		}
		else
		{
			System.out.println("Neither test is better than the other");
		}
	}

	/**
	 * method takes in the array of strings and collects the information in it.
	 * Strings are tokenized and information is found based on a white space 
	 * delimiter.
	 * @param arr
	 */
	private void compare(ArrayList<String> arr)
	{
		for(int i = 0; i<arr.size(); i++)
		{	//First take an array that has a string of the numbers for the patients.
			//Then iterate through the string to pull each individual char and see what it is.
			String s = (arr.get(i));

			//if result is a 1 then patient is positive if 0 then patient is negative
			String[] tokens = s.split(" ");
			char posDiseased = tokens[1].charAt(0); //determines if diseased or not
			char posTestOne = tokens[2].charAt(0); //this is test 1 results
			char posTestTwo = tokens[3].charAt(0); //this is test 2 results

			if(posDiseased == '1' && posTestOne == '1')
			{
				dOneP++;
			}
			if(posDiseased == '1' && posTestTwo == '1')
			{
				dTwoP++;
			}
			if(posDiseased == '0' && posTestOne == '0')
			{
				hOneN++;
			}
			if(posDiseased =='0' && posTestTwo == '0')
			{
				hTwoN++;
			}			
			if(posTestOne == '1')
			{
				oneP++;
			}
			if(posTestOne == '0')
			{
				oneN++;
			}
			if(posTestTwo == '1')
			{
				twoP++;
			}
			if(posTestTwo == '0')
			{
				twoN++;
			}
		}
	}
}
