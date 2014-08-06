import Foundation

public class shutil {
    public class func copyFile(src: String, _ dst: String) {
        NSFileManager().copyItemAtPath(src, toPath: dst, error: nil)
    }

    public class func copyfile(src: String, _ dst: String) {
        return copyFile(src, dst)
    }
}
