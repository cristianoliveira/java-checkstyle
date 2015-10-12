/**
 * Typical hello world example.
 * It has a good style.
 */
final class Good {
  /**
   * Prevent class from being instantiated.
   *
   * @throws AssertionError if some smart guy try.
   */
  public Good() {
    throw new AssertionError("Instantiating utility class...");
  }

  /**
   * Prints Hello World!
   *
   * @param args Command line arguments.
   */
  public static void main(final String[] args) {
    System.out.println("Hello World!");
  }
}
