# Algorithms stolen and modified, like all of my CS161 assignments, from https://www.geeksforgeeks.org/

import sys
import csv


def bubble_sort(arr):
    effort = 0

    n = len(arr)

	# Traverse through all array elements
    for i in range(n):

		# Last i elements are already in place
        for j in range(0, n-i-1):

			# traverse the array from 0 to n-i-1
			# Swap if the element found is greater
			# than the next element
            if arr[j] > arr[j+1]:
                effort = effort + 1
                arr[j], arr[j+1] = arr[j+1], arr[j]

    return effort


def insertion_sort(arr):

    effort = 0

    # Traverse through 1 to len(arr)
    for i in range(1, len(arr)):

        key = arr[i]

        # Move elements of arr[0..i-1], that are
        # greater than key, to one position ahead
        # of their current position
        j = i-1
        while j >= 0 and key < arr[j]:
            effort = effort + 1
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = key

    return effort


def selection_sort(A):
    effort = 0

    # Traverse through all array elements
    for i in range(len(A)):

        # Find the minimum element in remaining
        # unsorted array
        min_idx = i
        for j in range(i+1, len(A)):
            if A[min_idx] > A[j]:
                effort = effort + 1
                min_idx = j

        # Swap the found minimum element with
        # the first element
        A[i], A[min_idx] = A[min_idx], A[i]

    return effort


if __name__ == "__main__":
    with open(sys.argv[1], 'r') as f:
        reader = csv.reader(f)
        arr = list(reader)

    arr = arr[0]
    effort = bubble_sort(arr) + insertion_sort(arr) + selection_sort(arr)
    effort = effort / 3
    print ("Effort to sort the array: " + str(effort))
